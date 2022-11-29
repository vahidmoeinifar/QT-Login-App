import QtQuick 2.7
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0


Dialog {
    id: dialogChangePass
    property string username
    title: "Change password"
    contentItem: Rectangle {
        color: backGroundColor
        implicitWidth: 400
        implicitHeight: 350

        ColumnLayout {
            width: parent.width
            spacing: 10

            TextField {
                id: currentPassTxt
                placeholderText: "Current password"
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                color: mainTextCOlor
                font.pointSize: 14
                font.family: "fontawesome"
                leftPadding: 30
                selectByMouse: true
                echoMode: TextField.Password
                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 50
                    radius: implicitHeight / 2
                    color: "transparent"

                    Text {
                        text: "\uf023"
                        font.pointSize: 14
                        font.family: "fontawesome"
                        color: mainAppColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }

                    Rectangle {
                        width: parent.width - 10
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        color: mainAppColor
                    }
                }
            }

            TextField {
                id: newPassTxt
                placeholderText: "New password"
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                color: mainTextCOlor
                font.pointSize: 14
                font.family: "fontawesome"
                leftPadding: 30
                selectByMouse: true
                echoMode: TextField.Password

                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 50
                    radius: implicitHeight / 2
                    color: "transparent"
                    Text {
                        text: "\uf023"
                        font.pointSize: 14
                        font.family: "fontawesome"
                        color: mainAppColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }

                    Rectangle {
                        width: parent.width - 10
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        color: mainAppColor
                    }
                }
            }

            TextField {
                id: confirmNewPassTxt
                placeholderText: "Confirm new password"
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                color: mainTextCOlor
                font.pointSize: 14
                font.family: "fontawesome"
                leftPadding: 30
                selectByMouse: true
                echoMode: TextField.Password

                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 50
                    radius: implicitHeight / 2
                    color: "transparent"
                    Text {
                        text: "\uf023"
                        font.pointSize: 14
                        font.family: "fontawesome"
                        color: mainAppColor
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }

                    Rectangle {
                        width: parent.width - 10
                        height: 1
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottom: parent.bottom
                        color: mainAppColor
                    }
                }
            }

            Item {
                height: 10
            }

            MyButton{
                height: 50
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                name: "Change password"
                baseColor: mainAppColor
                onClicked: {
                    var result = usersdb.changepass(username, currentPassTxt.text, newPassTxt.text, confirmNewPassTxt.text)
                    if(result === ""){
                        popup.popMessage = "Password changed successfully!"
                        popup.open()
                        popupRec.color = popupBackGroundColor_success
                        reset()
                        dialogChangePass.close()
                    }
                    else{
                        popup.popMessage = result
                        popup.open()
                        popupRec.color = popupBackGroundColor_error
                    }
                }

        }

            MyButton{
                height: 50
                Layout.preferredWidth: parent.width - 20
                Layout.alignment: Qt.AlignHCenter
                name: "Cancel"
                baseColor: "transparent"
                onClicked: {
                    reset()
                    dialogChangePass.close()

                }

            }
        }

    }

    function reset(){
         currentPassTxt.text = ""
         newPassTxt.text = ""
         confirmNewPassTxt.text = ""
    }
}
