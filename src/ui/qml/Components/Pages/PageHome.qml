import QtQuick
import QtQuick.Controls

Page {
    id: pageHome

    GridView {
        id: gridViewProducts

        x: 8
        y: 8
        width: parent.width - 2*x + 4
        height: parent.height - 2*y + 4

        cellWidth: gridViewProducts.width/2
        cellHeight: 200
        model: 50
        delegate: Rectangle {
            width: gridViewProducts.cellWidth - 4
            height: gridViewProducts.cellHeight - 4

            radius: 20
            border.color: Qt.darker(color, 1.5)
            color: Material.dialogColor
            clip: true

            Image {
                id: imageProduct

                width: parent.width
                height: 150
                source: "https://picsum.photos/seed/%0/%1".arg(~~(Math.random() * 1000)).arg(300)
                asynchronous: true

                BusyIndicator {
                    x: (parent.width - width)/2
                    y: (parent.height - height)/2
                    running: imageProduct.status === Image.Loading
                }
            }
        }
    }
}
