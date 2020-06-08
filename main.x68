*-----------------------------------------------------------
* Title      : Main File
*-----------------------------------------------------------
            ORG $1000
MAIN:
            MOVEA.L #$00100000,SP
    
run_prog    JSR     io_subroutine
            JSR     main_loop

            SIMHALT             ; halt simulator   
        
            INCLUDE 'toHex.x68'
            INCLUDE 'io_subroutine.x68'
            INCLUDE 'main_loop.x68'
            INCLUDE 'output.x68'
            INCLUDE 'opcode_size.X68'
            INCLUDE 'opcode_subroutine.x68'
            INCLUDE 'ADD Subroutine.x68'
            INCLUDE 'AND Subroutine.x68'
            INCLUDE 'ADDA Subroutine.x68'
            INCLUDE 'ADDQ Subroutine.x68'
            INCLUDE 'ASD Subroutine.x68'
            INCLUDE 'JSR Subroutine.x68'
            INCLUDE 'LEA Subroutine.x68'
            INCLUDE 'MOVE Subroutine.x68'
            INCLUDE 'MOVEM Subroutine.x68'
            INCLUDE 'SUB Subroutine.x68'
            INCLUDE 'LSD Subroutine.x68'
            INCLUDE 'MOVEA Subroutine.x68'
            INCLUDE 'MOVEQ Subroutine.x68'
            INCLUDE 'NOT Subroutine.x68'
            INCLUDE 'OR Subroutine.x68'
            INCLUDE 'ROD Subroutine.x68'
            INCLUDE 'EA Masks.x68'
            INCLUDE 'variables.X68'
            INCLUDE 'strings.x68'
    

STOP:
    END    MAIN








































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
