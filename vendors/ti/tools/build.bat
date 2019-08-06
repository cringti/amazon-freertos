@echo
title Build test project

:: args:
:: 1. enableTests
:: 2. sourcePath

:: Enter cmake/make install paths
set cmake=C:/Users/a0234018/Desktop/cmake-3.14.5-win64-x64/cmake-3.14.5-win64-x64/bin/cmake.exe
set make=C:/ti/ccs901/xdctools_3_55_00_11_core/gmake.exe

:: Enter CCS install path
set CCS_dir=C:/ti/ccs901

:: Update compiler tools path is version is different
set compiler_tools=%CCS_dir%/ccs/tools/compiler/ti-cgt-arm_18.12.2.LTS

set utils_folder=%CCS_dir%/ccs/utils

set tiobj2bin=%utils_folder%/tiobj2bin/tiobj2bin.bat

:: obj2bin command paths
set armofd=%compiler_tools%/bin/armofd.exe
set armhex=%compiler_tools%/bin/armhex.exe
set mkhex4bin=%utils_folder%/tiobj2bin/mkhex4bin.exe

cd %2

echo Starting cmake...

::set CFLAGS="-D AMAZON_FREERTOS_ENABLE_UNIT_TESTS"
%cmake% -DVENDOR=ti -DBOARD=cc3220_launchpad -DCOMPILER=arm-ti -DAFR_TOOLCHAIN_PATH=%compiler_tools% -DCMAKE_MAKE_PROGRAM=%make% -S . -B ./build -DAFR_ENABLE_TESTS=%1 -G "Unix Makefiles"

cd build
echo Running make...
%make% -j

cd %2

echo "Creating .bin from .out file..."

:: tiobj2bin creates a .bin from a .out (CALL is used for nested batch filesin Windows)
::	1st param = .out file
::	2nd param = .bin file to create
::	3rd param = ofd command to use (one located in ccs compiler tools)
::	4th param = hex command to use (one located in ccs compiler tools)
::	5th param = mkhex4bin command to use (one located in same folder as tiobj2bin in ccs utils)
call %tiobj2bin% ./build/aws_tests.out mcuflashimg.bin %armofd% %armhex% %mkhex4bin% 

pause