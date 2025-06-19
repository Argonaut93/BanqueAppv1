import QtQuick 2.15
import QtQuick.Controls 2.15
import "Components"

Page {
    Column{
        anchors.centerIn: parent
        spacing: 16
        Text{
            id:titre
            text: "Création de compte"
            font.pixelSize: 30
        }

        TextField{
            //anchors.centerIn: titre
            id:new_user
            width:220
            placeholderText:"username"
            placeholderTextColor: "blue"
            background:Rectangle{
                radius:height/2
                color:white
                border.color: "#cccccc"
                border.width: 1

            }
            padding:10

            //radius:1//comment rendre les bouttons rond
        }
        TextField{
            //anchors.centerIn: titre
            id:new_password
            width:220
            placeholderText:"password"
            placeholderTextColor: "blue"
            background:Rectangle{
                radius:height/2
                color:white
                border.color: "#cccccc"
                border.width: 1

            }
            padding:10
            echoMode: "Password"
        }
        HoverButton{
            //anchors.centerIn: titre
            /*width:220
            text:"Valider"
            background: Rectangle{
                radius:control.hovered ? height/2 : height/2
                border.color: "#cccccc"
                border.width:1
                color:control.hovered ? "#e0e0e0" : "#ffffff"

            }*/
            MouseArea{
                id:mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape:Qt.PointingHandCursor
            }

            onClicked:{
                if (dbManager.registerUser(new_user.text, new_password.text)) {
                    message.text = "Compte créé, connecte-toi !"
                } else {
                    message.text = "Utilisateur déjà existant"

                }
            }
        }


    }



}
