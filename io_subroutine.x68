*----------------------------
* io_subroutine
* prompts user for input
*----------------------------

io_subroutine:
	
	LEA	MESSAGE, A1
	MOVE.B	#13, D0
	TRAP	#15

INPUT1	LEA	START_REQUEST, A1
	MOVE.B	#14, D0
	TRAP #15

	LEA	USER_INPUT, A1
	MOVE.B	#2, D0
	TRAP	#15
	BRA	CHECK_INPUT

*some input conversion here

INPUT2	LEA	END_REQUEST, A1
	MOVE.B	#14, D0
	TRAP	#15

	LEA	USER_INPUT, A1
	MOVE.B	#2, D0
	TRAP	#15
	BRA     CHECK_INPUT

*some input conversion here

CHECK_INPUT
	*check for valid input size 
	*if passed, go to hex conversion
	CMPI.B	#4, D1	*D1 stores length of keyboard input string
	BLT	CHECK_SIZE
	CMPI.B	#8, D1
	BGT	CHECK_SIZE
	BRA	CONVERTER

CHECK_SIZE
	*handle invalid input size


CONVERTER
	*ASCII to hex/hex to ASCII converter


CR	EQU	#0D	*ASCII code for carriage return
LF	EQU	#OA	*ASCII code for line feed


MESSAGE	DC.B	'This program disassembles a specified region of memory',CR,LF,0
START_REQUEST	DC.B	'Input starting memory location: ',0
END_REQUEST	DC.B	'Input ending memory location: ',0
