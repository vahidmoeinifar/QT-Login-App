import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1
//import QtQuick.Dialogs 1.3

Page {
    id: dialogNewUser
    title: "Create New User"

    contentItem: Rectangle {
        color: backGroundColor
        implicitWidth: 400
        implicitHeight: 450

        ColumnLayout {
            width: parent.width
            spacing: 10
            anchors.centerIn: parent

            MyTextField {
                id: registerUsernameTxt
                placeholderText: qsTr("Username")
            }

            MyTextField {
                id: registerPasswordTxt
                placeholderText: qsTr("Password")
            }
            MyTextField {
                id: registerPassword2Txt
                placeholderText: qsTr("Confirm Password")
            }

            MyTextField {
                id: emailTxt
                placeholderText: qsTr("Email")
            }

            Item {
                height: 5
            }

            MyButton{
                Layout.alignment: Qt.AlignHCenter
                name: "Sign up"
                baseColor: mainAppColor
                onClicked: {
                    var result = usersdb.registerNewUser(registerUsernameTxt.text, registerPasswordTxt.text, registerPassword2Txt.text, emailTxt.text) // roleId 2 is a non-admin role
                        if (result === ""){
                            popup.popMessage = "New user created."
                            popup.open()
                            popupRec.color = popupBackGroundColor_success
                            stackView.push("qrc:/LogInPage.qml")
                        }
                        else{
                            popup.popMessage = result
                            popup.open()
                            popupRec.color = popupBackGroundColor_error
                        }
                    }
            }


            Text{
                Layout.alignment : Qt.AlignHCenter
                color: linkTextColor
                font.pixelSize: 18
                text: "Back"
                MouseArea{
                    anchors.fill: parent
                    onClicked:  stackView.pop()
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                }
            }

        }
    }


}


