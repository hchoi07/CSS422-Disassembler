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

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
