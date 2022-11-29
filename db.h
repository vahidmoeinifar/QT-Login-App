#ifndef DB_H
#define DB_H

#include <QObject>
#include <qqml.h>
#include <QtSql>

class QSqlTableModel;

class DB : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    QSqlRelationalTableModel *m_modelUserDetails;


public:
    explicit DB(QObject *parent = nullptr);
    QString m_passCode;

public slots:

    QString createDB();
    QString sendUserEmailToQML(QString username);
    bool validateUsername(QString username);
    QString registerNewUser(QString uname, QString pword, QString pword2, QString email);
    bool validateEmail(QString email);
    bool validatePassword(QString pass);
    QString validateRegisterCredentials(QString uname, QString pword, QString pword2, QString email);
    QString validateChangePass(QString currentPassInDB, QString currentPass, QString hashedPword, QString pword, QString pword2);
    QString hashFunction(QString pass);
    QString retrievePass(QString string);
    bool verifyCode(QString verifyCode);
    QString changePassByVerify(QString string, QString newPass, QString newPass2);
    qint16 randomPassCode();
    QString loginUser(QString uname, QString pword);
};

#endif // DB_H

