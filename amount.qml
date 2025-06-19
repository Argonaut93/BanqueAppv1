import QtQuick 2.15
import QtQuick.Controls 2.15


Page{
    property string currentUser
    anchors.fill: parent
    id:amountPage
    signal valueEntered (string value)//signal personalisé
    Column{
        anchors.centerIn: parent
        spacing : 20
        Text{
            text:"Entrer le montant"
        }
        TextField{
            id:montant
            placeholderText: "Montant en euros"
        }
        Button{
            text:"Enter"
            onClicked: {

                valueEntered(montant.text)
                stackView.pop()
            }
        }
    }

}




