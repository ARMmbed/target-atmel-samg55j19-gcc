# Copyright (C) 2014-2015 ARM Limited. All rights reserved.

if(TARGET_SAMG55J19_GCC_TOOLCHAIN_INCLUDED)
    return()
endif()
set(TARGET_SAMG55J19_GCC_TOOLCHAIN_INCLUDED 1)

set(CMAKE_SYSTEM_NAME mbedOS)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR "armv6-m")

# provide compatibility definitions for compiling with this target: these are
# definitions that legacy code assumes will be defined. Before adding something
# here, think VERY CAREFULLY if you can't change anywhere that relies on the
# definition that you're about to add to rely on the TARGET_LIKE_XXX
# definitions that yotta provides based on the target.json file.
#
add_definitions("-D__SAMG55J19__ -D__CORTEX_M4 -DTOOLCHAIN_GCC -DTOOLCHAIN_GCC_ARM -DMBED_OPERATORS -DTARGET_SAMG55J19 -DI2C_MASTER_CALLBACK_MODE=true -DEXTINT_CALLBACK_MODE=true -DUSART_CALLBACK_MODE=true -DTC_ASYNC=true -DBOARD=75")

# append non-generic flags, and set Atmel G55-specific link script

set(_CPU_COMPILATION_OPTIONS "-mcpu=cortex-m4 -mthumb")

set(CMAKE_C_FLAGS_INIT             "${CMAKE_C_FLAGS_INIT} ${_CPU_COMPILATION_OPTIONS}")
set(CMAKE_ASM_FLAGS_INIT           "${CMAKE_ASM_FLAGS_INIT} ${_CPU_COMPILATION_OPTIONS}")
set(CMAKE_CXX_FLAGS_INIT           "${CMAKE_CXX_FLAGS_INIT} ${_CPU_COMPILATION_OPTIONS}")
set(CMAKE_MODULE_LINKER_FLAGS_INIT "${CMAKE_MODULE_LINKER_FLAGS_INIT} -mcpu=cortex-m0plus -mthumb")
set(CMAKE_EXE_LINKER_FLAGS_INIT    "${CMAKE_EXE_LINKER_FLAGS_INIT} -mcpu=cortex-m4 -mthumb -u _printf_float -u _scanf_float, -T\"${CMAKE_CURRENT_LIST_DIR}/../ld/samg55j19.ld\"") 

# post-process elf files into .bin files:
set(YOTTA_POSTPROCESS_COMMAND "arm-none-eabi-objcopy -O ihex YOTTA_CURRENT_EXE_NAME YOTTA_CURRENT_EXE_NAME.hex")
