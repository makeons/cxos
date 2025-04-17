cmake_minimum_required(VERSION 3.5)

project(CXBronser)

set(CMAKE_CXX_STANDARD 11)

find_package(Qt5 REQUIRED COMPONENTS Core Gui Widgets WebEngineWidgets)

add_executable(CXBronser src/main.cpp src/browserwindow.cpp)

target_link_libraries(CXBronser Qt5::Core Qt5::Gui Qt5::Widgets Qt5::WebEngineWidgets)
