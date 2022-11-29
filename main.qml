import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.3
import backend 1.0

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 550
    height: 600
    title: qsTr("Login")

    property color backGroundColor : "#2f3942"
    property color mainAppColor: "#e0f4ff"
    property color linkTextColor: "#e0f4ff"
    property color mainTextColor: "#2f3942"
    property color popupBackGroundColor_error: "#cb0505"
    property color popupBackGroundColor_success: "#1E9CC4"
    property color popupTextColor: "#ffffff"
    property color mainAppColorSecond: "#8da1ba"

    FontLoader {
        id: fontAwesome
        source: "qrc:/fontawesome-webfont.ttf"
    }

    DB{
        id: usersdb
    }

    ColumnLayout{
        id: myLogo
        anchors.horizontalCenter: parent.horizontalCenter
        z: 2
        spacing: 5

        Text {
            id: logo
            text: "\uF1A9"
            font.pointSize: 35
            font.family: "fontawesome"
            color: mainAppColor
            //anchors.centerIn: parent
        }
        Text {
            text: "My Logo"
            font.pointSize: 12
            font.family: "fontawesome"
            color: mainAppColor
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


    Rectangle{
        id: mainFrame
        anchors.centerIn: parent
        width: parent.width - 180
        height: parent.height - 220
        color: "transparent"
        border.color: mainAppColor
        radius: 25
        z: 1
    }

    // Main stackview
    StackView{
        id: stackView
        focus: true
        anchors.fill: parent
    }
    // After loading show initial Login Page
    Component.onCompleted:  stackView.push("qrc:/LogInPage.qml")

    //Popup to show messages or warnings on the bottom postion of the screen
    Popup {
        id: popup
        property alias popMessage: message.text
        property color popColor

        background: Rectangle {
            id: popupRec
            implicitWidth: rootWindow.width
            implicitHeight: 60
        }
        y: (rootWindow.height - 60)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        Text {
            id: message
            anchors.centerIn: parent
            font.pointSize: 12
            color: popupTextColor
        }
        onOpened: popupClose.start()
    }

    MessageDialog {
        id: messageDialog
        title: "Database Error"
        icon: StandardIcon.Critical
        onAccepted: Qt.quit()
    }


    // Timer for Popup
    Timer {
        id: popupClose
        interval: 2000
        onTriggered: popup.close()
    }

}
