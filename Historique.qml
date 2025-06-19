import QtQuick 2.15

Item {
    anchors.centerIn:parent
    ListView {
                id: listView
                width: parent.width
                height: parent.height
                model: dbManager.getTransactions(currentUser)
                delegate: Text { text: modelData }
            }


}
