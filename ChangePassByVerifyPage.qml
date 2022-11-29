import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0


Page{
    property string string

    background: Rectangle {
        color: backGroundColor
    }

ColumnLayout {
    width: parent.width
    anchors.verticalCenter: parent.verticalCenter
    spacing: 15

    MyTextField {
        id: newPassTxt
        placeholderText: "New password"
        echoMode: TextField.Password
        }
    MyTextField {
        id: confirmNewPassTxt
        placeholderText: "Confirm new password"
        echoMode: TextField.Password

    }
    Item {
        height: 10
    }

    MyButton{
        height: 50
        Layout.alignment: Qt.AlignHCenter
        name: "Change password"
        baseColor: mainAppColor
        onClicked: {
            var result = usersdb.changePassByVerify(string, newPassTxt.text, confirmNewPassTxt.text)
            if(result === ""){
                popup.popMessage = "Password changed successfully!"
                popup.open()
                popupRec.color = popupBackGroundColor_success
                stackView.replace("LogInPage.qml")
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
        text: "Cancel"
        MouseArea{
            anchors.fill: parent
            onClicked:  stackView.replace("LogInPage.qml")
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
        }
    }

    }





}

