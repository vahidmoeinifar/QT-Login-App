import QtQuick 2.6
import QtQuick.Controls 2.0

Button {
    id: control
    text: qsTr("Log In")
    font.pointSize: 14

    property alias name: control.text
    property color baseColor

    width: 90
    height: 40
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#ffffff" : "mainTextColor"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: bgrect
        implicitWidth: 200
        implicitHeight: 45
        color: baseColor
        opacity: control.down ? 0.7 : 1
        radius: height/2
    }
}
