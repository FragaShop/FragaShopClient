import QtCore
import QtQuick
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import FragaShop.UI as UI

ApplicationWindow {
    id: applicationWindow

    width: 384
    height: 654
    visible: true
    title: Qt.application.name
    Material.theme: settings.theme
    Material.accent: settings.accent

    Settings {
        id: settings

        property int theme: Material.System
        property int accent: Material.Blue
    }

    UI.ApplicationWindowContent {
        id: applicationWindowContent
        width: parent.width
        height: parent.height

        onMenuRequested: applicationMenu.open()
    }

    UI.ApplicationMenu {
        id: applicationMenu

        width: 0.66 * applicationWindow.width
        height: applicationWindow.height
        modal: true

        onThemeChangeRequested: {
            settings.theme = applicationWindow.Material.theme === Material.Light ? Material.Dark : Material.Light
        }

        onAccentColorChangeRequested: function (accentColor) {
            settings.accent = accentColor
        }
    } // Drawer (menu)

    FastBlur {
        id: fastBlurEffect
        visible: radius > 0
        width: applicationWindowContent.width
        height: applicationWindowContent.height
        source: applicationWindowContent

        Behavior on radius { NumberAnimation {} }
    }

}
