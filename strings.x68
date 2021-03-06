* Masks
*mask_opcode     DC.W    $F000
* Opcodes
opcode_MOVEB	DC.B	'MOVE.B',0
opcode_MOVEW	DC.B	'MOVE.W',0
opcode_MOVEL    DC.B	'MOVE.L',0
opcode_MOVEM	DC.B	'MOVEM',0
opcode_MOVEQ	DC.B	'MOVEQ',0
opcode_MOVEAB	DC.B	'MOVEA.B',0
opcode_MOVEAW	DC.B	'MOVEA.W',0
opcode_MOVEAL	DC.B	'MOVEA.L',0
opcode_NOP  	DC.B	'NOP',0
opcode_ADDB  	DC.B	'ADD.B',0
opcode_ADDW  	DC.B	'ADD.W',0
opcode_ADDL  	DC.B	'ADD.L',0
opcode_ADDAW  	DC.B	'ADDA.W',0
opcode_ADDAL  	DC.B	'ADDA.L',0
opcode_ADDQB  	DC.B	'ADDQ.B',0
opcode_ADDQW  	DC.B	'ADDQ.W',0
opcode_ADDQL  	DC.B	'ADDQ.L',0
opcode_SUBB  	DC.B	'SUB.B',0
opcode_SUBW  	DC.B	'SUB.W',0
opcode_SUBL  	DC.B	'SUB.L',0
opcode_LEA  	DC.B	'LEA',0
opcode_ANDB  	DC.B	'AND.B',0
opcode_ANDW  	DC.B	'AND.W',0
opcode_ANDL  	DC.B	'AND.L',0
opcode_ORB      DC.B	'OR.B',0
opcode_ORW  	DC.B	'OR.W',0
opcode_ORL  	DC.B	'OR.L',0
opcode_NOTB  	DC.B	'NOT.B',0
opcode_NOTW  	DC.B	'NOT.W',0
opcode_NOTL  	DC.B	'NOT.L',0
opcode_LSLB  	DC.B	'LSL.B',0
opcode_LSLW  	DC.B	'LSL.W',0
opcode_LSLL  	DC.B	'LSL.L',0
opcode_LSRB  	DC.B	'LSR.B',0
opcode_LSRW  	DC.B	'LSR.W',0
opcode_LSRL  	DC.B	'LSR.L',0
opcode_ASLB  	DC.B	'ASL.B',0
opcode_ASLW  	DC.B	'ASL.W',0
opcode_ASLL  	DC.B	'ASL.L',0
opcode_ASRB  	DC.B	'ASR.B',0
opcode_ASRW  	DC.B	'ASR.W',0
opcode_ASRL  	DC.B	'ASR.L',0
opcode_ROLB  	DC.B	'ROL.B',0
opcode_ROLW  	DC.B	'ROL.W',0
opcode_ROLL  	DC.B	'ROL.L',0
opcode_RORB  	DC.B	'ROR.B',0
opcode_RORW  	DC.B	'ROR.W',0
opcode_RORL  	DC.B	'ROR.L',0
opcode_BGT  	DC.B	'BGT',0
opcode_BLE  	DC.B	'BLE',0
opcode_BEQ  	DC.B	'BEQ',0
opcode_JSR  	DC.B	'JSR',0
opcode_RTS  	DC.B	'RTS',0
opcode_BRA  	DC.B	'BRA',0
opcode_MOVEMW   DC.B    'MOVEM.W',0
opcode_MOVEML   DC.B    'MOVEM.L',0
opcode_DATA  	DC.B	'DATA',0
*io strings
CR	        EQU 	$0D	*ASCII code for carriage return
LF	        EQU	    $0A	*ASCII code for line feed
HT          EQU     $09 *ASCII code for horizontal tab

LOAD_MESSAGE	DC.B	'Welcome to The Disassemblers CSS 422 projectA',CR,LF,'Select "demo_test.s68" in File->Open Data for test data',CR,LF,0
LOAD2_MESSAGE   DC.B    'If you got to this page without loading the test file,',CR,LF,'please exit and follow the directions above.',CR,LF,0
START_REQUEST	DC.B	'Input starting memory location between $00007000 and $000073BA',CR,LF,'in the format "########": ',0
END_REQUEST	    DC.B	'Input ending memory location between $00007000 and $000073BA',CR,LF,'in the format "########": ',0
NOT_HEX_MSG	    DC.B    'Input was not in the hexadecimal range 0-F',0
BAD_RANGE       DC.B    'Input is not in the range between $00007000 and $000073BA',CR,LF,0
BAD_END         DC.B    'Ending location is less than the starting location, please switch the inputs.',CR,LF,0
BAD_BOUND       DC.B    'Input is not on an input boundary, please enter address divisible by 2.',CR,LF,0
SPACE           DC.B    CR,LF,0
PRESS_ENTER     DC.B    'Press ENTER to continue.',CR,LF,0
TAB             DC.B    HT,0









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
