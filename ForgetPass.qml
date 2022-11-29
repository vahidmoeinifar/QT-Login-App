import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1


Page {

    background: Rectangle {
        color: backGroundColor
    }



          ColumnLayout {
              width: parent.width
              anchors.verticalCenter: parent.verticalCenter
              spacing: 15

              MyTextField {
                  id: stringTxt
                  placeholderText: qsTr("Enter your email or username")
                  Layout.alignment: Qt.AlignHCenter

              }

              Item {
                  height: 20
              }

              MyButton{
                  id: retrieveBtn
                  Layout.alignment: Qt.AlignHCenter
                  Layout.preferredWidth: parent.width - 260
                  name: "Send Verification Code"
                  baseColor: mainAppColor
                  onClicked:{
                     var result = usersdb.retrievePass(stringTxt.text)
                      if (result === "") {
                          stackView.replace("RetrievePassPage.qml",{"string":stringTxt.text})
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
                  text: "Back"
                  MouseArea{
                      anchors.fill: parent
                      onClicked:  stackView.pop()
                      hoverEnabled: true
                      cursorShape: Qt.PointingHandCursor
                  }
              }

          }




  }
