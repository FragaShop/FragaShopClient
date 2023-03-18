import QtQml
import QtQuick
import QtQuick.Controls

import FragaShop.UI as UI

Item {
    id: applicationWindowContent

    enum AvailablePages { HomePage, ProductPage, TestPage }

    property int currentPage: ApplicationWindowContent.AvailablePages.HomePage

    property alias productImageSource: pageProduct.imageSource
    property alias productOriginalPrice: pageProduct.originalPrice
    property alias productOfferPrice: pageProduct.offerPrice
    property alias productName: pageProduct.name
    property alias productDescription: pageProduct.description

    signal menuRequested()

    function pop() {
        stackViewPages.pop()
    }

    function showHomePage() {
        stackViewPages.push(pageHome)
    }

    function showProductPage() {
        stackViewPages.push(pageProduct)
    }

    function testPage() {
        if (stackViewPages.depth > 1) {
            stackViewPages.pop()
        } else {
            applicationWindowContent.currentPage = ApplicationWindowContent.AvailablePages.TestPage
            stackViewPages.push(pageTest)
        }
    }

    UI.PageHome {
        id: pageHome
        width: parent.width
        height: parent.height

        onMenuRequested: {
            applicationWindowContent.menuRequested()
        }

        onProductRequested: function(imageSource, originalPrice, offerPrice, name, description) {
            applicationWindowContent.productImageSource = imageSource
            applicationWindowContent.productOriginalPrice = originalPrice
            applicationWindowContent.productOfferPrice = offerPrice
            applicationWindowContent.productName = name
            applicationWindowContent.productDescription = description
            applicationWindowContent.showProductPage()
        }
    }

    UI.PageProduct {
        id: pageProduct
        width: parent.width
        height: parent.height

        onBackRequested: {
            applicationWindowContent.pop()
        }
    }

    UI.PageTest {
        id: pageTest
        width: parent.width
        height: parent.height
    }

    StackView {
        id: stackViewPages
        width: parent.width
        height: parent.height
        initialItem: pageHome
    }
}
