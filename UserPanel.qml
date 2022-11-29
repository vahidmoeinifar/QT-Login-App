import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Page {
    id: registerPage
    property string username
    property string email

    background: Rectangle {
        color: backGroundColor
    }

ColumnLayout{
    anchors.centerIn: parent
    spacing: 10
    Text {
        text: qsTr("Wellcome")
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        color: mainAppColor
    }
    Text {
        text: username
        font.pointSize: 24
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        color: mainAppColor
    }
    Text {
        text: "Your email: " + email
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        color: mainAppColor
    }
}
    MyButton{
        id: cancelBTN
        width: parent.width - 180
        anchors.horizontalCenter: parent.horizontalCenter
        name: "Log out"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        baseColor: mainAppColor
        onClicked: stackView.push("qrc:/LogInPage.qml")
    }

}

