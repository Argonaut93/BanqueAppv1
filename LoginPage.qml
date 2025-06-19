import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    property string currentUser: ""

    Column {
        anchors.centerIn: parent
        spacing: 16
       /* Rectangle {
            anchors.fill: parent
            color: "#f3f4f6"
            Text {
                anchors.centerIn: parent
                text: "Bienvenue dans Ma Banque"
                font.pixelSize: 28
                color: "#111827"
            }
        }*/

        Text {
            text: "Connexion"
            font.pixelSize: 26
        }

        TextField {
            id: username
            placeholderText: "Nom d'utilisateur"
            width: 220
            background: Rectangle {
                   radius: 10      // 🌟 Coins arrondis
                   color: "white"
                   border.color: "#cccccc"
                   border.width: 1
               }

            padding: 10
        }
        TextField {
            id: password
            placeholderText: "Mot de passe"
            background: Rectangle {
                   radius: 10      // 🌟 Coins arrondis
                   color: "white"
                   border.color: "#cccccc"
                   border.width: 1
               }

               padding: 20
            echoMode: TextInput.Password
            width: 220
        }
        Button {
            text: "Se connecter"
            width: 220
            onClicked: {
                if (dbManager.loginUser(username.text, password.text)) {
                    currentUser = username.text
                    message.text = "Identification successful"
                    //creation de la DashboardPage.qml dynamiquement car impossible de la push en tant qu'objet à double clefs ds cette version QT
                    var component = Qt.createComponent("DashboardPage.qml");
                    if (component.status === Component.Ready) {
                        var page = component.createObject(stackView, { currentUser: username.text });
                        if (page !== null) {
                            stackView.push(page); // 2. Empiler la page créée dynamiquement
                        }
                        else {
                            console.log("Erreur : échec de la création de la page.");
                        }
                    }
                    else {
                        console.log("Erreur : composant non prêt.");
                    }
                    //creation de la DashboardPage.qml dynamiquement car impossible de la push en tant qu'objet à double clefs ds cette version QT

                    //stackView.push({ item: Qt.resolvedUrl("DashboardPage.qml"), properties: { currentUser: username.text } })//marche pas ds cette version QT

                } else {
                    message.text = "Identifiants incorrects"
                }
            }
            background: Rectangle {
                   radius: 10      // 🌟 Coins arrondis
                   //color: "white"
                   border.color: "#cccccc"
                   border.width: 1
                   color:hoverArea.containsMouse ? "red" : "lightgray"
                   //color: baseColor
                   MouseArea{
                       id:hoverArea//??
                       anchors.fill: parent //??
                       hoverEnabled: true
                       /*onEntered: baseColor = "red"
                       onExited: baseColor = "lightgray"*/

                       //color:hoverArea.containsMouse ? "lightblue" : "lightgray"
                       //ColorAnimation { duration: 200 }
                    }
                    /*Behavior on baseColor{
                       ColorAnimation { duration: 200 }
                   }*/
               }

               padding: 10

        }
        Button {
            text: "Créer un compte"
            width: 220
            onClicked: {
                stackView.push("newAccount.qml");

            }
            background: Rectangle {
                   radius: height / 2    // 🌟 Coins arrondis
                   color: "white"
                   border.color: "#cccccc"
                   border.width: 1
               }

               padding: 10
        }
        Text {
            id: message
            color: "red"
        }
    }
}
