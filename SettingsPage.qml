import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    property string currentUser

    Column {
        anchors.centerIn: parent
        spacing: 16

        Text { text: "Paramètres du compte"; font.pixelSize: 24 }

        // Changement de mot de passe
        TextField { id: oldPass; placeholderText: "Ancien mot de passe"; echoMode: TextInput.Password; width: 220 }
        TextField { id: newPass; placeholderText: "Nouveau mot de passe"; echoMode: TextInput.Password; width: 220 }
        Button {
            text: "Changer le mot de passe"
            width: 220
            onClicked: {
                if (dbManager.changePassword(currentUser, oldPass.text, newPass.text)) {
                    feedback.text = "Mot de passe mis à jour"
                } else {
                    feedback.text = "Ancien mot de passe incorrect"
                }
            }
        }

        Rectangle { width: 200; height: 1; color: "#cccccc" }

        // Suppression de compte
        TextField { id: delPass; placeholderText: "Mot de passe"; echoMode: TextInput.Password; width: 220 }
        Button {
            text: "Supprimer mon compte"
            width: 220
            onClicked: {
                if (dbManager.deleteUser(currentUser, delPass.text)) {
                    stackView.pop(stackView.depth - 2) // revenir à login
                } else {
                    feedback.text = "Mot de passe incorrect"
                }
            }
        }

        Text { id: feedback; color: "red" }
    }
}