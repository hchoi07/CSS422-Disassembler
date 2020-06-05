*Masks
mask_opcode     EQU     $F000
mask_MOVE       EQU     $C000
mask_MOVE_A     EQU     $01C0
mask_LEA        EQU     $F1C0
mask_JSR        EQU     $FFC0
mask_NOT        EQU     $FF00
mask_ADDA       EQU     $F0C0
mask_BCC        EQU     $FF00
mask_SHFT_M     EQU     $FFC0
mask_SHFT_R     EQU     $F118
mask_BCC_size   EQU     $00FF
mask_MOVEM      EQU     $FF80
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
match_BLE        EQU     $6F00
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
match_MOVEM_RM   EQU     $4880
match_MOVEM_MR   EQU     $4C80
*Opcode Size Mask
mask_size_MOVES     EQU     $3000
mask_size_NOT       EQU     $00C0
mask_size_ADDA      EQU     $0100
mask_size_ADD       EQU     $00C0
mask_size_shifts    EQU     $00C0
mask_size_SUB       EQU     $00C0
mask_size_logic     EQU     $00C0
mask_size_MOVEM     EQU     $0040
mask_size_MOVEQ     EQU     $F100
*Opcode Size Match
m_size_B_MOVES      EQU     $1000
m_size_W_MOVES      EQU     $3000
m_size_L_MOVES      EQU     $2000
m_size_B_NOT        EQU     $0000
m_size_W_NOT        EQU     $0040
m_size_L_NOT        EQU     $0080
m_size_W_ADDA       EQU     $0000
m_size_L_ADDA       EQU     $0100
m_size_B_ADD        EQU     $0000
m_size_W_ADD        EQU     $0040
m_size_L_ADD        EQU     $0080
m_size_B_shfts      EQU     $0000
m_size_W_shfts      EQU     $0070
m_size_L_shfts      EQU     $0080
m_size_B_SUB        EQU     $0000
m_size_W_SUB        EQU     $0040
m_size_L_SUB        EQU     $0080
m_size_B_logic      EQU     $0000
m_size_W_logic      EQU     $0040
m_size_L_logic      EQU     $0080
m_size_L_bcc        EQU     $00FF
m_size_W_bcc        EQU     $0000
m_size_W_MOVEM      EQU     $0000
m_size_L_MOVEM      EQU     $0040
m_size_L_MOVEQ      EQU     $7000
*Size value
byte_size           EQU     1
word_size           EQU     2
long_size           EQU     3
no_size             EQU     0
*IO flag
not_hex             EQU     $FFFFFFFF
hex_clear           EQU     $00000000
*IO range
start_Adr           EQU     $00007000
end_Adr             EQU     $000073BA






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
