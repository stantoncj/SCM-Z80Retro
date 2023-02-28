# Build all of the seperate bin files into a single bin with the correct offsets
# Note there is a byte or two of overlap where the warning has been suppressed

find ./Output/code_output_*.bin | sort > ./Output/build_hex.txt
gawk -i inplace "// {s=substr(\$0,22,4); print \$0 \" -binary -offset 0x\" s; next}\
  BEGINFILE {print \"--multiple\"};\
  ENDFILE {print \"--line-length=44 -o ./Output/SCMonitor.bin -binary\"}"\
  ./Output/build_hex.txt
# for some reason putting the offset 0x0000 file fail to create a full file
# putting it last (but not reversing order!) will work properly
gawk -i inplace "/0000/ {s=\$0; next;}; /line-length/ {print s \"\\n\" \$0; next;}; {print}" ./Output/build_hex.txt
srec_cat @./Output/build_hex.txt
