*-----------------------------------------------------------
* Title      : Main File
*-----------------------------------------------------------
    ORG $1000
MAIN:
    INCLUDE 'variables.X68'
    INCLUDE 'strings.x68'
    INCLUDE 'opcode_size.X68'
    INCLUDE 'opcode_subroutine.x68'
    *INCLUDE 'ea_subroutine.x68'
    *INCLUDE 'io_subroutine.x68'

    MOVEA.L #$00100000,SP
    ; do some initial setup work
    ; call functions defined in subroutines
    JSR     opcode_subroutine
    ; you can define more subroutines
    
    
    
    SIMHALT             ; halt simulator

STOP:
    END    MAIN



























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
