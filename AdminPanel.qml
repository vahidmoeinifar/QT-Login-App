import QtQuick 2.7
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3
import io.besmaklab.backend 1.0

Page {
    id: assignRolesPage

   // property int roleId
    property string username


    height: assignRolesPage.height
    background: Rectangle {
        color: backGroundColor
    }
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

    Text {
        id: signupText
        text: qsTr("Admin Panel")
        font.pointSize: 24
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        color: mainTextCOlor
    }

    Item {
        id: itemlayout
        width: parent.width
        anchors.top: signupText.bottom
        anchors.horizontalCenter: parent.horizontalCenter


        MyButton{
            height: 50
            Layout.preferredWidth: itemlayout.width - 20
            Layout.alignment: Qt.AlignHCenter
            width: itemlayout.width - 20
            name: "User Editor"
            baseColor: mainAppColor
            borderColor: mainAppColor
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 130

            onClicked: stackView.push("qrc:/UserEditor.qml", {"username" : username})

        }

        MyButton{
            height: 50
            Layout.preferredWidth: itemlayout.width - 20
            Layout.alignment: Qt.AlignHCenter
            width: itemlayout.width - 20
            name: "Create new user"
            baseColor: mainAppColor
            borderColor: mainAppColor
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 240

            onClicked: dialogNewUser.open()
        }
    }
    CreateNewUser{
        id: dialogNewUser
    }
}
