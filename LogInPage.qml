import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3

Page {

    property string username
    Keys.onReturnPressed: loginBtn.clicked()
    id: loginPage
    background: Rectangle {
        color: backGroundColor
    }


    ColumnLayout {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        anchors.topMargin: 0
        spacing: 15

        MyTextField {
            id: loginUsername
            placeholderText: qsTr("Username")
        }

        MyTextField {
            id: loginPassword
            placeholderText: qsTr("Password")
            echoMode: TextField.Password
        }

        MyButton{
            id: loginBtn
           // Layout.preferredWidth: loginPage.width - 380
            Layout.alignment: Qt.AlignHCenter
            name: "Login"
            baseColor: mainAppColor
            onClicked:{
                var result = usersdb.loginUser(loginUsername.text, loginPassword.text)
                if (result === ""){
                    username = loginUsername.text
                    stackView.push("qrc:/UserPanel.qml", {"username": username ,"email": usersdb.sendUserEmailToQML(loginUsername.text)});
                }
                else{
                    popup.popMessage = result
                    popup.open()
                    popupRec.color = popupBackGroundColor_error
                }
            }

        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            color: linkTextColor
            font.pixelSize: 12
            text: "Forget password?"
            MouseArea{
                anchors.fill: parent
                onClicked:  stackView.push("qrc:/ForgetPass.qml");
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }

        Item {
            height: 10
        }
        Text{
             Layout.alignment : Qt.AlignHCenter
            color: linkTextColor
            font.pixelSize: 10
            text: "OR not a member?"
        }
        Text{
            Layout.alignment : Qt.AlignHCenter
            color: linkTextColor
            font.pixelSize: 18
            text: "Sign up"
            MouseArea{
                anchors.fill: parent
                onClicked:  stackView.push("qrc:/CreateNewUser.qml")
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }

        }
    }



}
