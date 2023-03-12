import QtQml
import QtQuick
import QtQuick.Controls

import FragaShop.UI as UI

Item {
    id: applicationWindowContent

    enum AvailablePages { HomePage, TestPage }

    property int currentPage: ApplicationWindowContent.AvailablePages.HomePage

    function testPage() {
        if (stackViewPages.depth > 1) {
            stackViewPages.pop()
        } else {
            applicationWindowContent.currentPage = ApplicationWindowContent.AvailablePages.TestPage
            stackViewPages.push(componentPageTest)
        }
    }

    StackView {
        id: stackViewPages
        width: parent.width
        height: parent.height
        initialItem: componentPageHome
    }

    Component {
        id: componentPageHome

        Item {
            UI.PageHome {
                id: pageHome
                width: parent.width
                height: parent.height
            }
        }
    } // Component (PageHome)

    Component {
        id: componentPageTest

        UI.PageTest {
            id: pageTest
        }
    }
}
