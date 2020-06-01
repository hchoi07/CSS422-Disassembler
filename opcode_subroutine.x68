*-----------------------------------------------------------
* Subroutine Title: opcode_subroutine
* Description: This subroutine masks the machine code to only
* show the opcode. The mask used is $F000, this ensures that
* only the first 4 bits are being looked at to match the opcode.
* This subroutine then calls other subroutines to handle specific
* opcodes or in many cases, decipher which opcode is used in the
* group of opcodes.
* D0 is copied into D1 where the masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
opcode_subroutine:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0,D1
        *MOVE.W      #mask_opcode,D2      *move the mask into D2
        AND.W       #mask_MOVE,D1               *mask to only see the first 2 bits
        
        *test the move operations (00SS)
        CMP.W       #match_MOVE,D1
        BNE         skip1
        JSR         move_decode
        BRA         end_op
        
        *test the 0100 clump and jump to subroutine (nop,lea,not,jsr,rts)
skip1   MOVE.W      D0,D1
        AND.W       #mask_opcode,D1               *mask the full machine code by the opcode mask
        CMP.W       #match_G0100,D1
        BNE         skip2       
        JSR         group1_decode   *opcode matches group starting with 0100
        BRA         end_op

        *test the 1101 clump and jump to subroutine (add,adda)
skip2   CMP.W       #match_G1101,D1
        BNE         skip3
        JSR         group2_decode
        BRA         end_op
        
        *test the 0110 clump and jump to subroutine (bra,bgt,beq)
skip3   CMP.W       #match_G0110,D1
        BNE         skip4
        JSR         group3_decode
        BRA         end_op
        
        *test the 1110 clump and jump to subroutine (lsl/lsr,asl/asr,rol/ror)
skip4   CMP.W       #match_G1110,D1
        BNE         skip5
        JSR         group4_decode
        BRA         end_op

        *test addq
skip5   CMP.W       #match_ADDQ,D1
        BNE         skip6
        JSR         op_ADDQ
        BRA         end_op
        
        *test sub
skip6   CMP.W       #match_SUB,D1
        BNE         skip7
        JSR         op_SUB
        BRA         end_op
        
        *test and
skip7   CMP.W       #match_AND,D1
        BNE         skip8
        JSR         op_AND
        BRA         end_op
        
        *test or
skip8   CMP.W       #match_OR,D1
        BNE         data
        JSR         op_OR
        BRA         end_op
        
data    JSR         op_DATA
        
end_op  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: move_decode
* Description: This subroutine deciphers whether move or movea
* is used by examining if the destination address equals 001.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
move_decode:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0,D1       *refresh the entire opcode into D1
        AND.W       #mask_MOVE_A,D1  *get only the differentiating bits of move/movea
        
        CMP.W       #match_MOVEA,D1
        BEQ         op_MOVEA
        
        BRA         op_MOVE
        
end_MV  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
op_MOVEA:
        JSR         movea_size  *find the size of the operation
        BRA         end_MV

op_MOVE:
        JSR         move_size
        BRA         end_MV

*-----------------------------------------------------------
* Subroutine Title: group1_decode
* Description: This subroutine deciphers which opcode is used
* that starts with 0100. The options here are MOVEM, NOP, LEA
* NOT, JSR, RTS.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
group1_decode:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0,D1           *put the full opcode back into D1
        
        CMP.W       #match_NOP,D1   *test the full opcode against NOP
        BEQ         op_NOP
        
        CMP.W       #match_RTS,D1   *test the full opcode against RTS
        BEQ         op_RTS
        
        AND.W       #mask_LEA,D1    *test the masked opcode against LEA
        CMP.W       #match_LEA,D1   *look for 0100 xxx1 11xx
        BEQ         op_LEA
        
        MOVE.W      D0,D1           *refresh D1 back into the full opcode
        AND.W       #mask_JSR,D1    *test the masked opcode against JSR
        CMP.W       #match_JSR,D1   *look for 0100 1110 10xx
        BEQ         op_JSR
        
        MOVE.W      D0,D1           *refresh D1 back into the full opcode
        AND.W       #mask_NOT,D1    *test the masked opcode against NOT
        CMP.W       #match_NOT,D1   *look for 0100 0110
        BEQ         op_NOT
        
end_G1  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
op_NOP:
        JSR         nop_size
        BRA         end_G1

op_RTS:
        JSR         rts_size
        BRA         end_G1

op_LEA:
        JSR         lea_size
        BRA         end_G1
        
op_JSR:
        JSR         jsr_size
        BRA         end_G1

op_NOT:
        JSR         not_size
        BRA         end_G1

*-----------------------------------------------------------
* Subroutine Title: group2_decode
* Description: This subroutine deciphers which opcode is used
* that starts with 1101. The options here are ADD, ADDA.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
group2_decode:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0,D1       *refresh the entire opcode into D1
        
        AND.W       #mask_ADDA,D1   *test the masked opcode against the 
        CMP.W       #match_ADDA,D1  *difference between add/adda
        BEQ         op_ADDA         
        
        BRA         op_ADD          *if its not adda, it is add
        
end_G2  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS

op_ADDA:
        JSR         adda_size
        BRA         end_G2

op_ADD:
        JSR         add_size
        BRA         end_G2

*-----------------------------------------------------------
* Subroutine Title: group3_decode
* Description: This subroutine deciphers which opcode is used
* that starts with 0110. The options here are BRA, BGT, BEQ.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
group3_decode:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0,D1       *refresh the entire opcode into D1
        AND.W       #mask_BCC,D1
        
        CMP.W       #match_BGT,D1   *test the first 8 bits against the BGT cond
        BEQ         op_BGT
        
        CMP.W       #match_BEQ,D1   *test the first 8 bits against the BEQ cond
        BEQ         op_BEQ
        
        CMP.W       #match_BLE,D1
        BEQ         op_BLE
        
        CMP.W       #match_BRA,D1   *test the first 8 bits against the BRA cond
        BEQ         op_BRA
        
        
        
end_G3  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
op_BGT:
        JSR         bgt_size
        BRA         end_G3

op_BEQ:
        JSR         beq_size
        BRA         end_G3
        
op_BLE:
        JSR         ble_size
        BRA         end_G3

op_BRA:
        JSR         bra_size
        BRA         end_G3

*-----------------------------------------------------------
* Subroutine Title: group4_decode
* Description: This subroutine deciphers which opcode is used
* that starts with 1110. The options here are LSL/LSR,ASL/ASR,
* ROL/ROR.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
group4_decode:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        MOVE.W      D0,D1       *refresh the entire opcode into D1
        AND.W       #mask_SHFT_M,D1   *look at the first 10 bits for memory shift
        
        *test memory shift left
        CMP.W       #match_LSL_M,D1  
        BEQ         op_LSL_M      
        
        *test memory shift right
        CMP.W       #match_LSR_M,D1  
        BEQ         op_LSR_M    
        
        *test memory shift left
        CMP.W       #match_ASL_M,D1  
        BEQ         op_ASL_M      
        
        *test memory shift right
        CMP.W       #match_ASR_M,D1  
        BEQ         op_ASR_M  
        
        *test memory rotate left
        CMP.W       #match_ROL_M,D1  
        BEQ         op_ROL_M      

        *test memory rotate right
        CMP.W       #match_ROR_M,D1  
        BEQ         op_ROR_M  
        
        *look at select bits for the register shifts
        MOVE.W      D0,D1       *refresh the entire opcode into D1
        AND.W       #mask_SHFT_R,D1
        
        CMP.W       #match_LSL_R,D1
        BEQ         op_LSL_R
        
        CMP.W       #match_LSR_R,D1
        BEQ         op_LSR_R
        
        CMP.W       #match_ASL_R,D1
        BEQ         op_ASL_R
        
        CMP.W       #match_ASR_R,D1
        BEQ         op_ASR_R
        
        CMP.W       #match_ROL_R,D1
        BEQ         op_ROL_R
        
        CMP.W       #match_ROR_R,D1
        BEQ         op_ROR_R
        
end_G4  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
op_LSL_M:

op_LSR_M:

op_ASL_M:

op_ASR_M:

op_ROL_M:

op_ROR_M:

op_LSL_R:
        JSR     lsl_r_size
        BRA     end_G4

op_LSR_R:
        JSR     lsr_r_size
        BRA     end_G4

op_ASL_R:
        JSR     asl_r_size
        BRA     end_G4

op_ASR_R:
        JSR     asr_r_size
        BRA     end_G4

op_ROL_R:
        JSR     rol_r_size
        BRA     end_G4

op_ROR_R:
        JSR     ror_r_size
        BRA     end_G4

*-----------------------------------------------------------
* Subroutine Title: op_ADDQ
* Description: This subroutine determines the length used
* in the ADDQ operation.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
op_ADDQ:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        *MOVE.W      D0,D1       *refresh the entire opcode into D1
        JSR     addq_size
        
end_AQ  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS

        
*-----------------------------------------------------------
* Subroutine Title: op_SUB
* Description: This subroutine determines the length used
* in the SUB operation.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
op_SUB:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        *MOVE.W      D0,D1       *refresh the entire opcode into D1
        JSR         sub_size
        
end_SB  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
      

*-----------------------------------------------------------
* Subroutine Title: op_AND
* Description: This subroutine determines the length used in
* the AND operation.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
op_AND:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        *MOVE.W      D0,D1       *refresh the entire opcode into D1
        JSR         and_size
        
end_AN  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: op_OR
* Description: This subroutine determines the length used in
* the OR operation.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
op_OR:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        *MOVE.W      D0,D1       *refresh the entire opcode into D1
        JSR         or_size
        
end_OR  MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS
        
*-----------------------------------------------------------
* Subroutine Title: op_DATA
* Description: This subroutine determines the length used in
* the OR operation.
* D0 is copied into D1 where specific masking occurs.
* D0 is used to pass in the machine code word.
*-----------------------------------------------------------
op_DATA:
        MOVEM.L     D0-D7/A0-A6, -(SP)
        LEA         opcode_DATA,A1  *move data string into 
        MOVE.W      D0,D1           *move the full data into D1 for printing
        JSR         print_string
        JSR         print_hex
        
end_DATA MOVEM.L     (SP)+, D0-D7/A0-A6
        RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
