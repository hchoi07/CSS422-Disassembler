*-----------------------------------------------------------
* Title      : Main File
*-----------------------------------------------------------
    ORG $1000
MAIN:
    MOVEA.L #$00100000,SP
    
    JSR     io_subroutine
    JSR     main_loop

    SIMHALT             ; halt simulator   
        
    INCLUDE 'toHex.x68'
    INCLUDE 'io_subroutine.x68'
    INCLUDE 'main_loop.x68'
    INCLUDE 'output.x68'
    INCLUDE 'opcode_size.X68'
    INCLUDE 'opcode_subroutine.x68'
    INCLUDE 'testFile.x68'
    INCLUDE 'variables.X68'
    INCLUDE 'strings.x68'
    

STOP:
    END    MAIN
































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
