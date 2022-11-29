import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1

Page {
    background: Rectangle {
        color: backGroundColor
    }

    property int countdown: 60
    property string string

    Timer {
        id: timer
        interval: 1000
        running: countdown > 0
        repeat: true
        onTriggered: countdown--
    }

    Rectangle{
        id: timerBorder
        width: 69
        height: width
        radius: 23
        color: "transparent"
        border.color: mainAppColorSecond
        border.width: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 130
            Text {
            id: time
            anchors.centerIn: parent
            font.pixelSize: 35
            //font.bold: true
            color: mainAppColorSecond
            text: countdown
        }
    }

    ColumnLayout {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10

        MyTextField {
            id: stringTxt
            placeholderText: qsTr("Verification code")
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            height: 20
        }

        MyButton{
            id: retrieveBtn
            Layout.alignment: Qt.AlignHCenter
            name: "Verify"
            baseColor: mainAppColor
            onClicked:{

                if (usersdb.verifyCode(stringTxt.text))
                  stackView.push("ChangePassByVerifyPage.qml", {"string":string})

                else{
                    popup.popMessage = "Verify code is not true."
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
                onClicked:  stackView.replace("LogInPage.qml")
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

}
