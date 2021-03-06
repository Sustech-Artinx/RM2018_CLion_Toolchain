# Beck Pang, 20170824
# Learned from
# https://blog.jetbrains.com/clion/2016/06/clion-for-embedded-development/

cmake_minimum_required(VERSION 3.8)
project(RM2018_CLion_Toolchain C ASM)

set(CMAKE_CXX_STANDARD 11)

file(GLOB_RECURSE USER_SOURCES "Src/*.c" "Test/*.c")
file(GLOB_RECURSE HAL_SOURCES "Drivers/STM32F4xx_HAL_Driver/Src/*.c")
file(GLOB_RECURSE USB_SOURCES
        "Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/*.c"
        "Middlewares/ST/STM32_USB_Device_Library/Core/Src/*.c")

add_library(HAL ${HAL_SOURCES})
add_library(CMSIS
        startup/startup_stm32f427xx.s)
add_library(USB ${USB_SOURCES})

include_directories(Inc)
include_directories(Drivers/STM32F4xx_HAL_Driver/Inc)
include_directories(Drivers/CMSIS/Include)
include_directories(Drivers/CMSIS/Device/ST/STM32F4xx/Include)
include_directories(Drivers/CMSIS/RTOS/Template)
include_directories(Test/Inc)
include_directories(Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc)
include_directories(Middlewares/ST/STM32_USB_Device_Library/Core/Inc)

add_definitions(-DSTM32F427xx)
add_executable(${PROJECT_NAME}.elf ${USER_SOURCES} ${LINKER_SCRIPT})

target_link_libraries(${PROJECT_NAME}.elf HAL CMSIS USB)

set(HEX_FILE ${PROJECT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/cmake-build-debug/${PROJECT_NAME}.bin)
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Obinary $<TARGET_FILE:${PROJECT_NAME}.elf> ${BIN_FILE}
        COMMENT "Building ${HEX_FILE} \nBuilding ${BIN_FILE}")
