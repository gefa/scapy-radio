INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_BT4LE bt4le)

FIND_PATH(
    BT4LE_INCLUDE_DIRS
    NAMES bt4le/api.h
    HINTS $ENV{BT4LE_DIR}/include
        ${PC_BT4LE_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    BT4LE_LIBRARIES
    NAMES gnuradio-bt4le
    HINTS $ENV{ZIGBEE_DIR}/lib
        ${PC_BT4LE_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(BT4LE DEFAULT_MSG BT4LE_LIBRARIES BT4LE_INCLUDE_DIRS)
MARK_AS_ADVANCED(BT4LE_LIBRARIES BT4LE_INCLUDE_DIRS)

