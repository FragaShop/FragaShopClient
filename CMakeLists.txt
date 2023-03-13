cmake_minimum_required(VERSION 3.19)

project(FragaShop VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_ANDROID_BUILD_ALL_ABIS OFF)

find_package(Qt6 6.4 COMPONENTS Quick Svg REQUIRED)

# The C/C++ source files
set(PROJECT_SOURCES
    # Source files
    src/main.cpp
    # Resources
    resources/images/images.qrc
    resources/fonts/fonts.qrc
    resources/translations/translations.qrc
    resources/qt/qt.qrc
    # Windows icon
    resources/platforms/windows/resManifest.rc
)

# The application
qt_add_executable(appFragaShop
    ${PROJECT_SOURCES}
)

qt_add_qml_module(appFragaShop
    URI FragaShop
    VERSION 1.0
    QML_FILES src/ui/qml/main.qml
)


# The UI
set(QML_UI_SOURCES
    src/ui/qml/Components/ApplicationWindowContent.qml
    src/ui/qml/Components/ApplicationWindowHeader.qml
    src/ui/qml/Components/Pages/PageHome.qml
    src/ui/qml/Components/Pages/PageTest.qml
    src/ui/qml/Components/Utils/PriceTag.qml
    src/ui/qml/Components/Controls/ComboBox.qml
    src/ui/qml/Components/Controls/RadioButton.qml
    src/ui/qml/Components/Controls/ScrollBar.qml
    src/ui/qml/Components/Controls/TextArea.qml
    src/ui/qml/Components/Controls/TextField.qml
    src/ui/qml/Components/Controls/+Material/ComboBox.qml
    src/ui/qml/Components/Controls/+Material/RadioButton.qml
    src/ui/qml/Components/Controls/+Material/RadioIndicator.qml
    src/ui/qml/Components/Controls/+Material/ScrollBar.qml
    src/ui/qml/Components/Controls/+Material/TextArea.qml
    src/ui/qml/Components/Controls/+Material/TextField.qml
)


qt_add_qml_module(FragaShopUI
    URI "FragaShop.UI"
    VERSION 1.0
    QML_FILES ${QML_UI_SOURCES}
    OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/FragaShop/UI
)


set_target_properties(appFragaShop PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ffraggahit.fragashop.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)


if (ANDROID)
    include(${ANDROID_SDK_ROOT}/android_openssl/CMakeLists.txt)
    set_target_properties(appFragaShop PROPERTIES QT_ANDROID_EXTRA_LIBS "${ANDROID_EXTRA_LIBS}")
endif()


target_link_libraries(appFragaShop
    PRIVATE Qt6::Quick Qt6::Svg
)

install(TARGETS appFragaShop
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
