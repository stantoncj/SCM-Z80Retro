build_dir=build
scm="./$(build_dir)/!Main"

SCMonitor: !Main.asm

# Remove and recreate build directory
	rm -rf ./$(build_dir)
	mkdir ./$(build_dir)

# Assemble!
	sjasmplus --fullpath --sym=$(scm).sym --lst=$(scm).lst --sld=$(scm).sld "!Main.asm"

# Creates a zero byte !Main.bin file which we can remove
	rm ./"!Main.bin" 

# Due to limitations between sjasmplus linear build and SCMonitor being able to build out of order
# we have to reassemble all of the output files
	sh ./link.sh $(build_dir)

# EOF

