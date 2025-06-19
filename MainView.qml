import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 420
    height: 640
    title: "Ma Banque sécurisée"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/LoginPage.qml"
    }
}