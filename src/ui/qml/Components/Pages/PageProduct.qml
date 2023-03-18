import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import FragaShop.UI as UI

Page {
    id: pageProduct

    property alias imageSource: imageProduct.source
    property alias originalPrice: priceTagOriginal.price
    property alias offerPrice: priceTagOffer.price

    signal backRequested()

    header: UI.PageProductHeader {
        id: pageProductHeader

        onBackRequested: {
            pageProduct.backRequested()
        }
    }

    Image {
        id: imageProduct

        y: -pageProductHeader.height
        width: parent.width
        height: width
        sourceSize.width: width
        sourceSize.height: height

        fillMode: Image.PreserveAspectFit
        asynchronous: true
    }

    BusyIndicator {
        x: imageProduct.x + (imageProduct.width - width)/2
        y: imageProduct.y + (imageProduct.height - height)/2
        running: imageProduct.status === Image.Loading
    }

    UI.PriceTag {
        id: priceTagOriginal

        x: 10
        y: imageProduct.y + imageProduct.height - 2

        font.bold: true
        font.pixelSize: ~~(Qt.application.font.pixelSize * (enabled ? 3 : 2))
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

        font.bold: true
        font.pixelSize: ~~Qt.application.font.pixelSize * 3
        visible: price < priceTagOriginal.price
    }
}
