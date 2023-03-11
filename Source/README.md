scw2sjasm
=========

Modifies Z80 assembler from Small Computer Workshop (SCWorkshop) by Steve Cousins to assemble in sjasmplus

Features
--------
* Modifies all needed directives to allow build of [SCMonitor] to burnable copy
* Builds to a binary equivalent file
* Requires no manual modification to SCMonitor code
* Runs on OSX (and probably other Linux, but untested)
* Includes [make] file for SCMonitor
* Generates debugger code for running in [Dezog]
* Sample [.vscode] config for Build and Dezog

Instructions (for 1.3)
------------
Download Source and Tools from here https://smallcomputercentral.com/small-computer-monitor-v1-3/
Unzip the directory as SCM

This repository must be inserted into the ./SCM/Source directory for SCMonitor (not at ./SCM!)
The SCM/App directory must be available as ../App from the Source directory to include any SCM apps, including BASIC and the CPM Loaders
The SCM/Build directory  must be available as ../Builds from the Source directory to run the binary compare
To use the restore.sh, you need to have second copy of the source unpacked in another directory

Requirements (for OSX)
----------------------
Requirements to run scw2sjasm: (for OSX)
* Install [brew](https://brew.sh/) - OSX package manager
* Install __gawk__ - _brew install gawk_ (you cannot use the distributed OSX awk which is an old distro and missing essential commands)
* Install [sjasmplus](https://github.com/z00m128/sjasmplus/blob/master/INSTALL.md) (you may have to install other tools to have this make correctly)
* Install __srec_cat__ - _brew install srecord_ (srec_cat is in the bundle of srecord tools)
* If commands from Terminal refuse to run, you need to run from Finder once and then allow execution in Control Panel
* You can hand run the build at this point and it should work

The process
-----------
To modify SCM code to compile under sjasmplus:
* __./scw2sjasm.sh__

To build the binary:
* __make__

Development tools: (not used in normal situations):
* __./compare.sh__ - Compares a distributed build hex file with the sjasmplus built binary
* __./restore.sh__ - Resets the entire Source directory to the distribution version

To debug in an IDE, you need to install
* [VSCode](https://code.visualstudio.com/docs/setup/mac) - Visual Studio Code
* [DeZog](https://github.com/maziac/DeZog/) - You can just install this from Visual Studio, look for DeZog
* Configs in .vscode - See included examples
* There are also some nice Z80 syntax highlighters you can find by poking around in the extensions

Questions, Critiques or Accolades directed at me at [stantoncj@gmail.com](mailto: stantoncj@gmail.com)

