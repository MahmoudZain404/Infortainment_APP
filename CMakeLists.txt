cmake_minimum_required(VERSION 3.16)

project(Infotainment_App VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appInfotainment_App
    main.cpp
)

qt_add_qml_module(appInfotainment_App
    URI Infotainment_App
    VERSION 1.0
    QML_FILES
        Main.qml
SOURCES Controllers/bluetoothmanager.cpp Controllers/bluetoothmanager.h Controllers/system.cpp Controllers/system.h
RESOURCES ui/assets/bluetoothOff.png ui/assets/bluetoothOn.png ui/assets/cameraOff.png ui/assets/cameraOn.png ui/assets/Car_Render_mp4.mp4 ui/assets/car_render_white.jpeg ui/assets/Car_settings_ic.png ui/assets/carLocked.png ui/assets/carUnlocked.png ui/assets/DriveOff.png ui/assets/DriveOn.png ui/assets/driver.png ui/assets/istockphoto-1505836431-640_adpp_is.mp4 ui/assets/mode.png ui/assets/music.png ui/assets/musicOff.png ui/assets/next-button.png ui/assets/ParkOff.png ui/assets/ParkOn.png ui/assets/pause-button.png ui/assets/play.png ui/assets/previous.png ui/assets/RadioOff.png ui/assets/RadioOn.png  ui/assets/ReverseOff.png ui/assets/ReverseOn.png ui/assets/settingsBackground.jpg ui/assets/slideshow.png ui/assets/slow_Music.mp3 ui/assets/stop-button.png ui/assets/volume-mute.png ui/assets/volume-up.png ui/assets/wallpeper1.jpg ui/assets/wallpeper2.jpg ui/assets/wallpeper3.jpg ui/assets/wallpeper4.jpg ui/assets/wallpeper5.jpg ui/assets/wallpeper6.jpg ui/assets/wallpeper7.jpg
QML_FILES ui/BottomBar/Bottom_Bar.qml ui/LiftScreen/Lift_Screen.qml ui/RightScreen/Right_Screen.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appInfotainment_App PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appInfotainment_App
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appInfotainment_App
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appInfotainment_App
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
