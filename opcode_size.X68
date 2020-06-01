*-----------------------------------------------------------
* Subroutine Title: movea_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
movea_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_MOVES,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_MOVES,D1
        BNE         MA_W
        LEA         opcode_MOVEAB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         MA_END
        
        *test for word size
MA_W    CMP.W       #m_size_W_MOVES,D1
        BNE         MA_L
        LEA         opcode_MOVEAW,A1
        MOVE.B      #word_size,D6
        BRA         MA_END
        
        *test for long size
MA_L    CMP.W       #m_size_L_MOVES,D1
        BNE         MA_FAIL
        LEA         opcode_MOVEAL,A1
        MOVE.B      #long_size,D6
        BRA         MA_END
        
        *did not match, its data
MA_FAIL JSR         op_DATA
        
MA_END  MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS

*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
move_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_MOVES,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_MOVES,D1
        BNE         M_W
        LEA         opcode_MOVEB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         M_END
        
        *test for word size
M_W     CMP.W       #m_size_W_MOVES,D1
        BNE         M_L
        LEA         opcode_MOVEW,A1
        MOVE.B      #word_size,D6
        BRA         M_END
        
        *test for long size
M_L     CMP.W       #m_size_L_MOVES,D1
        BNE         M_FAIL
        LEA         opcode_MOVEL,A1
        MOVE.B      #long_size,D6
        BRA         M_END
        
M_FAIL  JSR         op_DATA
        
M_END   MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
nop_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_NOP,A1
        MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
rts_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_RTS,A1
        MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
lea_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_LEA,A1
        MOVE.B      #long_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
jsr_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_JSR,A1
        MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
not_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_NOT,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_NOT,D1
        BNE         NOT_W
        LEA         opcode_NOTB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         NOT_END
        
        *test for word size
NOT_W   CMP.W       #m_size_W_NOT,D1
        BNE         NOT_L
        LEA         opcode_NOTW,A1
        MOVE.B      #word_size,D6
        BRA         NOT_END
        
        *test for long size
NOT_L   CMP.W       #m_size_L_NOT,D1
        BNE         NOT_FAIL
        LEA         opcode_NOTL,A1
        MOVE.B      #long_size,D6
        BRA         NOT_END
        
        *does not match any
NOT_FAIL JSR         op_DATA
        
NOT_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS


*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
adda_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_ADDA,D1 *mask to only see the size bits
        
        *test for word size
        CMP.W       #m_size_W_ADDA,D1
        BNE         ADDA_L
        LEA         opcode_ADDAW,A1    *move the value for printing
        MOVE.B      #word_size,D6
        BRA         ADDA_END
        
        *test for long size
ADDA_L  CMP.W       #m_size_L_ADDA,D1
        BNE         ADDA_FAIL
        LEA         opcode_ADDAL,A1
        MOVE.B      #long_size,D6
        BRA         ADDA_END
        
ADDA_FAIL JSR         op_DATA

ADDA_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
add_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_ADD,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_ADD,D1
        BNE         ADD_W
        LEA         opcode_ADDB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         ADD_END
        
        *test for word size
ADD_W   CMP.W       #m_size_W_ADD,D1
        BNE         ADD_L
        LEA         opcode_ADDW,A1
        MOVE.B      #word_size,D6
        BRA         ADD_END
        
        *test for long size
ADD_L   CMP.W       #m_size_L_ADD,D1
        BNE         ADD_FAIL
        LEA         opcode_ADDL,A1
        MOVE.B      #long_size,D6
        BRA         ADD_END
        
ADD_FAIL JSR         op_DATA
        
ADD_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS

*-----------------------------------------------------------
* Subroutine Title: bcc_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
bcc_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *refresh the entire opcode into D1
        AND.W       #mask_BCC_SIZE,D1  *look at only the last 2 bits
        
        *test for long displacement size
BCC_L   CMP.W       #m_size_L_bcc,D1
        BNE         BCC_W
        *grab the next 32 bits
        
        BRA         BCC_END
        
        *test for word displacement size
BCC_W   CMP.W       #m_size_W_bcc,D1
        BNE         BCC_B
        *grab the next 16 bits
        
        BRA         BCC_END
        
        
        *neither so it is byte size, print 2bits?
BCC_B   
        BRA         BCC_END
        
BCC_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS


*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
bgt_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_BGT,A1
        JSR         bcc_size
        *MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
beq_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_BEQ,A1
        JSR         bcc_size
        *MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
ble_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_BLE,A1
        JSR         bcc_size
        *MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS

        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
bra_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        LEA         opcode_BRA,A1
        JSR         bcc_size
        *MOVE.B      #no_size,D6
        MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
                
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
lsl_r_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_shifts,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_shfts,D1
        BNE         LSLR_W
        LEA         opcode_LSLB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         LSLR_END
        
        *test for word size
LSLR_W  CMP.W       #m_size_W_shfts,D1
        BNE         LSLR_L
        LEA         opcode_LSLW,A1
        MOVE.B      #word_size,D6
        BRA         LSLR_END
        
        *test for long size
LSLR_L  CMP.W       #m_size_L_shfts,D1
        BNE         LSLR_FAIL
        LEA         opcode_LSLL,A1
        MOVE.B      #long_size,D6
        BRA         LSLR_END
        
        *did not match any
LSLR_FAIL JSR         op_DATA
        
LSLR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS


*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
lsr_r_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_shifts,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_shfts,D1
        BNE         LSRR_W
        LEA         opcode_LSRB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         LSRR_END
        
        *test for word size
LSRR_W  CMP.W       #m_size_W_shfts,D1
        BNE         LSRR_L
        LEA         opcode_LSRW,A1
        MOVE.B      #word_size,D6
        BRA         LSRR_END
        
        *test for long size
LSRR_L  CMP.W       #m_size_L_shfts,D1
        BNE         LSRR_FAIL
        LEA         opcode_LSRL,A1
        MOVE.B      #long_size,D6
        BRA         LSRR_END
        
LSRR_FAIL JSR         op_DATA
        
LSRR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        

*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
asl_r_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_shifts,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_shfts,D1
        BNE         ASLR_W
        LEA         opcode_ASLB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         ASLR_END
        
        *test for word size
ASLR_W  CMP.W       #m_size_W_shfts,D1
        BNE         ASLR_L
        LEA         opcode_ASLW,A1
        MOVE.B      #word_size,D6
        BRA         ASLR_END
        
        *test for long size
ASLR_L  CMP.W       #m_size_L_shfts,D1
        BNE         ASLR_FAIL
        LEA         opcode_ASLL,A1
        MOVE.B      #long_size,D6
        BRA         ASLR_END
       
ASLR_FAIL JSR         op_DATA
        
ASLR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        

*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
asr_r_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_shifts,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_shfts,D1
        BNE         ASRR_W
        LEA         opcode_ASRB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         ASRR_END
        
        *test for word size
ASRR_W  CMP.W       #m_size_W_shfts,D1
        BNE         ASRR_L
        LEA         opcode_ASRW,A1
        MOVE.B      #word_size,D6
        BRA         ASRR_END
        
        *test for long size
ASRR_L  CMP.W       #m_size_L_shfts,D1
        BNE         ASRR_FAIL
        LEA         opcode_ASRL,A1
        MOVE.B      #long_size,D6
        BRA         ASRR_END
        
ASRR_FAIL JSR         op_DATA
        
ASRR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS


*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
rol_r_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_shifts,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_shfts,D1
        BNE         ROLR_W
        LEA         opcode_ROLB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         ROLR_END
        
        *test for word size
ROLR_W  CMP.W       #m_size_W_shfts,D1
        BNE         ROLR_L
        LEA         opcode_ROLW,A1
        MOVE.B      #word_size,D6
        BRA         ROLR_END
        
        *test for long size
ROLR_L  CMP.W       #m_size_L_shfts,D1
        BNE         ROLR_FAIL
        LEA         opcode_ROLL,A1
        MOVE.B      #long_size,D6
        BRA         ROLR_END
        
ROLR_FAIL JSR         op_DATA
        
ROLR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS


*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
ror_r_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_shifts,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_shfts,D1
        BNE         RORR_W
        LEA         opcode_RORB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         RORR_END
        
        *test for word size
RORR_W  CMP.W       #m_size_W_shfts,D1
        BNE         RORR_L
        LEA         opcode_RORW,A1
        MOVE.B      #word_size,D6
        BRA         RORR_END
        
        *test for long size
RORR_L  CMP.W       #m_size_L_shfts,D1
        BNE         RORR_FAIL
        LEA         opcode_RORL,A1
        MOVE.B      #long_size,D6
        BRA         RORR_END
        
RORR_FAIL JSR         op_DATA
        
RORR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS

*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
addq_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_ADD,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_ADD,D1
        BNE         ADDQ_W
        LEA         opcode_ADDQB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         ADDQ_END
        
        *test for word size
ADDQ_W  CMP.W       #m_size_W_ADD,D1
        BNE         ADDQ_L
        LEA         opcode_ADDQW,A1
        MOVE.B      #word_size,D6
        BRA         ADDQ_END
        
        *test for long size
ADDQ_L  CMP.W       #m_size_L_ADD,D1
        BNE         ADDQ_FAIL
        LEA         opcode_ADDQL,A1
        MOVE.B      #long_size,D6
        BRA         ADDQ_END
        
ADDQ_FAIL JSR         op_DATA
        
ADDQ_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS


*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
sub_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_SUB,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_SUB,D1
        BNE         SUB_W
        LEA         opcode_SUBB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         SUB_END
        
        *test for word size
SUB_W   CMP.W       #m_size_W_SUB,D1
        BNE         SUB_L
        LEA         opcode_SUBW,A1
        MOVE.B      #word_size,D6
        BRA         SUB_END
        
        *test for long size
SUB_L   CMP.W       #m_size_L_SUB,D1
        BNE         SUB_FAIL
        LEA         opcode_SUBL,A1
        MOVE.B      #long_size,D6
        BRA         SUB_END
        
SUB_FAIL JSR         op_DATA
        
SUB_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS

*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
and_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_logic,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_logic,D1
        BNE         AND_W
        LEA         opcode_ANDB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         AND_END
        
        *test for word size
AND_W   CMP.W       #m_size_W_logic,D1
        BNE         AND_L
        LEA         opcode_ANDW,A1
        MOVE.B      #word_size,D6
        BRA         AND_END
        
        *test for long size
AND_L   CMP.W       #m_size_L_logic,D1
        BNE         AND_FAIL
        LEA         opcode_ANDL,A1
        MOVE.B      #long_size,D6
        BRA         AND_END
        
AND_FAIL JSR         op_DATA
        
AND_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_size
* Description: 
* 
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
or_size:
        MOVEM.L     D0-D5/D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode into D1
        AND.W       #mask_size_logic,D1 *mask to only see the size bits
        
        *test for byte size
        CMP.W       #m_size_B_logic,D1
        BNE         OR_W
        LEA         opcode_ORB,A1    *move the value for printing
        MOVE.B      #byte_size,D6
        BRA         OR_END
        
        *test for word size
OR_W    CMP.W       #m_size_W_logic,D1
        BNE         OR_L
        LEA         opcode_ORW,A1
        MOVE.B      #word_size,D6
        BRA         OR_END
        
        *test for long size
OR_L    CMP.W       #m_size_L_logic,D1
        BNE         OR_FAIL
        LEA         opcode_ORL,A1
        MOVE.B      #long_size,D6
        BRA         OR_END
        
OR_FAIL JSR         op_DATA
        
OR_END MOVEM.L     (SP)+, D0-D5/D7/A0-A6
        RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~