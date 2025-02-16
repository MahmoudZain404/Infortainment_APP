set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Cross compiler path
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)

# Use Raspberry Pi sysroot (modify path if necessary)
set(SYSROOT /mnt/rpi-sysroot)
set(CMAKE_SYSROOT ${SYSROOT})

# Find Qt6 on Raspberry Pi
set(Qt6_DIR ${SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/Qt6)

set(CMAKE_FIND_ROOT_PATH ${SYSROOT})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

