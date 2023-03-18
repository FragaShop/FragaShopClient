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
        width: visible ? contentWidth + leftPadding + rightPadding : 0
        height: visible ? contentHeight + topPadding + bottomPadding : 0
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
        width: visible ? contentWidth + leftPadding + rightPadding : 0
        height: visible ? contentHeight + topPadding + bottomPadding : 0

        font.bold: true
        font.pixelSize: ~~Qt.application.font.pixelSize * 3
        visible: price < priceTagOriginal.price
    }

    Button {
        id: buttonBuy

        x: priceTagOriginal.x
        y: priceTagOffer.visible ? priceTagOffer.y + priceTagOffer.height : priceTagOriginal.y + priceTagOriginal.height
        width: Math.max(implicitWidth, priceTagOriginal.width, (priceTagOffer.visible ? priceTagOffer.width : 0))

        text: qsTr("Add to cart")
        icon.source: "qrc:/images/icons/actions/add_to_cart.svg"
        highlighted: true
    }

    Label {
        id: labelProductName

        x: Math.max(priceTagOriginal.x + priceTagOriginal.width, labelOfferPercent.x + labelOfferPercent.width, buttonBuy.x + buttonBuy.width) + 8
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
