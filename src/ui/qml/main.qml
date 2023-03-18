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

    UI.ApplicationWindowContent {
        id: applicationWindowContent
        width: parent.width
        height: parent.height

        onMenuRequested: drawerMenu.open()
    }

    Drawer {
        id: drawerMenu

        width: 0.66 * applicationWindow.width
        height: applicationWindow.height

        modal: true

        Label {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            text: qsTr("Nothing to see here")
        }
    }

    FastBlur {
        id: fastBlurEffect
        visible: radius > 0
        width: applicationWindowContent.width
        height: applicationWindowContent.height
        source: applicationWindowContent

        Behavior on radius { NumberAnimation {} }
    }

}
