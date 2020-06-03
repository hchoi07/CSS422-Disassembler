*-----------------------------------------------------------
* Subroutine Title: main_loop
* Description: 
* D3 passes in the starting address and D2 passes in the
* ending address.
*-----------------------------------------------------------
main_loop:
            MOVE.B      #0,D4           *counter 
            MOVE.B      #30,D5

            MOVE.L      D3,A0   *move the starting address to A0
            MOVE.L      D2,A2   *move the ending address to A2
loopM       CMP.L       A0,A2
            BEQ         loopM_done
            *inside loop code
            DIVU        #30,D4      *test if full page has been reached
            CLR.W       D4
            SWAP        D4
            CMP.L       #hex_clear,D4
            BNE         loopM_Cont
            *pause till enter inputted
            *display the prompt message to the user
entr_lp     LEA	        PRESS_ENTER, A1
	        MOVE.B	    #13, D0
	        TRAP	    #15
	        *look for enter key
	        MOVE.B      #5,D0           *Trap task 5: read a character from keyboard into D1.L
            TRAP        #15
            CMP.L       #CR,D1          
            BEQ         loopM_Cont      *continue if enter pressed
            CMP.L       #LF,D1
            BEQ         loopM_Cont
            BRA         entr_lp
            *resume
loopM_Cont  MOVE.W      (A0),D0 *move the opcode into D0 for testing
            JSR         opcode_subroutine
            *loop code end
            ADDQ        #2,A0   *move the pointer one word
            ADDQ        #1,D4   *add one to the output counter
            BRA         loopM   
                
loopM_done  RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
