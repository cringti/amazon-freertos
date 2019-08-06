# Using the Build and Flash Tools with Amazon IDT
###### 08-2019

### Build Tool
###### Note: The current build tool is configured for the CC3220 board. To create a build for the CC3235, change the cmake BOARD value to cc3235_launchpad.
Before running the build tool, make sure to edit the cmake, make, CCS install, and compiler tools paths.

The build tool takes in 3 parameters:
1. A boolean (1 or 0) which indicates whether the IDT tests are enabled.
2. The path to the source directory.

The build tool runs cmake and then make.
Once the project has been built, the tool creates a binary file, called mcuflashimg.bin, from the generated .out file.


### Flash Tool
###### Note: The current build tool is configured for the CC3220 board. To flash the CC3235, change the Service Pack directory, signed certcatalog, and Image Creator's device value.
Before running the flash tool, make sure to edit the Uniflash, SimpleLink, and Service Pack install directories.

The flash tool takes in 2 parameters:
1. The name of the output binary file.
2. The path to the source directory.

The flash tool generates a Uniflash project using dummy certificates and the specified binary file. It then flashes this program to the board.


### Using the Tools with the Amazon IDT
In userdata.json you can configure the build and flash tools the Amazon IDT uses.

For the build tool, make sure to pass in the Amazon variables `enableTests` and `testData.sourcePath`.  
```json
"buildTool": {
    "name": "cmake",
    "version": "3.14.5",
    "command": [
      "C:/Users/a0234018/Desktop/build.bat {{enableTests}} {{testData.sourcePath}}"
    ]
  },
```
For the flash tool, make sure to pass in the Amazon variables `buildImageName` and `testData.sourcePath` and set `testsImageName` to `mcuflashimg.bin`.
```json
"flashTool": {
    "name": "Uniflash",
    "version": "5.0.0",
    "command": [
      "C:/Users/a0234018/Desktop/flash.bat {{buildImageName}} {{testData.sourcePath}}"
    ],
    "buildImageInfo" : {
      "testsImageName": "mcuflashimg.bin",
      "demosImageName": "aws_demos.out"
    }
  },
```

For additional information about Amazon IDT, please see [Using AWS IoT Device Tester for Amazon FreeRTOS](https://docs.aws.amazon.com/freertos/latest/userguide/device-tester-for-freertos-ug.html)