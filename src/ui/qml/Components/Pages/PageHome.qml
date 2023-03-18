import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import FragaShop.UI as UI

Page {
    id: pageHome

    signal menuRequested()
    signal productRequested(url imageSource, real originalPrice, real offerPrice)

    header: UI.PageHomeHeader {
        id: pageHomeHeader

        onMenuRequested: {
            pageHome.menuRequested()
        }
    } // Pane (header)

    GridView {
        id: gridViewProducts

        width: parent.width
        height: parent.height
        topMargin: 8
        bottomMargin: 8
        leftMargin: 8
        rightMargin: 0

        cellWidth: gridViewProducts.width/2 - 6
        cellHeight: 200
        model: applicationWindow.visible ? 50 : 0 // show images only after the Window is shown, but this shouldn't be aware of applicationWindow's existence
        delegate: Rectangle {
            id: rectangleProduct

            width: gridViewProducts.cellWidth - 4
            height: gridViewProducts.cellHeight - 4

            radius: 20
            border.color: Qt.darker(color, 1.5)
            color: Material.dialogColor
            clip: true

            layer.enabled: true
            layer.effect: OpacityMask { // adds rounded corners to image
                maskSource: Rectangle { width: rectangleProduct.width; height: rectangleProduct.height; radius: rectangleProduct.radius }
            }

            Image {
                id: imageProduct

                width: parent.width
                height: 150

                source: "https://picsum.photos/seed/%0/%1/%2".arg(~~(Math.random() * 10000)).arg(pageHome.width).arg(pageHome.width)
                sourceSize.width: ~~rectangleProduct.width
                sourceSize.height: ~~(rectangleProduct.height * 0.8)
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                opacity: 0

                ParallelAnimation {
                    id: animationEnterImage

                    running: imageProduct.status === Image.Ready

                    // grow_fade_in
                    NumberAnimation { target: imageProduct; property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
                    NumberAnimation { target: imageProduct; property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
                }
            }

            UI.PriceTag {
                id: priceTagOriginal

                x: 4
                y: imageProduct.y + imageProduct.height - 2

                price: Math.random() * 200
                font.bold: true
                font.pixelSize: ~~(gridViewProducts.cellHeight * (enabled ? 0.1 : 0.07))
                enabled: !priceTagOffer.visible
                strikeThrough: !enabled
            }

            Label {
                id: labelOfferPercent

                x: priceTagOriginal.x + priceTagOriginal.width
                y: priceTagOriginal.y
                leftPadding: 1
                rightPadding: 1

                text: "-" + ~~((1 - priceTagOffer.price/priceTagOriginal.price) * 100) + "%"
                font.bold: true
                font.pixelSize: ~~(priceTagOriginal.font.pixelSize * 0.66)
                color: Material.dialogColor
                visible: priceTagOffer.visible

                background: Rectangle { color: Material.accentColor; radius: height/4 }
            }

            UI.PriceTag {
                id: priceTagOffer

                x: priceTagOriginal.x
                y: priceTagOriginal.y + priceTagOriginal.height - 8

                price: Math.random() * 200
                font.bold: true
                font.pixelSize: ~~(gridViewProducts.cellHeight * 0.1)
                visible: price < priceTagOriginal.price
            }

            BusyIndicator {
                x: (imageProduct.width - width)/2
                y: (imageProduct.height - height)/2
                running: imageProduct.status === Image.Loading
            }

            Button {
                id: buttonProduct

                width: parent.width
                height: parent.height
                topInset: 0
                bottomInset: 0

                flat: true

                onClicked: pageHome.productRequested(imageProduct.source, priceTagOriginal.price, priceTagOffer.price)
            }
        } // Rectangle (delegate)

        ScrollBar.vertical: UI.ScrollBar {}
    } // GridView
}
