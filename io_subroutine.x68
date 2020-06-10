*-----------------------------------------------------------
* Subroutine Title: io_subroutine
* Description: This subroutine asks the user for two sets of 
* 8 ascii characters and tests a couple conditions, if the
* ending address is greater than the starter address, if
* the input is in the given range, if only hex digits are given
* and if the input is on a word boundary.
* A2 passes the starting address
* A3 passes the ending address
*-----------------------------------------------------------

io_subroutine:
            MOVEM.L      D0-D1/D4-D7/A0-A6,-(SP)
            *display the intro message to the user
	        LEA	        LOAD_MESSAGE, A1
	        MOVE.B	    #13, D0
	        TRAP	    #15
	        *display the intro message to the user
	        LEA	        LOAD2_MESSAGE, A1
	        MOVE.B	    #13, D0
	        TRAP	    #15

*prompt the user for starting input
INPUT1	    LEA	        START_REQUEST, A1
	        MOVE.B	    #14, D0
	        TRAP        #15

            *------Code for input-----
            MOVE.B      #0,D4           *counter 
            MOVE.B      #8,D5
input_loop  CMP.B       D4,D5           *loop 8 time for a long info
            BEQ         ipt_done
            *inside loop code
            MOVE.B      #5,D0           *Trap task 5: read a character from keyboard into D1.L
            TRAP        #15
            MOVE.B      D1,D6
            JSR         toHex           *convert the value to hex
            LSL.L       #4,D7           *Move the hex value one byte left
            ADD.L       D6,D7           *append the character to the input
            *loop code done
cont        ADDQ.B      #1,D4           *increment the counter
            BRA         input_loop
            
            
ipt_done    *provide a new line
            LEA	        SPACE, A1
	        MOVE.B	    #14, D0
	        TRAP        #15
            *test if there was a non hex value inputted
            CMP.L       #not_hex,D2
            BNE         input1pass
            *else, display message
            LEA         NOT_HEX_MSG, A1
            MOVE.B	    #13, D0
	        TRAP	    #15
	        MOVE.L      #hex_clear,D2
	        BRA         INPUT1
            
input1pass  MOVE.L      D7,D3   *move the hex value to D3
     
boundary1:
            *test if input is on the word boundary
            MOVE.L      D3,D4
            DIVU        #2,D4
            CLR.W       D4
            SWAP        D4
            
            CMP.L       #hex_clear,D4
            BEQ         INPUT2
            *else, not on boundary
            LEA	        BAD_BOUND, A1
	        MOVE.B	    #13, D0
	        TRAP	    #15   
	        *go back to start
            BRA         INPUT1  
            
*Get the ending address
*prompt the user for starting input
INPUT2	    LEA	        END_REQUEST, A1
	        MOVE.B	    #14, D0
	        TRAP        #15

            *------Code for input-----
            MOVE.B      #0,D4           *counter 
            MOVE.B      #8,D5
input_loop2 CMP.B       D4,D5           *loop 8 time for a long info
            BEQ         ipt_done2
            *inside loop code
            MOVE.B      #5,D0           *Trap task 5: read a character from keyboard into D1.L
            TRAP        #15
            MOVE.B      D1,D6
            JSR         toHex           *convert the value to hex
            LSL.L       #4,D7           *Move the hex value one byte left
            ADD.L       D6,D7           *append the character to the input
            *loop code done
cont2       ADDQ.B      #1,D4           *increment the counter
            BRA         input_loop2
            
            
ipt_done2   *provide a new line
            LEA	        SPACE, A1
	        MOVE.B	    #14, D0
	        TRAP        #15
	        *test if there was a non hex value inputted
            CMP.L       #not_hex,D2
            BNE         input2pass
            *else, display message
            LEA         NOT_HEX_MSG, A1
            MOVE.B	    #13, D0
	        TRAP	    #15
	        MOVE.L      #hex_clear,D2
	        BRA         INPUT2
            
input2pass  MOVE.L      D7,D2   *move the hex value to D2
	        	        
boundary2:
            *test if input is on the word boundary
            MOVE.L      D2,D4
            DIVU        #2,D4
            CLR.W       D4
            SWAP        D4
            
            CMP.L       #hex_clear,D4
            BEQ         test_ends
            *else, not on boundary
            LEA	        BAD_BOUND, A1
	        MOVE.B	    #13, D0
	        TRAP	    #15   
	        *go back to start
            BRA         INPUT2  

test_ends:  
            *test if the starting address is less than the ending address
            CMP.L       D3,D2
            BLE         end_bad
            MOVEM.L      (SP)+,D0-D1/D4-D7/A0-A6
            RTS

end_bad:    
            *not in correct range
            LEA	        BAD_END, A1
	        MOVE.B	    #13, D0
	        TRAP	    #15   
	        *go back to start
            BRA         INPUT1  

    




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
