*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------

MOVEM_sub                                MOVEM.L           D1-D5/D7/A2-A6, -(SP)                           ;preserve the registers, 
                                         AND.L             #mask_MOVEM_dir,D1                          ;load the mask to determine the direction
                                         
                                         CMP.L             #match_MOVEM_reg_mem,D1                     ;check to see if it's reg to mem
                                         BEQ               MOVEM_reg_mem                               ;if equal go figure out list
                                         BNE               MOVEM_mem_reg_match                         ;if not go check mem to reg
                                         
                                         
MOVEM_mem_reg_match                     CMP.L              #match_MOVEM_mem_reg,D1                     ;check if mem to reg 
                                        BEQ                MOVEM_determine_second_op                   ;if equal go figure out the register
                                        BNE                MOVEM_ERROR                                       ;if not equal go to error message
*-----------------------------------------------------------------------------------------------------------------------------------
* 
*                                       Determine Register List, then Memory                            
*
*-----------------------------------------------------------------------------------------------------------------------------------
MOVEM_reg_mem                            MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D0,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D0,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D0_reg_list_out
                                         BNE            MOVEM_reg_mem_D1

MOVEM_reg_mem_D1                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D1,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D1,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D1_reg_list_out
                                         BNE            MOVEM_reg_mem_D2

MOVEM_reg_mem_D2                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D2,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D2,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D2_reg_list_out
                                         BNE            MOVEM_reg_mem_D3

MOVEM_reg_mem_D3                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D3,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D3,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D3_reg_list_out
                                         BNE            MOVEM_reg_mem_D4

MOVEM_reg_mem_D4                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D4,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D4,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D4_reg_list_out
                                         BNE            MOVEM_reg_mem_D5

MOVEM_reg_mem_D5                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D5,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D5,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D5_reg_list_out
                                         BNE            MOVEM_reg_mem_D6

MOVEM_reg_mem_D6                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D6,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D6,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D6_reg_list_out
                                         BNE            MOVEM_reg_mem_D7

MOVEM_reg_mem_D7                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D7,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D7,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_D7_reg_list_out
                                         BNE            MOVEM_reg_mem_A0


MOVEM_reg_mem_A0                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A0,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A0,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A0_reg_list_out
                                         BNE            MOVEM_reg_mem_A1

MOVEM_reg_mem_A1                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A1,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A1,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A1_reg_list_out
                                         BNE            MOVEM_reg_mem_A2

MOVEM_reg_mem_A2                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A2,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A2,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A2_reg_list_out
                                         BNE            MOVEM_reg_mem_A3

MOVEM_reg_mem_A3                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A3,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A3,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A3_reg_list_out
                                         BNE            MOVEM_reg_mem_A4

MOVEM_reg_mem_A4                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A4,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A4,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A4_reg_list_out
                                         BNE            MOVEM_reg_mem_A5

MOVEM_reg_mem_A5                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A5,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A5,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A5_reg_list_out
                                         BNE            MOVEM_reg_mem_A6

MOVEM_reg_mem_A6                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A6,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A6,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A6_reg_list_out
                                         BNE            MOVEM_reg_mem_A7

MOVEM_reg_mem_A7                         MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A7,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A7,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_A7_reg_list_out
                                         BNE            MOVEM_determine_second_operand

;------------------------------------------------------Register List Output----------------------------------------
MOVEM_D0_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D1            ;go check D1
                                        
MOVEM_D1_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D2            ;go check D2

MOVEM_D2_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D3            ;go check D3

MOVEM_D3_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D4            ;go check D4

MOVEM_D4_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D5            ;go check D5

MOVEM_D5_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D6            ;go check D6

MOVEM_D6_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D7            ;go check D7

MOVEM_D7_reg_list_out                   MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A0            ;go check A0

MOVEM_A0_reg_list_out                   MOVE.L          #ea_A0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A1            ;go check D1
                                        
MOVEM_A1_reg_list_out                   MOVE.L          #ea_A1,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A2            ;go check D2

MOVEM_A2_reg_list_out                   MOVE.L          #ea_A2,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A3            ;go check D3

MOVEM_A3_reg_list_out                   MOVE.L          #ea_A3,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A4            ;go check D4

MOVEM_A4_reg_list_out                   MOVE.L          #ea_A4,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A5            ;go check D5

MOVEM_A5_reg_list_out                   MOVE.L          #ea_A5,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A6            ;go check D6

MOVEM_A6_reg_list_out                   MOVE.L          #ea_A6,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A7            ;go check D7

MOVEM_A7_reg_list_out                   MOVE.L          #ea_A7,(A1)+                ;load the register into A1
                                        JSR             MOVEM_determine_second_op   ;go figure out the second operand


MOVEM_determine_second_operand          CLR             D1
                                        AND.L           #mask_MOVEM_ea_mode,D1                          ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
MOVEM_add_reg_indir              CMP.L             #match_MOVEM_An_indir,D1                        ;check to see if mode is add reg indir
                                 BNE               MOVEM_add_reg_indir_predec                    ;if not, go check add reg indir predec 
                                 BEQ               MOVEM_An_indir_reg                            ;if equal go figure out the register           
           
MOVEM_add_reg_indir_predec       CMP.L             #match_MOVEM_An_indir_pdec,D1                  ;check to see if mode is add reg indor w/ postinc
                                 BNE               MOVEM_abs_add_word                          ;if not go check add reg indir/predec
                                 BEQ               MOVEM_An_indir_predec                          ;if equal go figure out the register
                      

MOVEM_abs_add_word               AND.L             #mask_MOVEM_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_MOVEM_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               MOVEM_abs_add_long                                  ;if not go check abs add long
                                 BEQ               MOVEM_abs_add_word_out                              ;if equal go to output
  
MOVEM_abs_add_long               CMP.L             #match_MOVEM_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               MOVEM_abs_add_long_out                              ;if equal go to output
                                 BNE               MOVEM_ERROR                                         ;if not equal go to error mesage MOVE routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 AND.L           #mask_MOVEM_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
;------------------Address Register Indirect-----------------------
MOVEM_An_indir_reg                CMP.L          #match_MOVEM_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             MOVEM_An_indir_r1                           ;if not try reg 1
                                 BEQ             MOVEM_An_indir_r0_out                       ;if equal go to output MOVEroutine

MOVEM_An_indir_r1                 CMP.L           #match_MOVEM_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             MOVEM_An_indir_r2                           ;if not try reg 2
                                 BEQ             MOVEM_An_indir_r1_out                       ;if equal go to output MOVEroutine

MOVEM_An_indir_r2                 CMP.L           #match_MOVEM_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             MOVEM_An_indir_r3                           ;if not try reg 3
                                 BEQ             MOVEM_An_indir_r2_out                       ;if equal go to output MOVEroutine

MOVEM_An_indir_r3                 CMP.L           #match_MOVEM_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             MOVEM_An_indir_r4                           ;if not try reg 4
                                 BEQ             MOVEM_An_indir_r3_out                       ;if equal go to output MOVEroutine
    
MOVEM_An_indir_r4                 CMP.L           #match_MOVEM_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             MOVEM_An_indir_r5                           ;if not try reg 5
                                 BEQ             MOVEM_An_indir_r4_out                       ;if equal go to output MOVEroutine
        
MOVEM_An_indir_r5                 CMP.L           #match_MOVEM_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             MOVEM_An_indir_r6                           ;if not try reg 6
                                 BEQ             MOVEM_An_indir_r5_out                       ;if equal go to output MOVEroutine

MOVEM_An_indir_r6                 CMP.L           #match_MOVEM_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             MOVEM_An_indir_r7                           ;if not try reg 7
                                 BEQ             MOVEM_An_indir_r6_out                       ;if equal go to output MOVEroutine

MOVEM_An_indir_r7                 CMP.L           #match_MOVEM_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             MOVEM_An_indir_r7_out                       ;if equal go to output MOVEroutine
                                 BNE             MOVEM_ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
MOVEM_An_indir_r0_out			       MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_r1_out			       MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_r2_out			       MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_r3_out			       MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_r4_out			       MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_r5_out			       MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_r6_out			       MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand
								        
MOVEM_An_indir_r7_out			       MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                        JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

;------------------Address Register Indirect with Pre Decrement-----------------------
MOVEM_An_indir_predec                   	CMP.L      #match_MOVEM_An_indir_pdec_r0,D2       ;check reg is equal to 0
                                            BNE        MOVEM_An_indir_pdec_r1                      ;if not try reg 1
                                            BEQ        MOVEM_An_indir_pdec_r0_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r1                      CMP.L      #match_MOVEM_An_indir_pdec_r1,D2       ;check reg is equal to 1
                                            BNE        MOVEM_An_indir_pdec_r2                      ;if not try reg 2
                                            BEQ        MOVEM_An_indir_pdec_r1_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r2                      CMP.L      #match_MOVEM_An_indir_pdec_r2,D2       ;check reg is equal to 2
                                            BNE        MOVEM_An_indir_pdec_r3                      ;if not try reg 3
                                            BEQ        MOVEM_An_indir_pdec_r2_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r3                      CMP.L      #match_MOVEM_An_indir_pdec_r3,D2       ;check reg is equal to 3
                                            BNE        MOVEM_An_indir_pdec_r4                      ;if not try reg 4
                                            BEQ        MOVEM_An_indir_pdec_r3_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r4                      CMP.L      #match_MOVEM_An_indir_pdec_r4,D2       ;check reg is equal to 4
                                            BNE        MOVEM_An_indir_pdec_r5                      ;if not try reg 5
                                            BEQ        MOVEM_An_indir_pdec_r4_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r5                      CMP.L      #match_MOVEM_An_indir_pdec_r5,D2       ;check reg is equal to 5
                                            BNE        MOVEM_An_indir_pdec_r6                     ;if not try reg 6
                                            BEQ        MOVEM_An_indir_pdec_r5_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r6                      CMP.L      #match_MOVEM_An_indir_pdec_r6,D2       ;check reg is equal to 6
                                            BNE        MOVEM_An_indir_pdec_r7                     ;if not try reg 7
                                            BEQ        MOVEM_An_indir_pdec_r6_out               ;if equal go to output MOVEroutine

MOVEM_An_indir_pdec_r7                      CMP.L      #match_MOVEM_An_indir_pdec_r7,D2       ;check reg is equal to 7
                                            BEQ        MOVEM_An_indir_pdec_r7_out               ;if equal go to output MOVEroutine
                                            BNE        MOVEM_ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
MOVEM_An_indir_pdec_r0_out	    		   MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand
											
MOVEM_An_indir_pdec_r1_out		    	   MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_pdec_r2_out			       MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_pdec_r3_out     			   MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_pdec_r4_out	    		   MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_pdec_r5_out		    	   MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_pdec_r6_out			       MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_An_indir_pdec_r7_out			       MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand
        
;------------------Absolute Addressing Output-----------------------
MOVEM_abs_add_word_out				  MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      MOVEM.L           (SP)+, D1-D5/D7/A2-A6                                      
                                      RTS                                            :return to MOVEroutine
                                           

MOVEM_abs_add_long_out    			  MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      MOVEM.L           (SP)+, D1-D5/D7/A2-A6                                      
                                      RTS                                            :return to MOVEroutine
                                            ;return to MOVEroutine                                            

*-----------------------------------------------------------------------------------------------------------------------------------------------
* 
*                                                   Determine Memory register, then register list
* 
*-----------------------------------------------------------------------------------------------------------------------------------------------
MOVEM_determine_second_op         CLR             D1

                                 AND.L             #mask_MOVEM_ea_mode,D1                          ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
MOVEM_m2r_An_indir               CMP.L             #match_MOVEM_An_indir,D1                        ;check to see if mode is add reg indir
                                 BNE               MOVEM_m2r_An_indir_postinc                    ;if not, go check add reg indir predec 
                                 BEQ               MOVEM_m2r_An_indir_reg                            ;if equal go figure out the register           
                                 
MOVEM_m2r_An_indir_postinc       CMP.L             #match_MOVEM_An_indir_pinc,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               MOVEM_m2r_abs_add_word                                  ;if not go check abs add word
                                 BEQ               MOVEM_m2r_An_indir_pinc_reg                          ;if equal go figure out the register

MOVEM_m2r_abs_add_word           AND.L             #mask_MOVEM_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_MOVEM_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               MOVEM_m2r_abs_add_long                                  ;if not go check abs add long
                                 BEQ               MOVEM_m2r_abs_add_word_out                              ;if equal go to output
  
MOVEM_m2r_abs_add_long           CMP.L             #match_MOVEM_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               MOVEM_m2r_abs_add_long_out                              ;if equal go to output
                                 BNE               MOVEM_ERROR                                         ;if not equal go to error mesage MOVE routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 AND.L              #mask_MOVEM_ea_reg_and_mode,D2             ;load the mask into D2 for the mode and the register
;------------------Address Register Indirect-----------------------
MOVEM_m2r_An_indir_reg          CMP.L          #match_MOVEM_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             MOVEM_m2r_An_indir_r1                           ;if not try reg 1
                                 BEQ             MOVEM_m2r_An_indir_r0_out                       ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_r1           CMP.L           #match_MOVEM_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             MOVEM_m2r_An_indir_r2                           ;if not try reg 2
                                 BEQ             MOVEM_m2r_An_indir_r1_out                       ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_r2           CMP.L           #match_MOVEM_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             MOVEM_m2r_An_indir_r3                           ;if not try reg 3
                                 BEQ             MOVEM_m2r_An_indir_r2_out                       ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_r3           CMP.L           #match_MOVEM_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             MOVEM_m2r_An_indir_r4                           ;if not try reg 4
                                 BEQ             MOVEM_m2r_An_indir_r3_out                       ;if equal go to output MOVEroutine
    
MOVEM_m2r_An_indir_r4           CMP.L           #match_MOVEM_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             MOVEM_m2r_An_indir_r5                           ;if not try reg 5
                                 BEQ             MOVEM_m2r_An_indir_r4_out                       ;if equal go to output MOVEroutine
        
MOVEM_m2r_An_indir_r5           CMP.L           #match_MOVEM_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             MOVEM_m2r_An_indir_r6                           ;if not try reg 6
                                 BEQ             MOVEM_m2r_An_indir_r5_out                       ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_r6           CMP.L           #match_MOVEM_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             MOVEM_m2r_An_indir_r7                           ;if not try reg 7
                                 BEQ             MOVEM_m2r_An_indir_r6_out                       ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_r7           CMP.L           #match_MOVEM_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             MOVEM_m2r_An_indir_r7_out                       ;if equal go to output MOVEroutine
                                 BNE             MOVEM_ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
MOVEM_m2r_An_indir_r0_out			       MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_r1_out			       MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_r2_out			       MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_r3_out			       MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_r4_out			       MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_r5_out			       MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_r6_out			       MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand
								        
MOVEM_m2r_An_indir_r7_out			       MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                            JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

;------------------Address Register Indirect with Post Increment-----------------------
MOVEM_m2r_An_indir_pinc_reg                 CMP.L      #match_MOVEM_An_indir_pinc_r0,D2        ;check reg is equal to 0
                                            BNE        MOVEM_m2r_An_indir_pinc_r1                      ;if not try reg 1
                                            BEQ        MOVEM_m2r_An_indir_pinc_r0_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pinc_r1                  CMP.L      #match_MOVEM_An_indir_pinc_r1,D2        ;check reg is equal to 1
                                            BNE        MOVEM_m2r_An_indir_pinc_r2                      ;if not try reg 2
                                            BEQ        MOVEM_m2r_An_indir_pinc_r1_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pinc_r2                  CMP.L      #match_MOVEM_An_indir_pinc_r2,D2        ;check reg is equal to 2
                                            BNE        MOVEM_m2r_An_indir_pinc_r3                      ;if not try reg 3
                                            BEQ        MOVEM_m2r_An_indir_pinc_r2_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pinc_r3                  CMP.L      #match_MOVEM_An_indir_pinc_r3,D2        ;check reg is equal to 3
                                            BNE        MOVEM_m2r_An_indir_pinc_r4                      ;if not try reg 4
                                            BEQ        MOVEM_m2r_An_indir_pinc_r3_out               ;if equal go to output MOVEroutine
 
MOVEM_m2r_An_indir_pinc_r4                  CMP.L      #match_MOVEM_An_indir_pinc_r4,D2        ;check reg is equal to 4
                                            BNE        MOVEM_m2r_An_indir_pinc_r5                      ;if not try reg 5
                                            BEQ        MOVEM_m2r_An_indir_pinc_r4_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pinc_r5                  CMP.L      #match_MOVEM_An_indir_pinc_r5,D2        ;check reg is equal to 5
                                            BNE        MOVEM_m2r_An_indir_pinc_r6                      ;if not try reg 6
                                            BEQ        MOVEM_m2r_An_indir_pinc_r5_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pinc_r6                  CMP.L      #match_MOVEM_An_indir_pinc_r6,D2         ;check reg is equal to 6
                                            BNE        MOVEM_m2r_An_indir_pinc_r7                        ;if not try reg 7
                                            BEQ        MOVEM_m2r_An_indir_pinc_r6_out                    ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pinc_r7                  CMP.L      #match_MOVEM_An_indir_pinc_r7,D2         ;check reg is equal to 7
                                            BEQ        MOVEM_m2r_An_indir_pinc_r7_out                    ;if equal go to output MOVEroutine
                                            BNE        MOVEM_ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
MOVEM_m2r_An_indir_pinc_r0_out  		    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r1_out	    	    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r2_out		   	    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r3_out		        MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r4_out		   	    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r5_out		        MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r6_out		        MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pinc_r7_out		   	    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                             JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

;------------------Address Register Indirect with Pre Decrement-----------------------
MOVE_m2r_An_indir_predec                   	CMP.L      #match_MOVEM_An_indir_pdec_r0,D2       ;check reg is equal to 0
                                            BNE        MOVEM_m2r_An_indir_pdec_r1                      ;if not try reg 1
                                            BEQ        MOVEM_m2r_An_indir_pdec_r0_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r1                  CMP.L      #match_MOVEM_An_indir_pdec_r1,D2       ;check reg is equal to 1
                                            BNE        MOVEM_m2r_An_indir_pdec_r2                      ;if not try reg 2
                                            BEQ        MOVEM_m2r_An_indir_pdec_r1_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r2                  CMP.L      #match_MOVEM_An_indir_pdec_r2,D2       ;check reg is equal to 2
                                            BNE        MOVEM_m2r_An_indir_pdec_r3                      ;if not try reg 3
                                            BEQ        MOVEM_m2r_An_indir_pdec_r2_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r3                  CMP.L      #match_MOVEM_An_indir_pdec_r3,D2       ;check reg is equal to 3
                                            BNE        MOVEM_m2r_An_indir_pdec_r4                      ;if not try reg 4
                                            BEQ        MOVEM_m2r_An_indir_pdec_r3_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r4                  CMP.L      #match_MOVEM_An_indir_pdec_r4,D2       ;check reg is equal to 4
                                            BNE        MOVEM_m2r_An_indir_pdec_r5                      ;if not try reg 5
                                            BEQ        MOVEM_m2r_An_indir_pdec_r4_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r5                  CMP.L      #match_MOVEM_An_indir_pdec_r5,D2       ;check reg is equal to 5
                                            BNE        MOVEM_m2r_An_indir_pdec_r6                     ;if not try reg 6
                                            BEQ        MOVEM_m2r_An_indir_pdec_r5_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r6                  CMP.L      #match_MOVEM_An_indir_pdec_r6,D2       ;check reg is equal to 6
                                            BNE        MOVEM_m2r_An_indir_pdec_r7                     ;if not try reg 7
                                            BEQ        MOVEM_m2r_An_indir_pdec_r6_out               ;if equal go to output MOVEroutine

MOVEM_m2r_An_indir_pdec_r7                  CMP.L      #match_MOVEM_An_indir_pdec_r7,D2       ;check reg is equal to 7
                                            BEQ        MOVEM_m2r_An_indir_pdec_r7_out               ;if equal go to output MOVEroutine
                                            BNE        MOVEM_ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
MOVEM_m2r_An_indir_pdec_r0_out		      	    MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand
											
MOVEM_m2r_An_indir_pdec_r1_out			        MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pdec_r2_out		    	    MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pdec_r3_out		    	    MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pdec_r4_out			        MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pdec_r5_out		    	    MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pdec_r6_out	    		    MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand

MOVEM_m2r_An_indir_pdec_r7_out  			    MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                                JSR             MOVEM_determine_second_op                 ;jump to MOVEroutine to determine second operand
        
;------------------Absolute Addressing Output-----------------------
MOVEM_m2r_abs_add_word_out			  MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      MOVEM.L           (SP)+, D1-D5/D7/A2-A6                                      
                                      RTS                                            :return to MOVEroutine
                                            ;return to MOVEroutine
                                           

MOVEM_m2r_abs_add_long_out            MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      MOVEM.L           (SP)+, D1-D5/D7/A2-A6                                      
                                      RTS                                            :return to MOVEroutine
                                            ;return to MOVEroutine                                            

*----------------------------------------------------Determine Register List----------------------------------------------------------------
MOVEM_second_operand                     CLR            D1   

MOVEM_m2r                                MOVE.L         (A0)+,D5                                ;pull the register list
                                         
                                         MOVE.L         #mask_MOVEM_reg_mem_D0,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D0,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D0_reg_list_out
                                         BNE            MOVEM_m2r_D1

MOVEM_m2r_D1                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D1,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D1,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D1_reg_list_out
                                         BNE            MOVEM_m2r_D2

MOVEM_m2r_D2                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D2,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D2,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D2_reg_list_out
                                         BNE            MOVEM_m2r_D3

MOVEM_m2r_D3                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D3,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D3,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D3_reg_list_out
                                         BNE            MOVEM_m2r_D4

MOVEM_m2r_D4                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D4,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D4,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D4_reg_list_out
                                         BNE            MOVEM_m2r_D5

MOVEM_m2r_D5                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D5,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D5,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D5_reg_list_out
                                         BNE            MOVEM_m2r_D6

MOVEM_m2r_D6                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D6,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D6,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D6_reg_list_out
                                         BNE            MOVEM_m2r_D7

MOVEM_m2r_D7                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_D7,D1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_D7,D1                    ;check to see if the D0 is on the list
                                         BEQ            MOVEM_m2r_D7_reg_list_out
                                         BNE            MOVEM_m2r_A0


MOVEM_m2r_A0                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A0,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A0,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A0_reg_list_out
                                         BNE            MOVEM_m2r_A1

MOVEM_m2r_A1                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A1,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A1,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A1_reg_list_out
                                         BNE            MOVEM_m2r_A2

MOVEM_m2r_A2                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A2,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A2,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A2_reg_list_out
                                         BNE            MOVEM_m2r_A3

MOVEM_m2r_A3                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A3,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A3,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A3_reg_list_out
                                         BNE            MOVEM_m2r_A4

MOVEM_m2r_A4                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A4,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A4,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A4_reg_list_out
                                         BNE            MOVEM_m2r_A5

MOVEM_m2r_A5                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A5,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A5,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A5_reg_list_out
                                         BNE            MOVEM_m2r_A6

MOVEM_m2r_A6                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A6,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A6,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A6_reg_list_out
                                         BNE            MOVEM_m2r_A7

MOVEM_m2r_A7                             MOVE.L         (A0)+,D5                                ;pull the register list
                                         CLR            D1
                                         MOVE.L         #mask_MOVEM_reg_mem_A7,A1                     ;load mask into register
                                         CMP.L          #match_MOVEM_reg_mem_A7,A1                    ;check to see if the A0 is on the list
                                         BEQ            MOVEM_m2r_A7_reg_list_out
                                         BNE            MOVEM_determine_second_operand

;------------------------------------------------------Register List Output----------------------------------------
MOVEM_m2r_D0_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D1            ;go check D1
                                        
MOVEM_m2r_D1_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D2            ;go check D2

MOVEM_m2r_D2_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D3            ;go check D3

MOVEM_m2r_D3_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D4            ;go check D4

MOVEM_m2r_D4_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D5            ;go check D5

MOVEM_m2r_D5_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D6            ;go check D6

MOVEM_m2r_D6_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_D7            ;go check D7

MOVEM_m2r_D7_reg_list_out               MOVE.L          #ea_D0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A0            ;go check A0

MOVEM_m2r_A0_reg_list_out               MOVE.L          #ea_A0,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A1            ;go check D1
                                        
MOVEM_m2r_A1_reg_list_out               MOVE.L          #ea_A1,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A2            ;go check D2

MOVEM_m2r_A2_reg_list_out               MOVE.L          #ea_A2,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A3            ;go check D3

MOVEM_m2r_A3_reg_list_out               MOVE.L          #ea_A3,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A4            ;go check D4

MOVEM_m2r_A4_reg_list_out               MOVE.L          #ea_A4,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A5            ;go check D5

MOVEM_m2r_A5_reg_list_out               MOVE.L          #ea_A5,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A6            ;go check D6

MOVEM_m2r_A6_reg_list_out               MOVE.L          #ea_A6,(A1)+                ;load the register into A1
                                        JSR             MOVEM_reg_mem_A7            ;go check D7

MOVEM_m2r_A7_reg_list_out               MOVE.L          #ea_A7,(A1)+                ;load the register into A1
                                        MOVEM.L           (SP)+, D1-D5/D7/A2-A6                                      
                                      RTS                                            :return to MOVEroutine



;----------------------Error Handling----------------------------------------
MOVEM_ERROR                                     LEA     ERROR_MESSAGE,A1                                          ;load error messge into A3
					                                                        
                                                RTS                                            :return to MOVEroutine

					                            
					                           

mask_MOVEM_dir         EQU         $0400


*----------------------------------------------------------------------------
*
*						Register List Masks
*
*----------------------------------------------------------------------------
mask_MOVEM_reg_mem_D0        EQU         $8000
mask_MOVEM_reg_mem_D1        EQU         $4000
mask_MOVEM_reg_mem_D2        EQU         $2000
mask_MOVEM_reg_mem_D3        EQU         $1000
mask_MOVEM_reg_mem_D4        EQU         $0800
mask_MOVEM_reg_mem_D5        EQU         $0400
mask_MOVEM_reg_mem_D6        EQU         $0200
mask_MOVEM_reg_mem_D7        EQU         $0100

mask_MOVEM_reg_mem_A0        EQU         $0080
mask_MOVEM_reg_mem_A1        EQU         $0040
mask_MOVEM_reg_mem_A2        EQU         $0020
mask_MOVEM_reg_mem_A3        EQU         $0010
mask_MOVEM_reg_mem_A4        EQU         $0008
mask_MOVEM_reg_mem_A5        EQU         $0004
mask_MOVEM_reg_mem_A6        EQU         $0002
mask_MOVEM_reg_mem_A7        EQU         $0001


mask_MOVEM_mem_reg_A7        EQU         $8000
mask_MOVEM_mem_reg_A6        EQU         $4000
mask_MOVEM_mem_reg_A5        EQU         $2000
mask_MOVEM_mem_reg_A4        EQU         $1000
mask_MOVEM_mem_reg_A3        EQU         $0800
mask_MOVEM_mem_reg_A2        EQU         $0400
mask_MOVEM_mem_reg_A1        EQU         $0200
mask_MOVEM_mem_reg_A0        EQU         $0100

mask_MOVEM_mem_reg_D7        EQU         $8000
mask_MOVEM_mem_reg_D6        EQU         $4000
mask_MOVEM_mem_reg_D5        EQU         $2000
mask_MOVEM_mem_reg_D4        EQU         $1000
mask_MOVEM_mem_reg_D3        EQU         $0800
mask_MOVEM_mem_reg_D2        EQU         $0400
mask_MOVEM_mem_reg_D1        EQU         $0200
mask_MOVEM_mem_reg_D0        EQU         $0100


*----------------------------------------------------------------------------
*                       Register to Memory EA Variables
*----------------------------------------------------------------------------
mask_MOVEM_ea_reg_and_mode		EQU			$003F
mask_MOVEM_ea_mode				EQU			$003C
mask_MOVEM_abs_add              EQU         $0038
 
match_MOVEM_reg_mem             EQU         $0400
match_MOVEM_An_indir			EQU			$0010

match_MOVEM_abs_add_word        EQU         $0038
match_MOVEM_abs_add_long        EQU         $0039

match_MOVEM_An_indir_r0		EQU			$0010
match_MOVEM_An_indir_r1		EQU			$0011
match_MOVEM_An_indir_r2		EQU			$0012
match_MOVEM_An_indir_r3		EQU			$0013
match_MOVEM_An_indir_r4		EQU			$0014
match_MOVEM_An_indir_r5		EQU			$0015
match_MOVEM_An_indir_r6		EQU			$0016
match_MOVEM_An_indir_r7		EQU			$0017

match_MOVEM_An_indir_pdec_r0			EQU			$0020
match_MOVEM_An_indir_pdec_r1			EQU			$0021
match_MOVEM_An_indir_pdec_r2			EQU			$0022
match_MOVEM_An_indir_pdec_r3			EQU			$0023
match_MOVEM_An_indir_pdec_r4			EQU			$0024
match_MOVEM_An_indir_pdec_r5			EQU			$0025
match_MOVEM_An_indir_pdec_r6			EQU			$0026
match_MOVEM_An_indir_pdec_r7			EQU			$0027


match_MOVEM_mem_reg             EQU         $0400


match_MOVEM_An_indir_pdec		EQU			$0020
match_MOVEM_An_indir_pinc		EQU			$0010
match_MOVEM_abs_add_word		EQU			$0038
match_MOVEM_abs_add_long		EQU			$0039

match_MOVEM_An_indir_r0			EQU			$0010
match_MOVEM_An_indir_r1			EQU			$0011
match_MOVEM_An_indir_r2			EQU			$0012
match_MOVEM_An_indir_r3			EQU			$0013
match_MOVEM_An_indir_r4			EQU			$0014
match_MOVEM_An_indir_r5			EQU			$0015
match_MOVEM_An_indir_r6			EQU			$0016
match_MOVEM_An_indir_r7			EQU			$0017


match_MOVEM_An_indir_pinc_r0		EQU			$0018
match_MOVEM_An_indir_pinc_r1		EQU			$0019
match_MOVEM_An_indir_pinc_r2		EQU			$001A
match_MOVEM_An_indir_pinc_r3		EQU			$001B
match_MOVEM_An_indir_pinc_r4		EQU			$001C
match_MOVEM_An_indir_pinc_r5		EQU			$001D
match_MOVEM_An_indir_pinc_r6		EQU			$001E
match_MOVEM_An_indir_pinc_r7		EQU			$001F

match_MOVEM_imm_add                 EQU         $0038
match_MOVEM_imm_add_word            EQU         $0038
match_MOVEM_imm_add_long            EQU         $0039
*----------------------------------------------------------------------------
* 
* 							Register List Matches
*
*----------------------------------------------------------------------------
match_MOVEM_reg_mem_D0        EQU         $8000
match_MOVEM_reg_mem_D1        EQU         $4000
match_MOVEM_reg_mem_D2        EQU         $2000
match_MOVEM_reg_mem_D3        EQU         $1000
match_MOVEM_reg_mem_D4        EQU         $0800
match_MOVEM_reg_mem_D5        EQU         $0400
match_MOVEM_reg_mem_D6        EQU         $0200
match_MOVEM_reg_mem_D7        EQU         $0100

match_MOVEM_reg_mem_A0        EQU         $0080
match_MOVEM_reg_mem_A1        EQU         $0040
match_MOVEM_reg_mem_A2        EQU         $0020
match_MOVEM_reg_mem_A3        EQU         $0010
match_MOVEM_reg_mem_A4        EQU         $0008
match_MOVEM_reg_mem_A5        EQU         $0004
match_MOVEM_reg_mem_A6        EQU         $0002
match_MOVEM_reg_mem_A7        EQU         $0001


match_MOVEM_mem_reg_A7        EQU         $8000
match_MOVEM_mem_reg_A6        EQU         $4000
match_MOVEM_mem_reg_A5        EQU         $2000
match_MOVEM_mem_reg_A4        EQU         $1000
match_MOVEM_mem_reg_A3        EQU         $0800
match_MOVEM_mem_reg_A2        EQU         $0400
match_MOVEM_mem_reg_A1        EQU         $0200
match_MOVEM_mem_reg_A0        EQU         $0100

match_MOVEM_mem_reg_D7        EQU         $8000
match_MOVEM_mem_reg_D6        EQU         $4000
match_MOVEM_mem_reg_D5        EQU         $2000
match_MOVEM_mem_reg_D4        EQU         $1000
match_MOVEM_mem_reg_D3        EQU         $0800
match_MOVEM_mem_reg_D2        EQU         $0400
match_MOVEM_mem_reg_D1        EQU         $0200
match_MOVEM_mem_reg_D0        EQU         $0100





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
