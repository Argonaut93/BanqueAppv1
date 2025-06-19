import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    id: historyPage
    title: "Historique bancaire"

    // Données simulées
    ListModel {
        id: transactionModel

        ListElement { date: "2003-10-14"; description: "Payroll Deposit - HOTEL"; ref: ""; withdrawal: ""; deposit: "694.81"; balance: "695.36" }
        ListElement { date: "2003-10-14"; description: "Web Bill Payment - MASTERCARD"; ref: "9685"; withdrawal: "200.00"; deposit: ""; balance: "495.36" }
        ListElement { date: "2003-10-16"; description: "ATM Withdrawal - INTERAC"; ref: "3990"; withdrawal: "21.25"; deposit: ""; balance: "474.11" }
        // Ajoute autant que nécessaire
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Text {
            text: "Historique de votre compte"
            font.pixelSize: 24
            Layout.alignment: Qt.AlignHCenter
        }

        TableView {
            id: table
            Layout.fillWidth: true
            Layout.fillHeight: true
            columnSpacing: 2
            rowSpacing: 2
            clip: true

            model: transactionModel

            delegate: Rectangle {
                implicitHeight: 30
                implicitWidth: 100
                color: styleData.row % 2 === 0 ? "#f5f5f5" : "white"
                border.color: "#cccccc"

                Text {
                    text: styleData.value
                    anchors.centerIn: parent
                    font.pixelSize: 14
                }
            }

            TableViewColumn { role: "date"; title: "Date"; width: 100 }
            TableViewColumn { role: "description"; title: "Description"; width: 220 }
            TableViewColumn { role: "ref"; title: "Ref."; width: 70 }
            TableViewColumn { role: "withdrawal"; title: "Retraits"; width: 80 }
            TableViewColumn { role: "deposit"; title: "Dépôts"; width: 80 }
            TableViewColumn { role: "balance"; title: "Solde"; width: 80 }
        }
    }
}
