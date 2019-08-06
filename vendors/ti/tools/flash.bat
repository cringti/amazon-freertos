@echo
title Flash test project

:: args: 
:: 1. buildImageName
:: 2. sourcePath

cd %2

:: Enter Uniflash, Simplelink, service pack install paths
set uniflash_dir=C:/ti/uniflash_5.0.0
set sl_dir=C:/Users/a0234018/Desktop/simplelink_cc32xx_sdk_3_20_00_06
set sp=%sl_dir%/tools/cc32xx_tools/servicepack-cc3x20/sp_3.12.0.1_2.0.0.0_2.2.0.6.bin

set image_creator=%uniflash_dir%/simplelink/imagecreator/bin/SLImageCreator.exe

set cert_folder=%sl_dir%/tools/cc32xx_tools/certificate-playground

echo "Creating project..."

mkdir flash
cd flash
mkdir projects
cd projects 

:: Create new Uniflash project
:: Set Service Pack
:: Set Trusted Root-CA Catalog 
:: Add Dummy Cert
:: Set MCU Image
:: Program Image
call %image_creator% project new --name Uniflash_Project --device CC3220SF --project_path %cd%

:: service pack only needs to be set the first time
::call %image_creator% project set_sp --name Uniflash_Project --file %sp% --project_path %cd%

call %image_creator% project set_certstore --name Uniflash_Project --file %cert_folder%/certcatalogPlayGround20160911.lst --sign %cert_folder%/certcatalogPlayGround20160911.lst.signed_3220.bin --project_path %cd%
call %image_creator% project add_file --name Uniflash_Project --file %cert_folder%/dummy-root-ca-cert --fs_path dummy-root-ca-cert --project_path %cd% --overwrite
call %image_creator% project add_file --name Uniflash_Project --file %2/%1 --mcu --project_path %cd% --cert dummy-root-ca-cert --priv %cert_folder%/dummy-root-ca-cert-key --overwrite
call %image_creator% project program --name Uniflash_Project --project_path %cd%

cd %2

pause