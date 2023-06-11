import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import FragaShop.UI as UI

Page {
    id: pageHome

    signal menuRequested()
    signal productRequested(url imageSource, real originalPrice, real offerPrice, string name, string description)

    header: UI.PageHomeHeader {
        id: pageHomeHeader

        onMenuRequested: {
            pageHome.menuRequested()
        }
    } // Pane (header)

    GridView {
        id: gridViewProducts

        width: parent.width
        height: parent.height
        topMargin: 8
        bottomMargin: 8
        leftMargin: 8
        rightMargin: 0

        cellWidth: gridViewProducts.width/2 - 6
        cellHeight: 200
        model: applicationWindow.visible ? 50 : 0 // show images only after the Window is shown, but this shouldn't be aware of applicationWindow's existence
        delegate: Rectangle {
            id: rectangleProduct

            width: gridViewProducts.cellWidth - 4
            height: gridViewProducts.cellHeight - 4

            radius: 20
            border.color: Qt.darker(color, 1.5)
            color: Material.dialogColor
            clip: true

            layer.enabled: true
            layer.effect: OpacityMask { // adds rounded corners to image
                maskSource: Rectangle { width: rectangleProduct.width; height: rectangleProduct.height; radius: rectangleProduct.radius }
            }

            Image {
                id: imageProduct

                width: parent.width
                height: 150

                source: "https://picsum.photos/seed/%0/%1/%2".arg(~~(Math.random() * 10000)).arg(pageHome.width).arg(pageHome.width)
                sourceSize.width: ~~rectangleProduct.width
                sourceSize.height: ~~(rectangleProduct.height * 0.8)
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                opacity: 0

                ParallelAnimation {
                    id: animationEnterImage

                    running: imageProduct.status === Image.Ready

                    // grow_fade_in
                    NumberAnimation { target: imageProduct; property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
                    NumberAnimation { target: imageProduct; property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
                }
            } // Image (product)

            UI.PriceTag {
                id: priceTagOriginal

                x: 4
                y: imageProduct.y + imageProduct.height - 2

                price: Math.random() * 200
                font.bold: true
                font.pixelSize: ~~(gridViewProducts.cellHeight * (enabled ? 0.1 : 0.07))
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

                price: Math.random() * 200
                font.bold: true
                font.pixelSize: ~~(gridViewProducts.cellHeight * 0.1)
                visible: price < priceTagOriginal.price
            }

            BusyIndicator {
                x: (imageProduct.width - width)/2
                y: (imageProduct.height - height)/2
                running: imageProduct.status === Image.Loading
            }

            Label {
                id: labelProductName

                x: Math.max(priceTagOriginal.x + priceTagOriginal.width, labelOfferPercent.x + labelOfferPercent.width) + 8
                y: imageProduct.y + imageProduct.height
                width: parent.width - x - 4

                wrapMode: Label.Wrap
                elide: Label.ElideRight
                maximumLineCount: 2
                text: randomArticles[~~(Math.random() * randomArticles.length)]
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
                text: randomSentences[~~(Math.random() * randomSentences.length)]
                font.italic: true
            }

            Button {
                id: buttonProduct

                width: parent.width
                height: parent.height
                topInset: 0
                bottomInset: 0
                Material.roundedScale: Material.NotRounded

                flat: true

                onClicked: pageHome.productRequested(imageProduct.source, priceTagOriginal.price, priceTagOffer.price, labelProductName.text, labelProductDescription.text)
            }
        } // Rectangle (delegate)

        ScrollBar.vertical: UI.ScrollBar {}
    } // GridView

    // 50 random sentences
    readonly property var randomSentences: [
        "A purple pig and a green donkey flew a kite in the middle of the night and ended up sunburnt.",
        "So long and thanks for the fish.",
        "Everybody should read Chaucer to improve their everyday vocabulary.",
        "It was obvious she was hot, sweaty, and tired.",
        "He found the chocolate covered roaches quite tasty.",
        "The wake behind the boat told of the past while the open sea for told life in the unknown future.",
        "The shark-infested South Pine channel was the only way in or out.",
        "The sun had set and so had his dreams.",
        "She saw no irony asking me to change but wanting me to accept her for who she is.",
        "He went on a whiskey diet and immediately lost three days.",
        "Flash photography is best used in full sunlight.",
        "Today I dressed my unicorn in preparation for the race.",
        "Best friends are like old tomatoes and shoelaces.",
        "My Mum tries to be cool by saying that she likes all the same things that I do.",
        "The team members were hard to tell apart since they all wore their hair in a ponytail.",
        "He always wore his sunglasses at night.",
        "The busker hoped that the people passing by would throw money, but they threw tomatoes instead, so he exchanged his hat for a juicer.",
        "Swim at your own risk was taken as a challenge for the group of Kansas City college students.",
        "He swore he just saw his sushi move.",
        "The sudden rainstorm washed crocodiles into the ocean.",
        "He enjoys practicing his ballet in the bathroom.",
        "Now I need to ponder my existence and ask myself if I'm truly real.",
        "It turns out you don't need all that stuff you insisted you did.",
        "Shingle color was not something the couple had ever talked about.",
        "He found a leprechaun in his walnut shell.",
        "There's a growing trend among teenagers of using frisbees as go-cart wheels.",
        "That must be the tenth time I've been arrested for selling deep-fried cigars.",
        "He was the only member of the club who didn't like plum pudding.",
        "Dolores wouldn't have eaten the meal if she had known what it actually was.",
        "The secret ingredient to his wonderful life was crime.",
        "I want a giraffe, but I'm a turtle eating waffles.",
        "Various sea birds are elegant, but nothing is as elegant as a gliding pelican.",
        "I was very proud of my nickname throughout high school but today- I couldn’t be any different to what my nickname was.",
        "The dead trees waited to be ignited by the smallest spark and seek their revenge.",
        "She found his complete dullness interesting.",
        "The murder hornet was disappointed by the preconceived ideas people had of him.",
        "His mind was blown that there was nothing in space except space itself.",
        "He had a wall full of masks so she could wear a different face every day.",
        "They're playing the piano while flying in the plane.",
        "The best key lime pie is still up for debate.",
        "Bill ran from the giraffe toward the dolphin.",
        "It was a really good Monday for being a Saturday.",
        "Kevin embraced his ability to be at the wrong place at the wrong time.",
        "I was offended by the suggestion that my baby brother was a jewel thief.",
        "Even though he thought the world was flat he didn’t see the irony of wanting to travel around the world.",
        "Every manager should be able to recite at least ten nursery rhymes backward.",
        "She saw the brake lights, but not in time.",
        "They were excited to see their first sloth.",
        "The fifty mannequin heads floating in the pool kind of freaked them out.",
        "They say people remember important moments in their life well, yet no one even remembers their own birth.",
        "Harrold felt confident that nobody would ever suspect his spy pigeon.",
        "I would have gotten the promotion, but my attendance wasn’t good enough.",
        "Flash photography is best used in full sunlight.",
        "The near-death experience brought new ideas to light.",
        "The furnace repairman indicated the heating system was acting as an air conditioner.",
        "She moved forward only because she trusted that the ending she now was going through must be followed by a new beginning.",
        "Flesh-colored yoga pants were far worse than even he feared.",
        "The changing of down comforters to cotton bedspreads always meant the squirrels had returned.",
        "The most exciting eureka moment I've had was when I realized that the instructions on food packets were just guidelines.",
        "Everything was going so well until I was accosted by a purple giraffe."
    ]

    // 60 random articles
    readonly property var randomArticles: [
        "Jeans",
        "T-Shirts",
        "Sweaters",
        "Suit Jacket",
        "Dress Shirt",
        "Suits",
        "Slacks",
        "Blouse",
        "Skirt",
        "Blazer",
        "Cardigan Sweater",
        "Dresses",
        "Leather Jacket",
        "Button Down Shirt",
        "Khakis",
        "Jumpsuit",
        "Coat",
        "Hoodie",
        "Activewear",
        "Raincoat",
        "Sport Coat",
        "Leggings",
        "Tank Tops",
        "Vest",
        "Jegging",
        "Hats",
        "Scarves",
        "Gloves",
        "Socks",
        "Belt",
        "Beachwear",
        "Swimming Trunks",
        "Exercise Gear",
        "Ties",
        "Jewelry",
        "Watches",
        "Boots",
        "Combat Boots",
        "Sneakers",
        "Sandals",
        "High Heels",
        "Flip Flops",
        "Fanny Pack",
        "Headbands",
        "Beanie",
        "Handbag",
        "Tote Bag",
        "Backpack",
        "Messenger Bag",
        "Scarf",
        "Sunglasses",
        "Leg Warmers",
        "Panama Hat",
        "Beret",
        "Clutch",
        "Makeup",
        "Perfume",
        "Hair Accessories",
        "Wallet",
        "Shawl"
    ]
}
