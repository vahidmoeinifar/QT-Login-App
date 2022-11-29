import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1


TextField {
    Layout.preferredWidth: parent.width - 240
    Layout.alignment: Qt.AlignHCenter
    color: mainAppColor
    font.pointSize: 12
    font.family: "fontawesome"
    leftPadding: 20

    selectByMouse: true
    background: Rectangle {
        implicitWidth: 180
        implicitHeight: 45
        radius: implicitHeight / 2
        color: "transparent"
        border.color: mainAppColor



    }
}
