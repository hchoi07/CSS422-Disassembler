*Masks
mask_opcode     EQU     $F000
mask_MOVE_A     EQU     $01C0
mask_LEA        EQU     $F1C0
mask_JSR        EQU     $FFC0
mask_NOT        EQU     $FF00
mask_ADDA       EQU     $F0C0
mask_BCC        EQU     $FF00
mask_SHFT_M     EQU     $FFC0
mask_SHFT_R     EQU     $F118
*Opcode Matches
match_MOVE       EQU     $0000
match_MOVEB      EQU     $1000
match_MOVEW      EQU     $3000
match_MOVEL      EQU     $2000
match_MOVEA      EQU     $0040
match_MOVEQ      EQU     $7000
match_G0100      EQU     $4000
match_NOP        EQU     $4E71
match_RTS        EQU     $4E75
match_LEA        EQU     $41C0
match_JSR        EQU     $4E80
match_NOT        EQU     $4600
match_G1101      EQU     $D000
match_ADDA       EQU     $D0C0
match_G0110      EQU     $6000
match_BGT        EQU     $6E00
match_BEQ        EQU     $6700
match_BRA        EQU     $6000
match_G1110      EQU     $E000
match_LSL_M      EQU     $E3C0
match_LSR_M      EQU     $E2C0
match_ASL_M      EQU     $E1C0
match_ASR_M      EQU     $E0C0
match_ROL_M      EQU     $E7C0
match_ROR_M      EQU     $E6C0
match_LSL_R      EQU     $E108
match_LSR_R      EQU     $E008
match_ASL_R      EQU     $E100
match_ASR_R      EQU     $E000
match_ROL_R      EQU     $E118
match_ROR_R      EQU     $E018
match_ADDQ       EQU     $5000
match_SUB        EQU     $9000
match_AND        EQU     $C000
match_OR         EQU     $8000


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
