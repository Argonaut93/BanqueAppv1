import QtQuick 2.15
import QtQuick.Controls 2.15
import "."
Page {
    property string currentUser
    id:dashboardpage
    /*Component{
        id:childAmountPage
        Amount {
          onvalueEntered:function (val) =>   {

            }
            onValueEntered: function(val) {
            console.log("Montant saisi :", val)
            dbManager.addTransaction(currentUser, "depot", parseFloat(val))
            listView.model = dbManager.getTransactions(currentUser)
            balanceLabel.text = "Solde: " + dbManager.getBalance(currentUser).toFixed(2) + " €"
        }
    }*/

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: "Bienvenue " + currentUser
            font.pixelSize: 22
        }

        Text {
            id: balanceLabel
            text: "Solde: " + dbManager.getBalance(currentUser).toFixed(2) + " €"
            font.pixelSize: 20
        }

        Row {
            spacing: 10
            Button {
                text: "Dépôt "

                onClicked: {

                    var component = Qt.createComponent(Qt.resolvedUrl("Amount.qml"))//creation de la page dynamiquement pour une utilisation mémoire plus faible car la page sera chargé ssi on en a besoin
                    if (component.status === Component.Ready) {
                        var item = component.createObject(stackView, { currentUser: username.txt })//pq dashboardpage a la place de stackView ??
                        if (item !== null) {
                            item.valueEntered.connect(function(val){

                            console.log("valeur recu",val)
                            dbManager.addTransaction(currentUser, "depot", val)
                            listView.model = dbManager.getTransactions(currentUser)
                            balanceLabel.text = "Solde: " + dbManager.getBalance(currentUser).toFixed(2) + " €"
                            }
                                )
                            stackView.push(item)//pq stackView a la place de dashboard
                        } else {
                            console.log("Erreur lors de la création de l'objet :", component.errorString())
                        }
                    } else if (component.status === Component.Error) {
                        console.log("Erreur de chargement du composant :", component.errorString())//n'arrive  pas a charger si le composant contient une erreur de syntaxe
                    }
                    //stackView.push({ item: Qt.resolvedUrl("amount.qml"), properties: { currentUser: currentUser } })

                }
            }
            Button {
                text: "Retrait en €"
                onClicked: {
                    var component = Qt.createComponent(Qt.resolvedUrl("Amount.qml"))//creation de la page dynamiquement pour une utilisation mémoire plus faible car la page sera chargé ssi on en a besoin
                    if (component.status === Component.Ready) {
                        var item = component.createObject(stackView, { currentUser: username.txt })//pq dashboardpage a la place de stackView ??
                        if (item !== null) {
                            item.valueEntered.connect(function(val){

                            console.log("valeur recu",val)
                                dbManager.addTransaction(currentUser, "retrait", val)
                                listView.model = dbManager.getTransactions(currentUser)
                                balanceLabel.text = "Solde: " + dbManager.getBalance(currentUser).toFixed(2) + " €"
                            }
                                )
                            stackView.push(item)//pq stackView a la place de dashboard
                        } else {
                            console.log("Erreur lors de la création de l'objet :", component.errorString())
                        }
                    } else if (component.status === Component.Error) {
                        console.log("Erreur de chargement du composant :", component.errorString())//n'arrive  pas a charger si le composant contient une erreur de syntaxe
                    }
                    //stackView.push({ item: Qt.resolvedUrl("amount.qml"), properties: { currentUser: currentUser } })

                }

            }
            Button {
                text: "Historique"
                onClicked: {
                    var component = Qt.createComponent(Qt.resolvedUrl("Historique.qml"))//creation de la page dynamiquement pour une utilisation mémoire plus faible car la page sera chargé ssi on en a besoin
                    if (component.status === Component.Ready) {
                        var item = component.createObject(stackView, { currentUser: username.txt })//pq dashboardpage a la place de stackView ??
                        if (item !== null) {
                            stackView.push(item)//pq stackView a la place de dashboard
                        } else {
                            console.log("Erreur lors de la création de l'objet :", component.errorString())
                        }
                    } else if (component.status === Component.Error) {
                        console.log("Erreur de chargement du composant :", component.errorString())//n'arrive  pas a charger si le composant contient une erreur de syntaxe
                    }
                    //stackView.push({ item: Qt.resolvedUrl("amount.qml"), properties: { currentUser: currentUser } })

                }

            }
        }

        /*ListView {
            id: listView
            width: 350
            height: 220
            model: dbManager.getTransactions(currentUser)
            delegate: Text { text: modelData }
        }*/

        Row {
            spacing: 10
            Button {
                text: "Paramètres"
                onClicked: stackView.push({ item: Qt.resolvedUrl("SettingsPage.qml"), properties: { currentUser: currentUser } })
            }
            Button {
                text: "Déconnexion"
                onClicked: stackView.pop(stackView.depth - 1)
            }
        }
    }
}
