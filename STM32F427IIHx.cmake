# Beck Pang, 20170824
# cross-compiler for gcc-arm-embedded
# https://blog.jetbrains.com/clion/2016/06/clion-for-embedded-development/

SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)

# specify the cross compiler
SET(CMAKE_C_COMPILER_WORKS 1)
SET(CMAKE_C_COMPILER arm-none-eabi-gcc)
SET(CMAKE_CXX_COMPILER arm-none-eabi-g++)

SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/STM32F427IIHx_FLASH.ld)

# Uncomment for software floating point
# Options for gcc
# https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
#SET(COMMON_FLAGS "-mcpu=cortex-m4 -mthumb -mthumb-interwork -mfloat-abi=soft -ffunction-sections -fdata-sections -g -fno-common -fmessage-length=0") -specs=nano.specs
SET(COMMON_FLAGS "-mcpu=cortex-m4 -mthumb -mthumb-interwork -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdatda-sections -g -fno-common -fmessage-length=0 -specs=nosys.specs")
SET(CMAKE_CXX_FLAGS_INIT "${COMMON_FLAGS} -std=c++11")
SET(CMAKE_C_FLAGS_INIT "${COMMON_FLAGS} -std=gnu99")
SET(CMAKE_EXE_LINKER_FLAGS_INIT "-Wl,-gc-sections,-Map=binary.map -T ${LINKER_SCRIPT}")