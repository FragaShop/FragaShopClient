import QtQuick
import QtQuick.Controls.Material

import FragaShop.UI as UI

Drawer {
    id: applicationMenu

    signal themeChangeRequested()
    signal accentColorChangeRequested(var accentColor)

    ToolButton {
        id: toolButtonTheme

        x: buttonTheme.x
        y: ~~(buttonTheme.y + (buttonTheme.height - height)/2)

        icon.source: "qrc:/images/icons/menu/night_mode.svg"
        icon.color: Material.theme === Material.Light ? toolButtonThemeAccent.foregroundColor : "transparent"
        background: null
    }
    ToolButton {
        id: toolButtonThemeAccent

        x: buttonTheme.x + buttonTheme.width - width + 6
        y: toolButtonTheme.y

        icon.source: "qrc:/images/icons/arrows/arrow_drop_down.svg"
        background: null
    }
    Button {
        id: buttonTheme

        x: ~~(applicationMenu.width - width - 4)
        y: -applicationMenu.topPadding
        width: toolButtonTheme.width + 16

        flat: true
        background: Rectangle {
            implicitWidth: 64
            implicitHeight: buttonTheme.Material.buttonHeight
            radius: height/2
            color: buttonTheme.Material.foreground
            opacity: buttonTheme.down ? 0.2 : buttonTheme.hovered ? 0.1 : 0
            Behavior on opacity { NumberAnimation {} }
        }

        onClicked: {
            themeChangeRequested()
        }
        onPressAndHold: {
            menuThemeAccent.open()
        }

        Menu {
            id: menuThemeAccent

            margins: 12
            padding: 4
            visible: false
            enabled: visible

            readonly property var materialPredefinedColors: [
                Material.Red,
                Material.Pink,
                Material.Purple,
                Material.DeepPurple,
                Material.Indigo,
                Material.Blue,
                Material.LightBlue,
                Material.Cyan,
                Material.Teal,
                Material.Green,
                Material.LightGreen,
                Material.Lime,
                Material.Yellow,
                Material.Amber,
                Material.Orange,
                Material.DeepOrange,
                Material.Brown,
                Material.Grey,
                Material.BlueGrey
            ]

            GridView {
                id: gridViewThemeAccent

                implicitWidth: cellWidth*4
                implicitHeight: contentHeight
                cellWidth: 64
                cellHeight: 64
                model: menuThemeAccent.materialPredefinedColors
                delegate: Item {
                    width: gridViewThemeAccent.cellWidth
                    height: width

                    Rectangle {
                        x: (parent.width - width)/2
                        y: (parent.height - height)/2
                        width: parent.width - (Material.accent === buttonTheme.Material.accent ? 0 : 12)
                        Behavior on width { NumberAnimation { easing.type: Easing.OutQuint } }
                        height: width
                        radius: width/2
                        color: Material.accent
                        border.width: 4
                        border.color: Qt.darker(color)

                        Material.accent: modelData

                        Button {
                            x: parent.border.width
                            y: x
                            width: parent.width - 2*x
                            height: width
                            padding: 0
                            topInset: 0
                            bottomInset: 0

                            flat: true
                            Material.accent: modelData
                            Material.background: Material.accent
                            Material.elevation: 0

                            onClicked: {
                                applicationMenu.accentColorChangeRequested(modelData)
                            }
                        }
                    } // Rectangle
                } // Item (delegate)

                ScrollBar.vertical: UI.ScrollBar {}
            } // GridView (accent)
        } // Popup (accent)
    } // Button (theme)
}
