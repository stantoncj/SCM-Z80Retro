scw2sjasm
=========

Modifies Z80 assembler from Small Computer Workshop (SCWorkshop) by Steve Cousins
to assemble in sjasmplus  

Build for SCMonitor

Features
--------
* Modifies all needed directives to allow build of [SCMonitor] to burnable copy
* Requires no manual modification to SCMonitor code
* Runs on OSX (and probably other Linux, but untested)
* Includes [make] file for SCMonitor
* Generates debugger code for running in [Dezog]
* Sample [.vscode] config for Build and Dezog

Requirements (for OSX)
----------------------
Requirements to run scw2sjasm: (for OSX)
* Install [brew](https://brew.sh/) - OSX package manager
* Install __gawk__ - _brew install gawk_ (you cannot use the distributed OSX awk which is an old distro and missing essential commands)
* Install [sjasmplus](https://github.com/z00m128/sjasmplus/blob/master/INSTALL.md) (you may have to install other tools to have this make correctly)
* Install __srec_cat__ - _brew install srecord_ (srec_cat is in the bundle of srecord tools)
* If commands from Terminal refuse to run, you need to run from Finder once and then allow execution in Control Panel
* You can hand run the build at this point and it should work

To debug, you need to install
* [VSCode](https://code.visualstudio.com/docs/setup/mac) - Visual Studio Code
* [DeZog](https://github.com/maziac/DeZog/) - You can just install this from Visual Studio, look for DeZog
* Configs in .vscode - See included examples
* There are also some nice syntax highlighters you can find by poking around in the extensions

