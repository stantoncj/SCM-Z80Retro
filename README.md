# SCM for Peter Wilson's Z80 Retro board
======================================

Steve Cousins excellent Small Computer Monitor (SCM) from here: 
https://smallcomputercentral.com/small-computer-monitor-v1-3/

Modified with scm2sjasm cross compiler modifications from me, available here:
https://github.com/stantoncj/scw2sjasm
(this is one of my other personal projects/challenges to build SCM on a Mac)

SCM code modified to allow to run on a Z80 CPU Rev 2.2 by Peter Wilson:
https://oshwlab.com/peterw8102/simple-z80
(Peter set the challenge here: https://github.com/peterw8102/Z80-Retro#third-party-options)

Caveats:
--------
* Currently this is not using the CTC for the UART
* I'm using a 20Mhz Z80 with a 14.7456 Mhz clock to make the UART behave
* It has Basic, but does not have the CPM Loader Working
* It uses all RAM by copying the ROMS and bank switching them out

The board needs to be configured with these jumpers (mostly for the SIO):
* ADDRSIZE = 4M
* CPUCLK = FAST
* SIOCLK = SLOW
* MEMLOW = FLSH
* SIOBCLK = CLKU
* SIOACLK = CLKU
* SIO = SIO0
* P5 = Open

Connect via an FTDI on SA @ 115200 Baud

If you are impatient and just want the results: Hex file to burn is here
https://github.com/stantoncj/SCM/tree/main/Builds/Z80Retro

To do: 
------
Get the CP/M loader to work on the adafruit based SDCARD1 interface



