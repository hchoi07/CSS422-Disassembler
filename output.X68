*-----------------------------------------------------------
* Subroutine Title: print_string
* Description: This subroutine prints the info currently in A1
* A1 passes in the output
*-----------------------------------------------------------
print_string:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    MOVE.B      #14,D0              *move number 14 into d0 for string plus
    TRAP        #15
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS
    
*-----------------------------------------------------------
* Subroutine Title: print_hex
* Description: This subroutine prints the info currently in A1
* in base 16 (hexadecimal)
* D1 passes in the output
*-----------------------------------------------------------
print_hex:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    MOVE.B      #15,D0
    MOVE.B      #16,D2          *display in base 16 (hex)
    TRAP        #15
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS

*-----------------------------------------------------------
* Subroutine Title: print_string_nl
* Description: This subroutine prints the line number, tab for
* spaceing, the opcode (currently in A1), another tab, and the 
* opcode.
* A1 passes in the output
*-----------------------------------------------------------
print_string_op_nn:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    MOVE.W      D0,D3           *move full opcode to D2 temporarily
    MOVEA.L     A1,A2           *move string into A2 temp
    *print the line number
    JSR         print_line_number
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print data
    MOVE.L      A2,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS


*-----------------------------------------------------------
* Subroutine Title: print_string_nl
* Description: This subroutine prints the line number, tab for
* spaceing, the opcode (currently in A1), another tab, and the 
* opcode.
* A1 passes in the output
*-----------------------------------------------------------
print_string_op_nl:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    MOVE.W      D0,D3           *move full opcode to D2 temporarily
    MOVEA.L     A1,A2           *move string into A2 temp
    *print the line number
    JSR         print_line_number
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print data
    MOVE.L      A2,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print opcode
    MOVE.W      D3,D1
    MOVE.B      #15,D0
    MOVE.B      #16,D2          *display in base 16 (hex)
    TRAP        #15
    *print new line
    LEA         SPACE,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS

*-----------------------------------------------------------
* Subroutine Title: print_string_nl
* Description: This subroutine prints the line number, tab for
* spaceing, the opcode (currently in A1), another tab, and the 
* opcode.
* A1 passes in the output
* D1 has the opcode
*-----------------------------------------------------------
print_string_sized:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    MOVE.L      D1,D3           *move full opcode to D2 temporarily
    MOVEA.L     A1,A2           *move string into A2 temp
    *print the line number
    JSR         print_line_number
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print data
    MOVE.L      A2,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print opcode
    MOVE.L      D1,D1
    MOVE.B      #15,D0
    MOVE.B      #16,D2          *display in base 16 (hex)
    TRAP        #15
    *print new line
    LEA         SPACE,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS

*-----------------------------------------------------------
* Subroutine Title: print_string_nl
* Description: This subroutine prints the line number, tab for
* spaceing, the opcode (currently in A1), another tab, and the 
* opcode.
* A1 passes in the output
*-----------------------------------------------------------
print_data:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    MOVE.W      D0,D3           *move full opcode to D2 temporarily
    MOVEA.L     A1,A2           *move string into A2 temp
    *print the line number
    JSR         print_line_number
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print data
    MOVE.L      A2,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print a tab
    LEA         TAB,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    *print opcode
    MOVE.W      D3,D1
    MOVE.B      #15,D0
    MOVE.B      #16,D2          *display in base 16 (hex)
    TRAP        #15
    *print new line
    LEA         SPACE,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS


*-----------------------------------------------------------
* Subroutine Title: print_string_nl
* Description: This subroutine prints current line number with
* 8 digits
*-----------------------------------------------------------
print_line_number:
            MOVEM.L     D0-D7/A0-A6, -(SP)
            MOVE.L      A0,D3
            MOVE.L      #0,D4           *counter 
            MOVE.L      #8,D5
            CLR.L       D1
            MOVE.L      #15,D0
            MOVE.L      #16,D2          *display in base 16 (hex)
line_loop   CMP.B       D4,D5           *loop 2 time for a byte of info
            BEQ         line_done
            *inside loop code
            ROL.L       #4,D3          *rotate bits so last is first
            MOVE.B      D3,D1
            LSL.B       #4,D1           *rotate left then right to get rid 
            LSR.B       #4,D1           *of the other character
            TRAP        #15             *print 1 hex character
            
            *loop code done
            ADDQ.B  #1,D4           *increment the counter
            BRA     line_loop
            
line_done   MOVEM.L     (SP)+, D0-D7/A0-A6
            RTS
            
*-----------------------------------------------------------
* Subroutine Title: print_ea
* Description: This subroutine prints the ea string in A1
* A1 passes in the output
*-----------------------------------------------------------
print_eat:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    *print data
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS
    
*-----------------------------------------------------------
* Subroutine Title: print_ea_end
* Description: This subroutine prints the ea string in A1
* appended with a new line. Used for the second ea.
* A1 passes in the output
*-----------------------------------------------------------
print_ea:
    MOVEM.L     D0-D7/A0-A6, -(SP)
    *print data
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data in A1
    *print new line
    LEA         SPACE,A1
    MOVE.B      #14,D0              *move number 14 into d0 for string
    TRAP        #15                 *print the data
    MOVEM.L     (SP)+, D0-D7/A0-A6
    RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
