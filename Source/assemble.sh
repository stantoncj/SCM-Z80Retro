cd Output

srec_cat \
-MULTiple \
code_output_0000.bin -binary -offset 0x0000 \
code_output_0311.bin -binary -offset 0x0311 \
code_output_044e.bin -binary -offset 0x044e \
code_output_04bf.bin -binary -offset 0x04bf \
code_output_051a.bin -binary -offset 0x051a \
code_output_057f.bin -binary -offset 0x057f \
code_output_08ca.bin -binary -offset 0x08ca \
code_output_097e.bin -binary -offset 0x097e \
code_output_0feb.bin -binary -offset 0x0feb \
code_output_1266.bin -binary -offset 0x1266 \
code_output_13db.bin -binary -offset 0x13db \
code_output_18a6.bin -binary -offset 0x18a6 \
code_output_18ca.bin -binary -offset 0x18ca \
code_output_194d.bin -binary -offset 0x194d \
code_output_1b13.bin -binary -offset 0x1b13 \
code_output_1b5d.bin -binary -offset 0x1b5d \
-line-length=44 -o code_output.hex -Intel

cd ..
