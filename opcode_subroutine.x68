*-------------------------------------------
* opcode_subroutine
* This subroutine masks the machine code to only
* show the opcode. The mask used is $F000, this 
* ensures that only the first 4 bits are being
* looked at to match the opcode.
* D0 is used copied into D1 where the masking 
* may occur.
* D0 passes in the machine code word
*-------------------------------------------
opcode_subroutine:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0, D1
        MOVE.W      #mask_opcode,D2      *move the mask into D2
        AND         D2,D1               *mask the full machine code by the opcode mask
        
        *CMP.W       ,D1

        MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        *INCLUDE 'strings.x68'










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
