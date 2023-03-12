cmake_minimum_required(VERSION 3.19)

project(FragaShop VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 COMPONENTS Quick REQUIRED)

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
)

target_link_libraries(appFragaShop
    PRIVATE Qt6::Quick
)

install(TARGETS appFragaShop
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
