scm="!Main"
builddir="build"

SCMonitor: !Main.asm
	sjasmplus --fullpath --sym=$(scm).sym --lst=$(scm).lst --sld=$(scm).sld "!Main.asm"

# Due to limitations between sjasmplus linear build and SCMonitor being able to build out of order
# we have to reassemble all of the output files into the correct structure

	sh ./assemble.sh



