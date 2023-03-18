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
    property alias name: labelProductName.text
    property alias description: labelProductDescription.text

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

        ParallelAnimation {
            id: animationEnterImage

            running: imageProduct.status === Image.Ready

            // grow_fade_in
            NumberAnimation { target: imageProduct; property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
            NumberAnimation { target: imageProduct; property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
        }
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

    Label {
        id: labelProductName

        x: (labelOfferPercent.visible ? Math.max(labelOfferPercent.x + labelOfferPercent.width, priceTagOriginal.x + priceTagOriginal.width) : priceTagOriginal.x + priceTagOriginal.width) + 8
        y: imageProduct.y + imageProduct.height
        width: parent.width - x - 4

        wrapMode: Label.Wrap
        elide: Label.ElideRight
        font.pixelSize: ~~(Qt.application.font.pixelSize * 1.6)
        font.bold: true
    }

    Label {
        id: labelProductDescription

        x: labelProductName.x
        y: labelProductName.y + labelProductName.height
        width: labelProductName.width
        height: parent.height - y

        wrapMode: Label.Wrap
        elide: Label.ElideRight
    }
}
