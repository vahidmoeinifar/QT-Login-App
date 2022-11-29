import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
//import QtQuick.LocalStorage 2.0

Page {
    id: assingRolePage
    property string username
    property string roleId
    property string email

    background: Rectangle {
        color: backGroundColor
    }

    header: ToolBar {
        background:
            Rectangle {
            implicitHeight: 50
            implicitWidth: 200
            color: "transparent"
        }

        RowLayout {
            anchors.fill: parent
            Item { Layout.fillWidth: true }
            ToolButton {
                id: control
                font.family: "fontawesome"
                text: qsTr("\uf08b")
                font.pointSize: 30
                rightPadding: 10
                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: mainTextCOlor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
                onClicked: stackView.replace("qrc:/LogInPage.qml")
            }

        }
    }
    Text {
        id: welcometext
        width: 160
        height: 105
        text:{
            if (roleId === "0")
            "Welcome. You logged in as admin."
            else
            "Welcome. You logged in as default user."
        }
        anchors.verticalCenterOffset: -155
        anchors.horizontalCenterOffset: 0
        anchors.centerIn: parent
        font.pointSize: 10
        color: mainTextCOlor
    }
    CButton{
        id: adminEditBtn
        visible: true
        anchors.top: parent.bottom
        anchors.horizontalCenterOffset: 0
        anchors.topMargin: -138
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.preferredWidth: parent.width - 20
        Layout.alignment: Qt.AlignHCenter
        name: {
            if (roleId === "0")
            "Admin Panel"
            else
            "User Panel"

        }
        width: parent.width -20
        height: 50
        baseColor: mainAppColor
        borderColor: mainAppColor
        onClicked: {
            if (roleId === "0")
                stackView.replace("qrc:/AdminPanel.qml", {"username": username, "roleId": roleId})

            else
            {
                stackView.replace("qrc:/UserPanel.qml", {
                                      "lastusername": username,
                                      "username": username,
                                      "email": usersdb.sendUserEmailToQML(username),
                                      //"roleId": usersdb.sendUserRoleToQML(username)
                                  })
            }
        }
    }
}
