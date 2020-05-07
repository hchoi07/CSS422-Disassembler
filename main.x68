*-----------------------------------------------------------
* Title      : Main File
*-----------------------------------------------------------
    ORG $1000
MAIN:
    MOVEA.L #$00100000,SP
    ; do some initial setup work
    ; call functions defined in subroutines
    BSR     opcode_subroutine
    ; you can define more subroutines
    INCLUDE 'opcode_subroutine.x68'
    *INCLUDE 'ea_subroutine.x68'
    *INCLUDE 'io_subroutine.x68'
    INCLUDE 'variables.x68'
    INCLUDE 'strings.x68'
    SIMHALT             ; halt simulator

STOP:
    END    MAIN
























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
