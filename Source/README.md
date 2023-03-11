scw2sjasm
=========

Modifies Z80 assembler from Small Computer Workshop (SCWorkshop) by Steve Cousins to assemble in sjasmplus

Kudos to Steve for his work on SCWorkshop and SCMonitor!  An essential contribution to the Z80 retrocompute community.

This is my contribution to allow SCM builds on OSX (or other Linux)  
As tempting as it was to just fire up SCW on Windows, I never actually did during this project - This is 100% reverse engineered

Released under an Open Source [MIT License](https://github.com/stantoncj/scw2sjasm/blob/main/LICENSE.md)  
Please credit me (and Steve Cousins) in any derivatives

Questions, Critiques or Accolades directed at me at stantoncj@gmail.com

Features
--------
* Modifies all needed directives to allow build of __SCMonitor__ to burnable copy
* Builds to a binary equivalent file
* Requires no manual modification to SCMonitor code
* Runs on OSX (and probably other Linux, but untested)
* Includes __make__ file for SCMonitor
* Generates debugger code for running in __DeZog__
* Sample __.vscode__ config for Build and __DeZog__

Instructions (for 1.3)
------------
Install the [Requirements](#requirements-for-osx) below

Download Source and Tools from here https://smallcomputercentral.com/small-computer-monitor-v1-3/  
- Unzip the Repository
~~~~
cd ./{SCW directory}/SCMonitor/Source
git clone https://github.com/stantoncj/scw2sjasm
cp scw2sjasm/* .
cp scw2sjasm/.vscode .
~~~~

You should be able to run the scw2sjasm code (see [Process](#the-process))

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
* Install __git__ - _brew install git_ (or use your choice of GUI git tools such as the excellent [GitKraken](https://www.gitkraken.com/))
* You should check all of these run on the command line (tested versions listed in scw2sjasm.awk)
* If commands from Terminal refuse to run, you need to run from Finder once or allow execution in Control Panel

The process
-----------
To modify SCM code to compile under sjasmplus: (this runs only once)  
__./scw2sjasm.sh__

To build the binary: (you can choose hex or bin in the makefile)  
__make__


scw2sjasm Development tools: (not used in normal situations):\
__./compare.sh__ - Compares a distributed build hex file with the sjasmplus built binary\
__./restore.sh__ - Resets the entire Source directory to the distribution version

To debug in an IDE, you need to install
* [VSCode](https://code.visualstudio.com/docs/setup/mac) - Visual Studio Code
* [DeZog](https://github.com/maziac/DeZog/) - You can just install this from Visual Studio, look for DeZog
* Configs in __.vscode__ - See included examples  
    -.vscode/tasks.json should do a build with make without mods (shift-command-B)  
    -.vscode/launch.json should work to launch a DeZog debugger (shift-command-D)  
* There are also some nice Z80 syntax highlighters (I use ASM Code Lens) you can find by poking around in the VSCode extensions



