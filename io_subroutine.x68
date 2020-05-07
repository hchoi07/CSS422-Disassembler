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
	TRAP #15

*some input conversion here

INPUT2	LEA	END_REQUEST, A1
	MOVE.B	#14, D0
	TRAP	#15

	LEA	USER_INPUT, A1
	MOVE.B	#2, D0
	TRAP	#15

*some input conversion here



CR	EQU	#0D
LF	EQU	#OA


MESSAGE	DC.B	'This program disassembles a specified region of memory',CR,LF,0
START_REQUEST	DC.B	'Input starting memory location: ',0
END_REQUEST	DC.B	'Input ending memory location: ',0
