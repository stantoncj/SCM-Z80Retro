<<<<<<< Updated upstream
#scw2sjasm
=======
scw2sjasm
=========
>>>>>>> Stashed changes

Modifies Z80 assembler from Small Computer Workshop (SCWorkshop) by Steve Cousins
to assemble in sjasmplus  

Build for SCMonitor

<<<<<<< Updated upstream
##Features
========
=======
Features
--------
>>>>>>> Stashed changes
* Modifies all needed directives to allow build of [SCMonitor] to burnable copy
* Requires no manual modification to SCMonitor code
* Runs on OSX (and probably other Linux, but untested)
* Includes [make] file for SCMonitor
* Generates debugger code for running in [Dezog]
* Sample [.vscode] config for Build and Dezog

<<<<<<< Updated upstream
##Requirements (for OSX)
============
Requirements to run scw2sjasm: (for OSX)
* Install [brew](https://brew.sh/) - OSX package manager
* Install [gawk] - [brew install gawk] (you cannot use the distributed OSX awk which is an old distro and missing essential commands)
# Install [sjasmplus] (https://github.com/z00m128/sjasmplus/blob/master/INSTALL.md) (you may have to install other tools to have this make correctly)
# Install [srec_cat] - [brew install srecord] (srec_cat is in the bundle of srecord tools)
# If commands from Terminal refuse to run, you need to run from Finder once and then allow execution in Control Panel
# You can hand run the build at this point and it should work

# To debug, you need to install
# [VSCode](https://code.visualstudio.com/docs/setup/mac) - Visual Studio Code
# [DeZog](https://github.com/maziac/DeZog/) - You can just install this from Visual Studio, look for DeZog
# Configs in .vscode - See included examples
# There are also some nice syntax highlighters you can find by poking around in the extensions
=======
Requirements (for OSX)
----------------------
Requirements to run scw2sjasm: (for OSX)
* Install [brew](https://brew.sh/) - OSX package manager
* Install [gawk] - [brew install gawk] (you cannot use the distributed OSX awk which is an old distro and missing essential commands)
* Install [sjasmplus] (https://github.com/z00m128/sjasmplus/blob/master/INSTALL.md) (you may have to install other tools to have this make correctly)
* Install [srec_cat] - [brew install srecord] (srec_cat is in the bundle of srecord tools)
* If commands from Terminal refuse to run, you need to run from Finder once and then allow execution in Control Panel
* You can hand run the build at this point and it should work

To debug, you need to install
* [VSCode](https://code.visualstudio.com/docs/setup/mac) - Visual Studio Code
* [DeZog](https://github.com/maziac/DeZog/) - You can just install this from Visual Studio, look for DeZog
* Configs in .vscode - See included examples
* There are also some nice syntax highlighters you can find by poking around in the extensions
>>>>>>> Stashed changes

