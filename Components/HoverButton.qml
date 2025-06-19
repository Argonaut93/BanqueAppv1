// components/HoverButton.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root
    property color defaultColor: "#ffffff"
    property color hoverColor: "#d0e6ff"
    property color textColor: "#2c3e50"
    property color borderColor: "#3498db"
    property int radius: 12

    background: Rectangle {
        id: bg
        anchors.fill: parent
        radius: root.radius
        color: bgMouseArea.containsMouse ? root.hoverColor : root.defaultColor
        border.color: root.borderColor
        border.width: 1

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }

    contentItem: Text {
        text: root.text
        anchors.centerIn: parent
        font.bold: true
        color: root.textColor
    }

    MouseArea {
        id: bgMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
