#include "db.h"
#include <QtDebug>
#include <QtSql>
#include <QSqlRelationalTableModel>
#include <QSqlTableModel>
#include <QRandomGenerator>
#include <QDate>

DB::DB(QObject *parent):QObject(parent)
{
    createDB();
}

QString DB::createDB() // to create the databasegg and table
{
    if (!QSqlDatabase::drivers().contains("QSQLITE"))
        return "Unable to load database. This App needs the SQLITE driver";
    else{
        QSqlDatabase dbconn = QSqlDatabase::addDatabase("QSQLITE");
        dbconn.setDatabaseName(qApp->applicationDirPath() + "/liDB.db");

        if (!dbconn.open("","test"))
            qDebug() << "Can not open connection: " << dbconn.lastError().driverText();


        QSqlQuery query(dbconn);
        query.exec("CREATE TABLE IF NOT EXISTS UserDetails (userId INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,"
                   "username TEXT UNIQUE, password TEXT, email TEXT UNIQUE)");

        m_modelUserDetails = new QSqlRelationalTableModel(this, dbconn);
        m_modelUserDetails->setTable("UserDetails");
        m_modelUserDetails->setEditStrategy(QSqlRelationalTableModel::OnManualSubmit);
        m_modelUserDetails->select();
        m_modelUserDetails->setHeaderData(1, Qt::Horizontal, tr("Username"));
        m_modelUserDetails->setHeaderData(4, Qt::Horizontal, tr("Email"));
        //dbconn.close();
        return "";
    }
}

QString DB::registerNewUser(QString uname, QString pword, QString pword2, QString email) // to create new user
{

    QString hashedPass = hashFunction(pword);
    QString ret = validateRegisterCredentials(uname, pword, pword2, email);
    if ("" == ret){
        QSqlQuery queryInsert;
        queryInsert.prepare("INSERT INTO UserDetails (username, password, email) VALUES(? ,? ,? )");
        queryInsert.bindValue(0, uname);
        queryInsert.bindValue(1, hashedPass);
        queryInsert.bindValue(2, email);
        queryInsert.exec();

        if ( queryInsert.next())
            return "";
         else
            return m_modelUserDetails->lastError().text();
    }
    else
        return ret;
}

bool DB::validateEmail(QString email) // to validate  email format
{
    QRegularExpression regex ("(\\w+)(\\.|_)?(\\w*)@(\\w+)(\\.(\\w+))+");
    if(!regex.match(email).hasMatch())
        return false;
    else
        return true;
}

bool DB::validateUsername(QString name) // to validate  user name and role name format
{
    QRegularExpression regex ("[a-zA-Z0-9]+([_ -]?[a-zA-Z0-9]){2,16}$");
    if (!regex.match(name).hasMatch())
        return false;
    else
        return true;
}

bool DB::validatePassword(QString pass) // to check password format. The password must be 8-16 characters, and include at least a number.
{
    QRegularExpression regex("^(?=.*[0-9])[a-zA-Z0-9!@#$%^&*]{6,16}$");
    if (!regex.match(pass).hasMatch())
        return false;
    else
        return true;
}

QString DB::validateRegisterCredentials(QString uname, QString pword, QString pword2, QString email) // to check the user credentials when registering
{
    QSqlQuery queryUser;
    queryUser.prepare("SELECT * FROM UserDetails WHERE username=?");
    queryUser.bindValue(0,uname);
    queryUser.exec();
    queryUser.next();

    QSqlQuery queryEmail;
    queryEmail.prepare("SELECT * FROM UserDetails WHERE email=?");
    queryEmail.bindValue(0, email);
    queryEmail.exec();

    if (uname == "" || pword == "" || pword2 == "" || email == "")
        return  "Missing credentials!";
    else if (queryUser.first())
        return "Username is already exists.";
    else if (pword != pword2)
        return "Password does not match!";
    else if (!validatePassword(pword))
        return "Your password must be 6-16 characters, and include at least a number.";
    else if (!validateEmail(email))
        return "Your email is not a valid email.";
    else if (!validateUsername(uname))
       return "Your username is not a valid username. Username must be at least 3 characters.";
    else if (queryEmail.next())
            return "Email address has already taken. Try another one.";
    else
       return "";
}

QString DB::validateChangePass(QString currentPassInDB, QString currentPass, QString hashedPword, QString pword, QString pword2) // to check the correctness of passwords
{
    if (currentPass == "" || pword == "" || pword2 == "")
        return "Missing credentials!";
    else if (pword != pword2)
        return "Password does not match!";
    else if (validatePassword(pword) == false)
        return "Your password must be at least 6 characters, and include at least a number.";
    else if ( currentPass != currentPassInDB)
        return "Current password is not correct!";
    else if ( hashedPword == currentPassInDB)
        return "Your new password must be different from current password.";
    else
        return "";

}

QString DB::hashFunction(QString pword) //the hash function for password
{
    QString hashedPass = QString("%1").arg(QString(QCryptographicHash::hash(pword.toUtf8(),QCryptographicHash::Sha256).toHex()));
    return hashedPass;
}

QString DB::retrievePass(QString string) // the proccess of retrieve password by email or username
{
    QString rand = QString::number(randomPassCode());

    if (validateEmail(string)){
        QSqlQuery query;
        query.prepare("SELECT * FROM UserDetails WHERE email=?");
        query.bindValue(0, string);
        query.exec();
        if (query.next()){
            qDebug()<< "passcode: "<< rand;  // send an email with pass code to it
            m_passCode = rand;
            return "";
        }
        else
            return "This email does not belong to any user.";

    }
    else{
        QSqlQuery query;
        query.prepare("SELECT username FROM UserDetails WHERE username=?");
        query.bindValue(0, string);
        query.exec();
        if (query.next()){
            qDebug()<< "passcode: "<< rand;   // send an email with pass code to it
            m_passCode = rand;
            return "";
        }
        else{
            return "This username does not exist.";
        }
    }

}

bool DB::verifyCode(QString verifyCode) // to check if the entered passcode is correct.
{
    if (verifyCode == m_passCode)
        return true;
    else
        return false;
}

QString DB::changePassByVerify(QString string, QString newPass, QString newPass2) // to change password by verify code
{
    QString hashedNewPass = hashFunction(newPass);

    if (newPass == "" || newPass2 == "")
        return "Missing credentials!";
    else if (newPass != newPass2)
        return "Password does not match!";
    else if (validatePassword(newPass) == false)
        return "Your password must be at least 6 characters, and include at least a number.";

    if (validateEmail(string)){
        QSqlQuery queryUpdate;
        queryUpdate.prepare("UPDATE UserDetails SET password=? WHERE email=?");
        queryUpdate.bindValue(0, hashedNewPass);
        queryUpdate.bindValue(1, string);
        if (queryUpdate.exec())
            return "";
        else
            return "Password does not set.";
    }

    else{
        QSqlQuery queryUpdateByUser;
        queryUpdateByUser.prepare("UPDATE UserDetails SET password=? WHERE username=?");
        queryUpdateByUser.bindValue(0, hashedNewPass);
        queryUpdateByUser.bindValue(1, string);
        if (queryUpdateByUser.exec())
            return "";
        else
            return "Password does not set.";
    }
}

qint16 DB::randomPassCode() // random code generator between 1000 and 9999 to use as verify code
{
    quint16 passCode = QRandomGenerator::global()->bounded(1000, 9999);
    return passCode;
}


QString DB::loginUser(QString uname, QString pword) // to login a user
{
    m_modelUserDetails->submitAll(); // to refresh the model
    QString hashedpass = hashFunction(pword);

    QSqlQuery queryPass;
    queryPass.prepare("SELECT password FROM UserDetails WHERE username=?");
    queryPass.bindValue(0,uname);
    queryPass.exec();
    queryPass.next();

    QSqlQuery queryRole;
    queryRole.prepare("SELECT roleId FROM UserDetails WHERE username=?");
    queryRole.bindValue(0,uname);
    queryRole.exec();
    queryRole.next();

    if (uname == "" || pword == "")
        return "Missing credentials!";

    else if (!queryPass.first())
        return "User not registered!";

    else if (queryPass.value(0).toString() != hashedpass)
        return "Invalid credentials!";

    else
        return "";
}


QString DB::sendUserEmailToQML(QString username) // to send email by username
{
    QSqlQuery query;
    query.prepare("SELECT email FROM UserDetails WHERE username=?");
    query.bindValue(0,username);
    query.exec();
    if (query.next())
        return query.value(0).toString();
    else
        return (query.lastError().text());
}

