import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Label {
    id: priceTag

    property string prefix: "$"
    property string sufix: ""
    property int decimals: 2
    property real price: 0.0
    readonly property string priceString: price.toFixed(decimals).toString()
    property bool smallCents: true
    property bool strikeThrough: false

    text: prefix + priceString.split(".")[0]
    rightPadding: labelPriceTagCents.contentWidth + 2

    Label {
        id: labelPriceTagCents

        x: parent.leftPadding + parent.contentWidth + 1
        y: 2
        text: priceTag.priceString.split(".")[1]
        font.pixelSize: ~~(priceTag.font.pixelSize * (priceTag.smallCents ? 0.66 : 1))
    }

    Rectangle {
        id: rectangleStrikeThrough

        property bool leftTransparent: false
        property bool rightTransparent: true

        x: parent.leftPadding + (parent.width - width)/2
        y: parent.topPadding  + (parent.height - height)/2
        width: parent.width
        height: 1
        visible: priceTag.strikeThrough

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.00;
                color: rectangleStrikeThrough.leftTransparent ? "transparent" : priceTag.color
            }
            GradientStop {
                position: 0.2;
                color: priceTag.enabled ? Material.foreground : Material.hintTextColor
            }
            GradientStop {
                position: 0.8;
                color: priceTag.enabled ? Material.foreground : Material.hintTextColor
            }
            GradientStop {
                position: 1.00;
                color: rectangleStrikeThrough.rightTransparent ? "transparent" : priceTag.color
            }
        } // Gradient
    } // Rectangle
}
