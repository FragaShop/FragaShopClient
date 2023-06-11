import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import FragaShop.UI as UI

Pane {
    id: applicationHomeHeader

    signal menuRequested()

    height: toolButtonFilter.y + flickableFilters.height + 1
    padding: 0
    Material.elevation: 10

    ToolButton {
        id: toolButtonMenu

        z: itemSearchClip.z + 1
        icon.source: "qrc:/images/icons/menu/menu.svg"
        icon.color: rectangleSearch.width > (textFieldSearch.width + width)*2 ? Material.dialogColor : Material.foreground
        onClicked: {
            applicationHomeHeader.menuRequested()
        }
    }

    Label {
        id: labelStatus

        x: toolButtonMenu.x + toolButtonMenu.width + 10
        width: toolButtonFilter.x - x
        height: toolButtonMenu.height
        verticalAlignment: Label.AlignVCenter

        text: "Fragashop"
        font.family: "Didot"
        font.italic: true
        font.pointSize: Qt.application.font.pointSize * 20
        fontSizeMode: Label.Fit
        elide: Label.ElideRight
    }

    Item {
        id: itemSearchClip
        width: applicationHomeHeader.width
        height: toolButtonFilter.y
        clip: true

        Rectangle {
            id: rectangleSearch

            x: toolButtonSearch.x + (toolButtonSearch.width - width)/2
            y: toolButtonSearch.y + (toolButtonSearch.height - height)/2
            width: toolButtonSearch.checked ? parent.width * 2 : 0
            Behavior on width { NumberAnimation {} }
            height: width
            radius: width/2

            color: applicationHomeHeader.Material.accentColor
            clip: true

            TextField {
                id: textFieldSearch

                x: parent.width/2 - width - toolButtonSearch.width/2
                y: (parent.height - height)/2 + 4
                width: applicationHomeHeader.width - (2 * toolButtonSearch.width)

                enabled: toolButtonSearch.checked && parent.width > toolButtonSearch.width
                color: Material.dialogColor
                Material.accent: textFieldSearch.color
                background: Rectangle {
                    y: textFieldSearch.height - height - textFieldSearch.bottomPadding + 8
                    implicitWidth: 120
                    height: 2
                    color: textFieldSearch.Material.accentColor
                }
            }
        }
    }

    ToolButton {
        id: toolButtonSearch

        x: parent.width - width
        y: toolButtonMenu.y

        icon.source: "qrc:/images/icons/actions/" + (rectangleSearch.width > width/2 ? "clear" : "search") + ".svg"
        icon.color: rectangleSearch.width > width/2 ? Material.dialogColor : Material.foreground
        checkable: true

        onCheckedChanged: {
            if (checked) {
                textFieldSearch.forceActiveFocus()
            }
        }
    }

    Rectangle {
        id: rectangleSeparator

        property bool leftTransparent: true
        property bool rightTransparent: true

        y: toolButtonSearch.y + toolButtonSearch.height + 2
        width: parent.width
        height: 1

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.00;
                color: rectangleSeparator.leftTransparent ? "transparent" : (rectangleSeparator.enabled ? applicationHomeHeader.Material.foreground : applicationHomeHeader.Material.hintTextColor)
            }
            GradientStop {
                position: 0.25;
                color: rectangleSeparator.enabled ? applicationHomeHeader.Material.foreground : applicationHomeHeader.Material.hintTextColor
            }
            GradientStop {
                position: 0.75;
                color: rectangleSeparator.enabled ? applicationHomeHeader.Material.foreground : applicationHomeHeader.Material.hintTextColor
            }
            GradientStop {
                position: 1.00;
                color: rectangleSeparator.rightTransparent ? "transparent" : (rectangleSeparator.enabled ? applicationHomeHeader.Material.foreground : applicationHomeHeader.Material.hintTextColor)
            }
        } // Gradient
    } // Rectangle

    ToolButton {
        id: toolButtonFilter

        x: parent.width - width
        y: rectangleSeparator.y + rectangleSeparator.height
        z: rectangleFilterFadeLeft.z + 1

        icon.source: "qrc:/images/icons/arrows/chevron_" + (checked ? "less" : "more") + ".svg"
        checkable: true
    }

    Rectangle {
        id: rectangleFilterFadeLeft

        x: parent.width - width
        y: flickableFilters.y
        z: flickableFilters.z + 1
        width: toolButtonFilter.width + 10
        height: toolButtonFilter.height

        visible: !toolButtonFilter.checked

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.00;
                color: "transparent"
            }
            GradientStop {
                position: 0.35;
                color: applicationHomeHeader.Material.backgroundColor
            }
        } // Gradient
    }

    Flickable {
        id: flickableFilters

        y: toolButtonFilter.y
        width: parent.width
        height: toolButtonFilter.checked ? y * 4 : toolButtonFilter.height
        Behavior on height { NumberAnimation { easing.type: Easing.OutQuint } }
        rightMargin: toolButtonFilter.width
        contentWidth:  flowFilters.width
        contentHeight: flowFilters.height
        clip: true

        Flow {
            id: flowFilters

            width: toolButtonFilter.checked ? flickableFilters.width - flickableFilters.rightMargin : repeaterFilters.count * 36
            height: toolButtonFilter.checked ? implicitHeight : toolButtonFilter.height

            Repeater {
                id: repeaterFilters

                model: listModelFilters
                delegate: ToolButton {
                    id: toolButtonDelegate

                    implicitWidth: labelFilterName.x + labelFilterName.width + 8
                    width: toolButtonFilter.checked ? implicitWidth : (2 * imageFilterIcon.x + imageFilterIcon.width)
                    //Behavior on width { NumberAnimation {} }
                    checkable: true
                    flat: true
                    clip: true
                    highlighted: checked

                    Image {
                        id: imageFilterIcon
                        x: 4
                        y: (parent.height - height)/2
                        source: applicationHomeHeader.Material.theme === Material.Dark ? model.icon.replace("fashion", "fashion/dark") : model.icon
                        sourceSize: "32x32"
                    }

                    ColorOverlay {
                        x: imageFilterIcon.x
                        y: imageFilterIcon.y
                        width: imageFilterIcon.width
                        height: imageFilterIcon.height
                        source: imageFilterIcon
                        color: applicationHomeHeader.Material.accentColor
                        opacity: toolButtonDelegate.checked ? 0.4 : 0.0
                    }

                    Label {
                        id: labelFilterName
                        x: imageFilterIcon.x + imageFilterIcon.width + 4
                        y: imageFilterIcon.y + (imageFilterIcon.height - height)/2
                        text: model.name
                        color: toolButtonDelegate.checked ? applicationHomeHeader.Material.accentColor : applicationHomeHeader.Material.primaryTextColor
                    }
                } // ToolButton (delegate)
            } // Repeater
        } // Flow

        ScrollBar.vertical: UI.ScrollBar {}
    } // Flickable

    ListModel {
        id: listModelFilters

        ListElement { category: "shirt"; name: "Shirt"; icon: "qrc:/images/icons/fashion/shirt-sleeves.svg" }
        ListElement { category: "blouse"; name: "Blouse"; icon: "qrc:/images/icons/fashion/blouse.svg" }
        ListElement { category: "sweater"; name: "Sweater"; icon: "qrc:/images/icons/fashion/sweater.svg" }
        ListElement { category: "pullover"; name: "Pullover"; icon: "qrc:/images/icons/fashion/pullover.svg" }
        ListElement { category: "dress"; name: "Dress"; icon: "qrc:/images/icons/fashion/dress.svg" }
        ListElement { category: "suit"; name: "Suit"; icon: "qrc:/images/icons/fashion/suit.svg" }
        ListElement { category: "coat"; name: "Coat"; icon: "qrc:/images/icons/fashion/coat.svg" }
        ListElement { category: "pants"; name: "Pants"; icon: "qrc:/images/icons/fashion/pants.svg" }
        ListElement { category: "shorts"; name: "Shorts"; icon: "qrc:/images/icons/fashion/shorts.svg" }
        ListElement { category: "shorts-swimming"; name: "Swimming shorts"; icon: "qrc:/images/icons/fashion/shorts-swimming.svg" }
        ListElement { category: "shoes"; name: "Shoes"; icon: "qrc:/images/icons/fashion/shoes.svg" }
        ListElement { category: "heels"; name: "Heels"; icon: "qrc:/images/icons/fashion/heels.svg" }
        ListElement { category: "tennis"; name: "Tennis"; icon: "qrc:/images/icons/fashion/tennis.svg" }
        ListElement { category: "boots"; name: "Boots"; icon: "qrc:/images/icons/fashion/boots.svg" }
        ListElement { category: "flipflops"; name: "Flip Flops"; icon: "qrc:/images/icons/fashion/flipflops.svg" }
        ListElement { category: "cap"; name: "Cap"; icon: "qrc:/images/icons/fashion/cap.svg" }
        ListElement { category: "hat-men"; name: "Men hat"; icon: "qrc:/images/icons/fashion/hat-men.svg" }
        ListElement { category: "hat-women"; name: "Women hat"; icon: "qrc:/images/icons/fashion/hat-women.svg" }
        ListElement { category: "hat-winter"; name: "Winter hat"; icon: "qrc:/images/icons/fashion/hat-winter.svg" }
        ListElement { category: "Bra"; name: "Bra"; icon: "qrc:/images/icons/fashion/bra.svg" }
        ListElement { category: "underpants"; name: "Underpants"; icon: "qrc:/images/icons/fashion/underpants.svg" }
        ListElement { category: "tie"; name: "Tie"; icon: "qrc:/images/icons/fashion/tie.svg" }
        ListElement { category: "purse"; name: "Purse"; icon: "qrc:/images/icons/fashion/purse.svg" }
        ListElement { category: "suitcase"; name: "Suitcase"; icon: "qrc:/images/icons/fashion/suitcase.svg" }
    }
}
