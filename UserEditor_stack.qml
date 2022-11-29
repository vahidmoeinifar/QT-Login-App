import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import io.besmaklab.backend 1.0

Page {
    id: registerPage
    property string username
    property string loggedInUsername
    property string email
    property int row
   // property var roleListModel: usersdb.rolesList()

    background: Rectangle {
        color: backGroundColor
    }


    Text {
        id: signupText
        text: qsTr("Now you can edit the user.")
        font.pointSize: 24
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        color: mainTextCOlor
    }

    Item {
        id: mainContents
        width: parent.width
        height: parent.height *.3
        anchors.top: signupText.bottom
        anchors.topMargin: 10
        Text {
            id: detailstxt
            text: qsTr("username cannot change.")
            font.pointSize: 8
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 20
            color: mainAppColorSecond
        }
        TextField {
            id: usernametxt
            text: username
            width: parent.width - 20
            anchors.top: detailstxt.bottom
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            color: mainTextCOlor
            font.pointSize: 14
            font.family: "fontawesome"
            leftPadding: 108
            selectByMouse: true
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                radius: implicitHeight / 2
                color: "transparent"
                Text {
                    text: "Username:"
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainAppColorSecond
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
            id: emailtxt
            text: email
            width: parent.width - 20
            color: mainTextCOlor
            font.pointSize: 14
            font.family: "fontawesome"
            leftPadding: 70
            anchors.top: usernametxt.bottom
            anchors.topMargin: 10
            selectByMouse: true
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 50
                radius: implicitHeight / 2
                color: "transparent"
                Text {
                    text: "Email:"
                    font.pointSize: 14
                    font.family: "fontawesome"
                    color: mainAppColorSecond
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
        Text {
            id: roleTxt
            text: qsTr("Role: ") + "(Current role is: " + usersdb.rolesListByIndex(row) +")"
            font.pointSize: 14
            anchors.top: emailtxt.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            color: mainAppColorSecond
        }
        ComboBox {
            id: roleCombo
            height: 50
            width: parent.width - 30
            model: roleListModel
            anchors.top: roleTxt.bottom
            anchors.topMargin: 10
            visible: {
                if (username === loggedInUsername)
                    false
                else
                    true
            }
            anchors.horizontalCenter: parent.horizontalCenter
        }

        CButton{
            height: 50
            implicitWidth: parent.width - 20
            anchors.horizontalCenter: parent.horizontalCenter
            name: "Change password"
            baseColor: mainAppColor
            anchors.top: roleCombo.bottom
            anchors.topMargin: 30
            borderColor: mainAppColor
            onClicked: {
                changePassDialog.open()
                changePassDialog.username = username
            }
        }
    }
    Item {
        height: 50
    }

    CButton{
        id: applyBtn
        height: 50
        width: parent.width - 20
        anchors.horizontalCenter: parent.horizontalCenter
        name: "Apply"
        baseColor: mainAppColor
        borderColor: mainAppColor
        anchors.bottom: cancelBTN.top
        anchors.bottomMargin: 10
        onClicked: {
            var result = usersdb.editusers(row,usernametxt.text, emailtxt.text, roleCombo.currentIndex)
            if (result === "") {
                popup.popMessage = "User detailes updated successfully!"
                popup.open()
                popupRec.color = popupBackGroundColor_success
                stackView.pop()//("qrc:/UserEditor.qml", {"role": usersdb.sendUserRoleToQML(username)});
            }
            else{
                popup.popMessage = result
                popup.open()
                popupRec.color = popupBackGroundColor_error
            }


        }
    }
    CButton{
        id: cancelBTN
        height: 50
        width: parent.width - 20
        anchors.horizontalCenter: parent.horizontalCenter
        name: "Cancel"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        baseColor: "transparent"
        borderColor: mainAppColor
        onClicked: stackView.pop() // "qrc:/UserEditor.qml"

    }
    ChangePassPage{
        id: changePassDialog
    }

}

