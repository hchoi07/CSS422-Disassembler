*-----------------------------------------------------------
* Title      :AND ANDroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------    
   
;--------------------------------------------------------AND ANDroutine-----------------------------------------------------------------------
AND_sub                                MOVEM.L           D1-D5/D7/A2-A6, -(SP)              ;preserve the registers, 
                                 
                                       AND.L              #mask_opmode,D1                       ;load mask to determine the operand order
                                
AND_Dn_ea_match                        CMP.L              #match_AND_b_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                AND_Dn_ea                             ;if equal go figure out data register
                                       BNE                AND_Dn_ea_match_w                     ;if not check word size for same order

AND_Dn_ea_match_w                      CMP.L              #match_AND_w_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                AND_Dn_ea                             ;if equal go figure out data register
                                       BNE                AND_Dn_ea_match_l                     ;if not check long size for same order

AND_Dn_ea_match_l                      CMP.L              #match_AND_l_Dn_ea,D1                 ;check to see if it's Dn,ea
                                       BEQ                AND_Dn_ea                             ;if equal go figure out data register
                                       BNE                AND_ea_Dn_match                           ;if not check other order

AND_ea_Dn_match                        CMP.L              #match_AND_b_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                AND_ea_Dn                             ;if equal go figure out ea mode
                                       BNE                AND_ea_Dn_match_w                     ;if not go check word size for same order

AND_ea_Dn_match_w                      CMP.L              #match_AND_w_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                AND_ea_Dn                             ;if equal go figure out ea mode
                                       BNE                AND_ea_Dn_match_l                     ;if not go check word size for same order

AND_ea_Dn_match_l                      CMP.L              #match_AND_l_ea_Dn,D1                 ;check to see if it's ea,Dn
                                       BEQ                AND_ea_Dn                             ;if equal go figure out ea mode
                                       BNE                ERROR                                 ;if not go to error message
;--------------------------------------------------------------------------------------------------------------------------
*                                               EA,Dn Order                                       
;-------------------------------------------------------------------------------------------------------------------------
AND_ea_Dn                            CLR               D1                                          ;clear D1 to load new mask                                
                                     AND.L             #mask_AND_ea_mode,D1                        ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
AND_ea_Dn_add_reg_indir              CMP.L             #match_AND_An_indir,D1                       ;check to see if mode is add reg indir
                                     BNE               AND_ea_Dn_add_reg_indir_pdec                 ;if not, go check add reg indir predec 
                                     BEQ               AND_ea_Dn_An_indir_reg                       ;if equal go figure out the register           
           
AND_ea_Dn_add_reg_indir_pdec         CMP.L             #match_AND_An_indir_predec,D1                ;check to see if mode is add reg indor w/ postinc
                                     BNE               AND_ea_Dn_add_reg_indir_pinc                 ;if not go check add reg indir/predec
                                     BEQ               AND_ea_Dn_An_indir_predec                      ;if equal go figure out the register
                      
AND_ea_Dn_add_reg_indir_pinc         CMP.L             #match_AND_An_indir_postinc,D1               ;check to see if mode is add reg indir w/predec
                                     BNE               AND_ea_Dn_abs_add_word                       ;if not go check abs add word
                                     BEQ               AND_ea_Dn_An_indir_pinc_reg                    ;if equal go figure out the register

AND_ea_Dn_abs_add_word               AND.L             #mask_AND_abs_add,D2                         ;load mask to determine if abs add word or long
                                 
                                     CMP.L             #match_AND_abs_add_word,D2                   ;check if abs add word
                                     MOVE.L            (A0)+,D5                                     ;pull the next word instruction that holds the address
                                     BNE               AND_ea_Dn_abs_add_long                       ;if not go check abs add long
                                     BEQ               AND_ea_Dn_abs_add_word_out                   ;if equal go to output
  
AND_ea_Dn_abs_add_long               CMP.L             #match_AND_abs_add_long,D2                   ;check to see if abs add long
                                     BEQ               AND_ea_Dn_abs_add_long_out                   ;if equal go to output
                                     BNE               ERROR                                        ;if not equal go to error mesage AND routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 AND.L              #mask_AND_ea_reg_and_mode,D2             ;load the mask into D2 for the mode and the register
;-----------------------------------Data Register Direct--------------------------------
AND_ea_Dn_Dn_reg                 CMP.L              #match_AND_D0,D2                         ;check to see in the register is 0
                                 BNE                AND_ea_Dn_rD1                            ;if not go check register 1
                                 BEQ                AND_ea_Dn_D0_out                         ;if equal go to output ANDroutine

AND_ea_Dn_rD1                    CMP.L              #match_AND_D1,D2                          ;check to see in the register is 1
                                 BNE                AND_ea_Dn_rD2                             ;if not go check register 2
                                 BEQ                AND_ea_Dn_D1_out                          ;if equal go to output ANDroutine

AND_ea_Dn_rD2                    CMP.L              #match_AND_D2,D2                          ;check to see in the register is 2
                                 BNE                AND_ea_Dn_rD3                             ;if not go check register 3
                                 BEQ                AND_ea_Dn_D2_out                          ;if equal go to output ANDroutine

AND_ea_Dn_rD3                    CMP.L              #match_AND_D3,D2                          ;check to see in the register is 3
                                 BNE                AND_ea_Dn_rD4                             ;if not go check register 4
                                 BEQ                AND_ea_Dn_D3_out                          ;if equal go to output ANDroutine

AND_ea_Dn_rD4                    CMP.L              #match_AND_D4,D2                          ;check to see in the register is 4
                                 BNE                AND_ea_Dn_rD5                             ;if not go check register 5
                                 BEQ                AND_ea_Dn_D4_out                          ;if equal go to output ANDroutine

AND_ea_Dn_rD5                    CMP.L              #match_AND_D5,D2                          ;check to see in the register is 5
                                 BNE                AND_ea_Dn_rD6                             ;if not go check register 6
                                 BEQ                AND_ea_Dn_D5_out                          ;if equal go to output ANDroutine

AND_ea_Dn_rD6                    CMP.L              #match_AND_D6,D2                          ;check to see in the register is 6
                                 BNE                AND_ea_Dn_rD7                             ;if not go check register 7
                                 BEQ                AND_ea_Dn_D6_out                          ;if equal go to output ANDroutine

AND_ea_Dn_rD7                    CMP.L              #match_AND_D7,D2                          ;check to see in the register is 7
                                 BEQ                AND_ea_Dn_D7_out                          ;if equal go to output ANDroutine
                                 BNE                ERROR                                     ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
AND_ea_Dn_D0_out                MOVE.L          #ea_D0,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D1_out                MOVE.L          #ea_D1,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D2_out                MOVE.L          #ea_D2,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D3_out                MOVE.L			#ea_D3,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D4_out                MOVE.L			#ea_D4,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D5_out                MOVE.L			#ea_D5,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D6_out                MOVE.L			#ea_D6,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_D7_out                MOVE.L			#ea_D7,A1							;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

;------------------Address Register Direct-----------------------
AND_ea_Dn_An_reg                 CMP.L           #match_AND_A0,D2                        ;check reg is equal to 0
                                 BNE             AND_ea_Dn_rA1                           ;if not try reg 1
                                 BEQ             AND_ea_Dn_An_indir_reg0_out             ;if equal go to output ANDroutine

AND_ea_Dn_rA1                    CMP.L           #match_AND_A1,D2                        ;check reg is equal to 1
                                 BNE             AND_ea_Dn_rA2                           ;if not try reg 2
                                 BEQ             AND_ea_Dn_An_indir_reg1_out             ;if equal go to output ANDroutine

AND_ea_Dn_rA2                    CMP.L           #match_AND_A2,D2                        ;check reg is equal to 2
                                 BNE             AND_ea_Dn_rA3                           ;if not try reg 3
                                 BEQ             AND_ea_Dn_An_indir_reg2_out             ;if equal go to output ANDroutine

AND_ea_Dn_rA3                    CMP.L           #match_AND_A3,D2                        ;check reg is equal to 3
                                 BNE             AND_ea_Dn_rA4                           ;if not try reg 4
                                 BEQ             AND_ea_Dn_An_indir_reg3_out             ;if equal go to output ANDroutine

AND_ea_Dn_rA4                    CMP.L           #match_AND_A4,D2                        ;check reg is equal to 4
                                 BNE             AND_ea_Dn_rA5                           ;if not try reg 5
                                 BEQ             AND_ea_Dn_An_indir_reg4_out             ;if equal go to output ANDroutine
            
AND_ea_Dn_rA5                    CMP.L           #match_AND_A5,D2                        ;check reg is equal to 5
                                 BNE             AND_ea_Dn_rA6                           ;if not try reg 6
                                 BEQ             AND_ea_Dn_An_indir_reg5_out             ;if equal go to output ANDroutine

AND_ea_Dn_rA6                    CMP.L           #match_AND_A6,D2                        ;check reg is equal to 6
                                 BNE             AND_ea_Dn_rA7                           ;if not try reg 7
                                 BEQ             AND_ea_Dn_An_indir_reg6_out             ;if equal go to output ANDroutine

AND_ea_Dn_rA7                    CMP.L           #match_AND_A7,D2                        ;check reg is equal to 7
                                 BEQ             AND_ea_Dn_An_indir_reg7_out             ;if equal go to output ANDroutine
                                 BNE             ERROR                                   ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Direct Output-----------------------
AND_ea_Dn_A0_out                MOVE.L			#ea_A0,A1							    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand
        						
AND_ea_Dn_A1_out                MOVE.L			#ea_A1,A1							    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand
        						
AND_ea_Dn_A2_out                MOVE.L			#ea_A2,A1						        ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand
        						
AND_ea_Dn_A3_out                MOVE.L			#ea_A3,A1					    	    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_A4_out                MOVE.L			#ea_A4,A1				    		    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_A5_out                MOVE.L			#ea_A5,A1			    			    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_A6_out                MOVE.L			#ea_A6,A1		    				    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_A7_out                MOVE.L			#ea_A7,A1	    					    ;load string constant into A1
                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

;------------------Address Register Indirect-----------------------
AND_ea_Dn_An_indir_reg           CMP.L          #match_AND_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             AND_ea_Dn_An_indir_reg1               ;if not try reg 1
                                 BEQ             AND_ea_Dn_An_indir_reg0_out           ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_reg1          CMP.L           #match_AND_An_indir_r1,D2             ;check reg is equal to 1
                                 BNE             AND_ea_Dn_An_indir_reg2               ;if not try reg 2
                                 BEQ             AND_ea_Dn_An_indir_reg1_out           ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_reg2          CMP.L           #match_AND_An_indir_r2,D2             ;check reg is equal to 2
                                 BNE             AND_ea_Dn_An_indir_reg3               ;if not try reg 3
                                 BEQ             AND_ea_Dn_An_indir_reg2_out           ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_reg3          CMP.L           #match_AND_An_indir_r3,D2             ;check reg is equal to 3
                                 BNE             AND_ea_Dn_An_indir_reg4               ;if not try reg 4
                                 BEQ             AND_ea_Dn_An_indir_reg3_out           ;if equal go to output ANDroutine
    
AND_ea_Dn_An_indir_reg4          CMP.L           #match_AND_An_indir_r4,D2             ;check reg is equal to 4
                                 BNE             AND_ea_Dn_An_indir_reg5               ;if not try reg 5
                                 BEQ             AND_ea_Dn_An_indir_reg4_out           ;if equal go to output ANDroutine
        
AND_ea_Dn_An_indir_reg5          CMP.L           #match_AND_An_indir_r5,D2             ;check reg is equal to 5
                                 BNE             AND_ea_Dn_An_indir_reg6               ;if not try reg 6
                                 BEQ             AND_ea_Dn_An_indir_reg5_out           ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_reg6          CMP.L           #match_AND_An_indir_r6,D2             ;check reg is equal to 6
                                 BNE             AND_ea_Dn_An_indir_reg7               ;if not try reg 7
                                 BEQ             AND_ea_Dn_An_indir_reg6_out           ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_reg7          CMP.L           #match_AND_An_indir_r7,D2             ;check reg is equal to 7
                                 BEQ             AND_ea_Dn_An_indir_reg7_out           ;if equal go to output ANDroutine
                                 BNE             ERROR                                 ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
AND_ea_Dn_An_indir_reg0_out			        MOVE.L			#ea_indir_A0,A1		    	          ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_reg1_out			        MOVE.L			#ea_indir_A1,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_reg2_out			        MOVE.L			#ea_indir_A2,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_reg3_out			        MOVE.L			#ea_indir_A3,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_reg4_out			        MOVE.L			#ea_indir_A4,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_reg5_out			        MOVE.L			#ea_indir_A5,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_reg6_out			        MOVE.L			#ea_indir_A6,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand
								        
AND_ea_Dn_An_indir_reg7_out			        MOVE.L			#ea_indir_A7,A1		    		    ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

;------------------Address Register Indirect with Post Increment-----------------------
AND_ea_Dn_An_indir_pinc_reg                 CMP.L      #match_AND_An_indir_postinc_r0,D2                    ;check reg is equal to 0
                                            BNE        AND_ea_Dn_An_indir_pinc_r1                      ;if not try reg 1
                                            BEQ        AND_ea_Dn_An_indir_pinc_r0_out                  ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pinc_r1                  CMP.L      #match_AND_An_indir_postinc_r1,D2                    ;check reg is equal to 1
                                            BNE        AND_ea_Dn_An_indir_pinc_r2                      ;if not try reg 2
                                            BEQ        AND_ea_Dn_An_indir_pinc_r1_out                  ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pinc_r2                  CMP.L      #match_AND_An_indir_postinc_r2,D2                    ;check reg is equal to 2
                                            BNE        AND_ea_Dn_An_indir_pinc_r3                      ;if not try reg 3
                                            BEQ        AND_ea_Dn_An_indir_pinc_r2_out                  ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pinc_r3                  CMP.L      #match_AND_An_indir_postinc_r3,D2                    ;check reg is equal to 3
                                            BNE        AND_ea_Dn_An_indir_pinc_r4                      ;if not try reg 4
                                            BEQ        AND_ea_Dn_An_indir_pinc_r3_out                  ;if equal go to output ANDroutine
 
AND_ea_Dn_An_indir_pinc_r4                  CMP.L      #match_AND_An_indir_postinc_r4,D2                    ;check reg is equal to 4
                                            BNE        AND_ea_Dn_An_indir_pinc_r5                      ;if not try reg 5
                                            BEQ        AND_ea_Dn_An_indir_pinc_r4_out                  ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pinc_r5                  CMP.L      #match_AND_An_indir_postinc_r5,D2                    ;check reg is equal to 5
                                            BNE        AND_ea_Dn_An_indir_pinc_r6                      ;if not try reg 6
                                            BEQ        AND_ea_Dn_An_indir_pinc_r5_out                  ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pinc_r6                  CMP.L      #match_AND_An_indir_postinc_r6,D2                      ;check reg is equal to 6
                                            BNE        AND_ea_Dn_An_indir_pinc_r7                        ;if not try reg 7
                                            BEQ        AND_ea_Dn_An_indir_pinc_r6_out                    ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pinc_r7                  CMP.L      #match_AND_An_indir_postinc_r7,D2                      ;check reg is equal to 7
                                            BEQ        AND_ea_Dn_An_indir_pinc_r7_out                    ;if equal go to output ANDroutine
                                            BNE        ERROR                                                  ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
AND_ea_Dn_An_indir_pinc_r0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pinc_r7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    	  ;load string constant into A1
                                            JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand


;------------------Address Register Indirect with Pre Decrement-----------------------
AND_ea_Dn_An_indir_predec                       CMP.L      #match_AND_An_indir_predec_reg0,D2               ;check reg is equal to 0
                                                BNE        AND_ea_Dn_An_indir_pdec_r1                   ;if not try reg 1
                                                BEQ        AND_ea_Dn_An_indir_pdec_r0_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r1                      CMP.L      #match_AND_An_indir_predec_reg1,D2               ;check reg is equal to 1
                                                BNE        AND_ea_Dn_An_indir_pdec_r2                   ;if not try reg 2
                                                BEQ        AND_ea_Dn_An_indir_pdec_r1_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r2                      CMP.L      #match_AND_An_indir_predec_reg2,D2               ;check reg is equal to 2
                                                BNE        AND_ea_Dn_An_indir_pdec_r3                   ;if not try reg 3
                                                BEQ        AND_ea_Dn_An_indir_pdec_r2_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r3                      CMP.L      #match_AND_An_indir_predec_reg3,D2               ;check reg is equal to 3
                                                BNE        AND_ea_Dn_An_indir_pdec_r4                   ;if not try reg 4
                                                BEQ        AND_ea_Dn_An_indir_pdec_r3_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r4                      CMP.L      #match_AND_An_indir_predec_reg4,D2               ;check reg is equal to 4
                                                BNE        AND_ea_Dn_An_indir_pdec_r5                   ;if not try reg 5
                                                BEQ        AND_ea_Dn_An_indir_pdec_r4_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r5                      CMP.L      #match_AND_An_indir_predec_reg5,D2               ;check reg is equal to 5
                                                BNE        AND_ea_Dn_An_indir_pdec_r6                   ;if not try reg 6
                                                BEQ        AND_ea_Dn_An_indir_pdec_r5_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r6                      CMP.L      #match_AND_An_indir_predec_reg6,D2               ;check reg is equal to 6
                                                BNE        AND_ea_Dn_An_indir_pdec_r7                   ;if not try reg 7
                                                BEQ        AND_ea_Dn_An_indir_pdec_r6_out               ;if equal go to output ANDroutine

AND_ea_Dn_An_indir_pdec_r7                      CMP.L      #match_AND_An_indir_predec_reg7,D2               ;check reg is equal to 7
                                                BEQ        AND_ea_Dn_An_indir_pdec_r7_out               ;if equal go to output ANDroutine
                                                BNE        ERROR                                            ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
AND_ea_Dn_An_indir_pdec_r0_out			        MOVE.L			#ea_indir_predec_A0,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand
											
AND_ea_Dn_An_indir_pdec_r1_out			        MOVE.L			#ea_indir_predec_A1,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pdec_r2_out			        MOVE.L			#ea_indir_predec_A2,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pdec_r3_out			        MOVE.L			#ea_indir_predec_A3,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pdec_r4_out			        MOVE.L			#ea_indir_predec_A4,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pdec_r5_out			        MOVE.L			#ea_indir_predec_A5,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pdec_r6_out			        MOVE.L			#ea_indir_predec_A6,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                  ;jump to ANDroutine to determine second operand

AND_ea_Dn_An_indir_pdec_r7_out			        MOVE.L			#ea_indir_predec_A7,A1			 ;load string constant into A1
                                                JSR             AND_determine_second_op                 ;jump to ANDroutine to determine second operand
        
;------------------Absolute Addressing Output-----------------------
AND_ea_Dn_abs_add_word_out			      MOVE.L      #ea_$,(A1)+                       ;load $ for hex and increment A1
                                          MOVE.L      D5,(A1)+                          ;load address                  
                                          JSR         AND_determine_second_op           ;jump to ANDroutine to determine second operand
                                           

AND_ea_Dn_abs_add_long_out      	     MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         JSR         AND_determine_second_op            ;jump to ANDroutine to determine second operand

;---------------Immediate Addresing---------------------------
AND_ea_Dn_immediate_add_out         MOVE.L		(A0)+,D5                           ;capture the immediate address
									CMP.L       #match_AND_imm_add_word,D6         ;check to see if need to pull word
									MOVE.L      (A0)+,D5                           ;pull the word
                                    BEQ         AND_ea_Dn_imm_add_w                ;if equal go pull word    
									BNE         AND_ea_Dn_imm_add_l                ;if not equal, go check long
										 
AND_ea_Dn_imm_add_w                 MOVE.L     #ea_$,(A1)+                         ;load the $
                                    MOVE.W     D5,(A1)+                            ;load the word address                           
                                    JSR        AND_determine_second_op             ;jump to ANDroutine to determine second operand
                                         
AND_ea_Dn_imm_add_l                 MOVE.L     (A0)+,D5                            ;pull the long and increase the pointer
                                    MOVE.L     #ea_$,(A1)+                         ;load the $
                                    MOVE.L     D5,A1                               ;move to A1
                                    JSR        AND_determine_second_op             ;jump to ANDroutine to determine second operand

;---------------------------------Determine Register----------------------------------------------------------------------------------------
AND_determine_second_op							CLR.L		D2							;clear D2 
												AND.L		#mask_AND_An_reg,D2		      ;load the mask for the register into D2, masks bit 11-9
												
ea_Dn_AND_reg0									CMP.L		#match_AND_reg0,D2		      ;check to see if reg equal 0
												BNE			ea_Dn_AND_reg1				;if not equal got check reg 1
												BEQ			ea_Dn_AND_reg0_out			;if equal go to output
												
ea_Dn_AND_reg1									CMP.L		#match_AND_reg1,D2		       ;check to see if reg equal 1
												BNE			ea_Dn_AND_reg2				 ;if not equal got check reg 2
												BEQ			ea_Dn_AND_reg1_out			 ;if equal go to output

ea_Dn_AND_reg2	    							CMP.L		#match_AND_reg2,D2		       ;check to see if reg equal 2
												BNE			ea_Dn_AND_reg3				 ;if not equal got check reg 3
												BEQ			ea_Dn_AND_reg2_out			 ;if equal go to output

ea_Dn_AND_reg3									CMP.L		#match_AND_reg3,D2		       ;check to see if reg equal 3
												BNE			ea_Dn_AND_reg4				 ;if not equal got check reg 4
												BEQ			ea_Dn_AND_reg3_out			 ;if equal go to output
												
ea_Dn_AND_reg4									CMP.L		#match_AND_reg4,D2		       ;check to see if reg equal 4
												BNE			ea_Dn_AND_reg5				 ;if not equal got check reg 5
												BEQ			ea_Dn_AND_reg4_out			 ;if equal go to output

ea_Dn_AND_reg5									CMP.L		#match_AND_reg5,D2		       ;check to see if reg equal 5
												BNE			ea_Dn_AND_reg6				 ;if not equal got check reg 6
												BEQ			ea_Dn_AND_reg5_out			 ;if equal go to output

ea_Dn_AND_reg6									CMP.L		#match_AND_reg6,D2		       ;check to see if reg equal 6
												BNE			ea_Dn_AND_reg7				 ;if not equal got check reg 7
												BEQ			ea_Dn_AND_reg6_out			 ;if equal go to output			

ea_Dn_AND_reg7  								CMP.L		#match_AND_reg7,D2		       ;check to see if reg equal 7
												BEQ			ea_Dn_AND_reg7_out			 ;if equal go to output
												BNE         ERROR                          ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
ea_Dn_AND_reg0_out			                    MOVE.L			#ea_D0,A1	                     ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
											
ea_Dn_AND_reg1_out			                    MOVE.L			#ea_D1,A1	             		;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
                                            
ea_Dn_AND_reg2_out			                    MOVE.L			#ea_D2,A1	             		;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
                                            
ea_Dn_AND_reg3_out			                    MOVE.L			#ea_D3,A1	                   	;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
                                            
ea_Dn_AND_reg4_out			                    MOVE.L			#ea_D4,A1	             		;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
                                            
ea_Dn_AND_reg5_out			                    MOVE.L			#ea_D5,A1	                   	;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
                                            
ea_Dn_AND_reg6_out			                    MOVE.L			#ea_D6,A1		               	;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS
                                            
ea_Dn_AND_reg7_out			                    MOVE.L			#ea_D7,A1		               	;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS				
                                            
                    






























                        
;------------------------------------------------------------------------------------------------------------------------------------------
*                                               Dn,ea
* 
* 
* 
;------------------------------------------------------------------------------------------------------------------------------------------                                              
;---------------------------------Determine Register----------------------------------------------------------------------------------------
AND_Dn_ea           						    CLR.L		D2							      ;clear D2 
												AND.L		#mask_AND_An_reg,D2		      ;load the mask for the register into D2, masks bit 11-9
												
Dn_ea_AND_reg0   								CMP.L		#match_AND_reg0,D2		            ;check to see if reg equal 0
												BNE			Dn_ea_AND_reg1					;if not equal got check reg 1
												BEQ			Dn_ea_AND_reg0_out				;if equal go to output
												
Dn_ea_AND_reg1									CMP.L		#match_AND_reg1,D2		            ;check to see if reg equal 1
												BNE			Dn_ea_AND_reg2					;if not equal got check reg 2
												BEQ			Dn_ea_AND_reg1_out				;if equal go to output

Dn_ea_AND_reg2									CMP.L		#match_AND_reg2,D2		            ;check to see if reg equal 2
												BNE			Dn_ea_AND_reg3					;if not equal got check reg 3
												BEQ			Dn_ea_AND_reg2_out				;if equal go to output

Dn_ea_AND_reg3									CMP.L		#match_AND_reg3,D2		            ;check to see if reg equal 3
												BNE			Dn_ea_AND_reg4					;if not equal got check reg 4
												BEQ			Dn_ea_AND_reg3_out				;if equal go to output
												
Dn_ea_AND_reg4									CMP.L		#match_AND_reg4,D2		            ;check to see if reg equal 4
												BNE			Dn_ea_AND_reg5					;if not equal got check reg 5
												BEQ			Dn_ea_AND_reg4_out				;if equal go to output

Dn_ea_AND_reg5									CMP.L		#match_AND_reg5,D2		            ;check to see if reg equal 5
												BNE			Dn_ea_AND_reg6					;if not equal got check reg 6
												BEQ			Dn_ea_AND_reg5_out				;if equal go to output

Dn_ea_AND_reg6									CMP.L		#match_AND_reg6,D2		            ;check to see if reg equal 6
												BNE			Dn_ea_AND_reg7					;if not equal got check reg 7
												BEQ			Dn_ea_AND_reg6_out				;if equal go to output			

Dn_ea_AND_reg7								    CMP.L		#match_AND_reg7,D2		            ;check to see if reg equal 7
												BEQ			Dn_ea_AND_reg7_out				;if equal go to output
												BNE          ERROR                                ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
Dn_ea_AND_reg0_out		         MOVE.L			#ea_D0,A1					                       ;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
											
Dn_ea_AND_reg1_out		         MOVE.L			#ea_D1,A1				                		;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
Dn_ea_AND_reg2_out		         MOVE.L			#ea_D2,A1				                		;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
Dn_ea_AND_reg3_out		         MOVE.L			#ea_D3,A1				                        	;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
Dn_ea_AND_reg4_out		         MOVE.L			#ea_D4,A1				                    		;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
Dn_ea_AND_reg5_out		         MOVE.L			#ea_D5,A1					                     	;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
Dn_ea_AND_reg6_out		         MOVE.L			#ea_D6,A1					                    	;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
Dn_ea_AND_reg7_out    	         MOVE.L		    #ea_D7,A1					                    	;load string constant into A1
                                 JSR            AND_determine_second_operand                 ;jump to ANDroutine to determine second operand
                                            
;------------------------------------------------------Determine Second Operand----------------------------------------------------------------
AND_determine_second_operand         CLR               D1                                            ;clear D1 to load new mask                                
                                 AND.L             #mask_AND_ea_mode,D1                        ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
Dn_ea_add_reg_indir              CMP.L             #match_AND_An_indir,D1                      ;check to see if mode is add reg indir
                                 BNE               Dn_ea_add_reg_indir_predec                          ;if not, go check add reg indir predec 
                                 BEQ               Dn_ea_An_indir_reg                                  ;if equal go figure out the register           
           
Dn_ea_add_reg_indir_predec       CMP.L             #match_AND_An_indir_predec,D1               ;check to see if mode is add reg indor w/ postinc
                                 BNE               Dn_ea_add_reg_indir_postinc                         ;if not go check add reg indir/predec
                                 BEQ               Dn_ea_An_indir_predec                               ;if equal go figure out the register
                      
Dn_ea_add_reg_indir_postinc      CMP.L             #match_AND_An_indir_postinc,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               Dn_ea_abs_add_word                                  ;if not go check abs add word
                                 BEQ               Dn_ea_An_indir_postinc_reg                          ;if equal go figure out the register

Dn_ea_abs_add_word               AND.L             #mask_AND_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_AND_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               Dn_ea_abs_add_long                                  ;if not go check abs add long
                                 BEQ               Dn_ea_abs_add_word_out                              ;if equal go to output
  
Dn_ea_abs_add_long               CMP.L             #match_AND_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               Dn_ea_abs_add_long_out                              ;if equal go to output
                                 BNE               ERROR                                         ;if not equal go to error mesage AND routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 AND.L              #mask_AND_ea_reg_and_mode,D2         ;load the mask into D2 for the mode and the register
;------------------Address Register Indirect-----------------------
Dn_ea_An_indir_reg               CMP.L          #match_AND_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             Dn_ea_An_indir_reg1                           ;if not try reg 1
                                 BEQ             Dn_ea_An_indir_reg0_out                       ;if equal go to output ANDroutine

Dn_ea_An_indir_reg1              CMP.L           #match_AND_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             Dn_ea_An_indir_reg2                           ;if not try reg 2
                                 BEQ             Dn_ea_An_indir_reg1_out                       ;if equal go to output ANDroutine

Dn_ea_An_indir_reg2              CMP.L           #match_AND_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             Dn_ea_An_indir_reg3                           ;if not try reg 3
                                 BEQ             Dn_ea_An_indir_reg2_out                       ;if equal go to output ANDroutine

Dn_ea_An_indir_reg3              CMP.L           #match_AND_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             Dn_ea_An_indir_reg4                           ;if not try reg 4
                                 BEQ             Dn_ea_An_indir_reg3_out                       ;if equal go to output ANDroutine
    
Dn_ea_An_indir_reg4              CMP.L           #match_AND_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             Dn_ea_An_indir_reg5                           ;if not try reg 5
                                 BEQ             Dn_ea_An_indir_reg4_out                       ;if equal go to output ANDroutine
        
Dn_ea_An_indir_reg5              CMP.L           #match_AND_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             Dn_ea_An_indir_reg6                           ;if not try reg 6
                                 BEQ             Dn_ea_An_indir_reg5_out                       ;if equal go to output ANDroutine

Dn_ea_An_indir_reg6              CMP.L           #match_AND_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             Dn_ea_An_indir_reg7                           ;if not try reg 7
                                 BEQ             Dn_ea_An_indir_reg6_out                       ;if equal go to output ANDroutine

Dn_ea_An_indir_reg7              CMP.L           #match_AND_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             Dn_ea_An_indir_reg7_out                       ;if equal go to output ANDroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
Dn_ea_An_indir_reg0_out			MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

Dn_ea_An_indir_reg1_out			MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

Dn_ea_An_indir_reg2_out			MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

Dn_ea_An_indir_reg3_out			MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

Dn_ea_An_indir_reg4_out			MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

Dn_ea_An_indir_reg5_out			MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

Dn_ea_An_indir_reg6_out			MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS
								        
Dn_ea_An_indir_reg7_out			MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                 RTS

;------------------Address Register Indirect with Post Increment-----------------------
Dn_ea_An_indir_postinc_reg                  CMP.L      #match_AND_An_indir_postinc_r0,D2        ;check reg is equal to 0
                                            BNE        Dn_ea_An_indir_postinc_reg1                      ;if not try reg 1
                                            BEQ        Dn_ea_An_indir_postinc_reg0_out                  ;if equal go to output ANDroutine

Dn_ea_An_indir_postinc_reg1                 CMP.L      #match_AND_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        Dn_ea_An_indir_postinc_reg2                      ;if not try reg 2
                                            BEQ        Dn_ea_An_indir_postinc_reg1_out                  ;if equal go to output ANDroutine

Dn_ea_An_indir_postinc_reg2                 CMP.L      #match_AND_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        Dn_ea_An_indir_postinc_reg3                      ;if not try reg 3
                                            BEQ        Dn_ea_An_indir_postinc_reg2_out                  ;if equal go to output ANDroutine

Dn_ea_An_indir_postinc_reg3                 CMP.L      #match_AND_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        Dn_ea_An_indir_postinc_reg4                      ;if not try reg 4
                                            BEQ        Dn_ea_An_indir_postinc_reg3_out                  ;if equal go to output ANDroutine
 
Dn_ea_An_indir_postinc_reg4                 CMP.L      #match_AND_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        Dn_ea_An_indir_postinc_reg5                      ;if not try reg 5
                                            BEQ        Dn_ea_An_indir_postinc_reg4_out                  ;if equal go to output ANDroutine

Dn_ea_An_indir_postinc_reg5                 CMP.L      #match_AND_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        Dn_ea_An_indir_postinc_reg6                      ;if not try reg 6
                                            BEQ        Dn_ea_An_indir_postinc_reg5_out                  ;if equal go to output ANDroutine

Dn_ea_An_indir_postinc_reg6                 CMP.L      #match_AND_An_indir_postinc_r6,D2         ;check reg is equal to 6
                                            BNE        Dn_ea_An_indir_postinc_reg7                        ;if not try reg 7
                                            BEQ        Dn_ea_An_indir_postinc_reg6_out                    ;if equal go to output ANDroutine

Dn_ea_An_indir_postinc_reg7                 CMP.L      #match_AND_An_indir_postinc_r7,D2         ;check reg is equal to 7
                                            BEQ        Dn_ea_An_indir_postinc_reg7_out                    ;if equal go to output ANDroutine
                                            BNE        ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
Dn_ea_An_indir_postinc_reg0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

Dn_ea_An_indir_postinc_reg7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                        RTS

;------------------Address Register Indirect with Pre Decrement-----------------------
Dn_ea_An_indir_predec                       CMP.L      #match_AND_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                            BNE        Dn_ea_An_indir_predec_reg1                      ;if not try reg 1
                                            BEQ        Dn_ea_An_indir_predec_reg0_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg1                  CMP.L      #match_AND_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                            BNE        Dn_ea_An_indir_predec_reg2                      ;if not try reg 2
                                            BEQ        Dn_ea_An_indir_predec_reg1_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg2                  CMP.L      #match_AND_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                            BNE        Dn_ea_An_indir_predec_reg3                      ;if not try reg 3
                                            BEQ        Dn_ea_An_indir_predec_reg2_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg3                  CMP.L      #match_AND_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                            BNE        Dn_ea_An_indir_predec_reg4                      ;if not try reg 4
                                            BEQ        Dn_ea_An_indir_predec_reg3_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg4                  CMP.L      #match_AND_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                            BNE        Dn_ea_An_indir_predec_reg5                      ;if not try reg 5
                                            BEQ        Dn_ea_An_indir_predec_reg4_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg5                  CMP.L      #match_AND_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                            BNE        Dn_ea_An_indir_predec_reg6                     ;if not try reg 6
                                            BEQ        Dn_ea_An_indir_predec_reg5_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg6                  CMP.L      #match_AND_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                            BNE        Dn_ea_An_indir_predec_reg7                     ;if not try reg 7
                                            BEQ        Dn_ea_An_indir_predec_reg6_out               ;if equal go to output ANDroutine

Dn_ea_An_indir_predec_reg7                  CMP.L      #match_AND_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                            BEQ        Dn_ea_An_indir_predec_reg7_out               ;if equal go to output ANDroutine
                                            BNE        ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
Dn_ea_An_indir_predec_reg0_out			   MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS
											
Dn_ea_An_indir_predec_reg1_out			   MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS

Dn_ea_An_indir_predec_reg2_out			   MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS

Dn_ea_An_indir_predec_reg3_out			   MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS

Dn_ea_An_indir_predec_reg4_out			   MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS

Dn_ea_An_indir_predec_reg5_out			   MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS

Dn_ea_An_indir_predec_reg6_out			   MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS

Dn_ea_An_indir_predec_reg7_out			   MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                            RTS
                                            
;------------------Absolute Addressing Output-----------------------
Dn_ea_abs_add_word_out						 MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                      RTS                                            :return to ANDroutine
                                           

Dn_ea_abs_add_long_out    					 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                      RTS                                            :return to ANDroutine                                                                             
;----------------------Error Handling----------------------------------------
ERROR                                           LEA     ERROR_MESSAGE,A1                                          ;load error messge into A3
					                            MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                                RTS

mask_opmode                          EQU         $01C0                   ;mask for the opmode to determine operand order

mask_AND_ea_mode					EQU			$0038
mask_AND_abs_add					EQU			$003F
mask_AND_ea_reg_and_mode			EQU			$003F
mask_AND_An_reg					EQU			$0E00


match_AND_b_ea_Dn                    EQU         $0100                ;match for ea,Dn byte size
match_AND_w_ea_Dn                    EQU         $0140                ;match for ea,Dn word size
match_AND_l_ea_Dn                    EQU         $0180                ;match for ea,Dn long size

match_AND_b_Dn_ea                    EQU         $0000                ;match for Dn,ea byte size
match_AND_w_Dn_ea                    EQU         $0040                ;match for Dn,ea word size
match_AND_l_Dn_ea                    EQU         $0080                ;match for Dn,ea long size



match_AND_Dn						EQU			$0000
match_AND_An_indir				    EQU			$0010
match_AND_An_indir_predec			EQU			$0020
match_AND_An_indir_postinc			EQU			$0018
match_AND_abs_add_word				EQU			$0038
match_AND_abs_add_long				EQU			$0039

match_AND_D0							EQU			$0000
match_AND_D1							EQU			$0001
match_AND_D2							EQU			$0002
match_AND_D3							EQU			$0003
match_AND_D4							EQU			$0004
match_AND_D5							EQU			$0005
match_AND_D6							EQU			$0006
match_AND_D7							EQU			$0007

match_AND_A0							EQU			$0008
match_AND_A1							EQU			$0009
match_AND_A2							EQU			$000A
match_AND_A3							EQU			$000B
match_AND_A4							EQU			$000C
match_AND_A5							EQU			$000D
match_AND_A6							EQU			$000E
match_AND_A7							EQU			$000F

match_AND_An_indir_r0					EQU			$0010
match_AND_An_indir_r1					EQU			$0011
match_AND_An_indir_r2					EQU			$0012
match_AND_An_indir_r3					EQU			$0013
match_AND_An_indir_r4					EQU			$0014
match_AND_An_indir_r5					EQU			$0015
match_AND_An_indir_r6					EQU			$0016
match_AND_An_indir_r7					EQU			$0017

match_AND_An_indir_postinc_r0		EQU			$0018
match_AND_An_indir_postinc_r1		EQU			$0019
match_AND_An_indir_postinc_r2		EQU			$001A
match_AND_An_indir_postinc_r3		EQU			$001B
match_AND_An_indir_postinc_r4		EQU			$001C
match_AND_An_indir_postinc_r5		EQU			$001D
match_AND_An_indir_postinc_r6		EQU			$001E
match_AND_An_indir_postinc_r7		EQU			$001F

match_AND_An_indir_predec_reg0			EQU			$0020
match_AND_An_indir_predec_reg1			EQU			$0021
match_AND_An_indir_predec_reg2			EQU			$0022
match_AND_An_indir_predec_reg3			EQU			$0023
match_AND_An_indir_predec_reg4			EQU			$0024
match_AND_An_indir_predec_reg5			EQU			$0025
match_AND_An_indir_predec_reg6			EQU			$0026
match_AND_An_indir_predec_reg7			EQU			$0027

match_AND_imm_add                           EQU         $003C
match_AND_imm_add_word                      EQU         $00FC
match_AND_imm_add_long                      EQU         $01FC

match_AND_reg0							EQU			$0000
match_AND_reg1							EQU			$0200
match_AND_reg2							EQU			$0400
match_AND_reg3							EQU			$0600
match_AND_reg4							EQU			$0800
match_AND_reg5							EQU			$0A00
match_AND_reg6							EQU			$0C00
match_AND_reg7							EQU			$0E00










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
