import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import FragaShop.UI as UI

Pane {
    id: applicationWindowHeader

    signal menuTriggered()

    height: labelStatus.height + 2 + flickableFilters.height
    padding: 0
    Material.elevation: 10

    ToolButton {
        id: toolButtonMenu

        icon.source: "qrc:/images/icons/menu/menu.svg"
        onClicked: {
            applicationWindowHeader.menuTriggered()
        }
    }

    Label {
        id: labelStatus

        x: toolButtonMenu.x + toolButtonMenu.width + 10
        width: toolButtonFilter.x - x
        height: toolButtonMenu.height
        verticalAlignment: Label.AlignVCenter

        text: qsTr(Qt.application.name)
        font.family: "Dancing Script"
        font.pointSize: Qt.application.font.pointSize * 20
        fontSizeMode: Label.Fit
        elide: Label.ElideRight
    }

    ToolButton {
        id: toolButtonFilter

        x: parent.width - width
        y: toolButtonMenu.y

        icon.source: "qrc:/images/icons/actions/filter.svg"
        checkable: true
    }

    Flickable {
        id: flickableFilters

        y: labelStatus.height + 2 // same as default header height
        width: parent.width
        height: toolButtonFilter.checked ? y * 5 : 0
        Behavior on height { NumberAnimation { easing.type: Easing.OutQuint } }

        enabled: height > 0
        contentWidth: width
        contentHeight: flowFilters.height
        clip: true

        Flow {
            id: flowFilters

            width: parent.width

            Repeater {
                model: listModelFilters
                delegate: ToolButton {
                    id: toolButtonDelegate

                    implicitWidth: labelFilterName.x + labelFilterName.width + 8
                    checkable: true
                    flat: true
                    highlighted: checked
                    onClicked: console.log(width, implicitWidth)

                    Image {
                        id: imageFilterIcon
                        x: 4
                        y: (parent.height - height)/2
                        source: model.icon
                        sourceSize: "32x32"
                    }

                    ColorOverlay {
                        x: imageFilterIcon.x
                        y: imageFilterIcon.y
                        width: imageFilterIcon.width
                        height: imageFilterIcon.height
                        source: imageFilterIcon
                        color: Material.accentColor
                        opacity: toolButtonDelegate.checked ? 0.4 : 0.0
                    }

                    Label {
                        id: labelFilterName
                        x: imageFilterIcon.x + imageFilterIcon.width + 4
                        y: imageFilterIcon.y + (imageFilterIcon.height - height)/2
                        text: model.name
                        color: toolButtonDelegate.checked ? Material.accentColor : Material.primaryTextColor
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
