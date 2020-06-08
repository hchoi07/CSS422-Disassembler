*-----------------------------------------------------------
* Title      :ADDQ Subroutine
* D0 holds the whole instruction, 
* D6 holds the size
* Both will be left intact for the subroutine
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------
ADDQ_sub                         MOVEM.L           D1-D5/D7/A2-A6, -(SP)                               ;preserve the registers, 
                                 AND.L             #mask_ADDQ_ea_mode,D1                                   ;move the mask to D1
                                 
;---------------------------------Determine Register----------------------------------------------------------------------------------------
								CLR.L		D2												;clear D2 
								AND.L		#mask_ADDQ_reg,D2								;load the mask for the register into D2, masks bit 11-9
												
ADDQ_reg0						CMP.L		#match_ADDQ_reg0,D2								;check to see if reg equal 0
								BNE			ADDQ_reg1										;if not equal got check reg 1
								BEQ			ADDQ_reg0_out									;if equal go to output
											
ADDQ_reg1						CMP.L		#match_ADDQ_reg1,D2								;check to see if reg equal 1
								BNE			ADDQ_reg2										;if not equal got check reg 2
								BEQ			ADDQ_reg1_out									;if equal go to output

ADDQ_reg2						CMP.L		#match_ADDQ_reg2,D2								;check to see if reg equal 2
								BNE			ADDQ_reg3										;if not equal got check reg 3
								BEQ			ADDQ_reg2_out									;if equal go to output

ADDQ_reg3						CMP.L		#match_ADDQ_reg3,D2								;check to see if reg equal 3
								BNE			ADDQ_reg4										;if not equal got check reg 4
								BEQ			ADDQ_reg3_out									;if equal go to output
												
ADDQ_reg4						CMP.L		#match_ADDQ_reg4,D2								;check to see if reg equal 4
								BNE			ADDQ_reg5										;if not equal got check reg 5
								BEQ			ADDQ_reg4_out									;if equal go to output

ADDQ_reg5						CMP.L		#match_ADDQ_reg5,D2								;check to see if reg equal 5
								BNE			ADDQ_reg6										;if not equal got check reg 6
								BEQ			ADDQ_reg5_out									;if equal go to output

ADDQ_reg6						CMP.L		#match_ADDQ_reg6,D2								;check to see if reg equal 6
								BNE			ADDQ_reg7										;if not equal got check reg 7
								BEQ			ADDQ_reg6_out									;if equal go to output			

ADDQ_reg7						CMP.L		#match_ADDQ_reg7,D2								;check to see if reg equal 7
								BEQ			ADDQ_reg7_out									;if equal go to output
								BNE         ERROR                                                ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
ADDQ_reg0_out			                    MOVE.L      #ea_data0,A1					           ;load string constant into A1
											JSR         ADDQ_determine_second_operand                ;jump to subroutine to determine the second operand
											
ADDQ_reg1_out			                    MOVE.L      #ea_data1,A1			    			;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand

ADDQ_reg2_out			                    MOVE.L      #ea_data2,A1				        		;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand

ADDQ_reg3_out			                    MOVE.L      #ea_data3,A1				    	        	;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand
 
ADDQ_reg4_out			                    MOVE.L      #ea_data4,A1			    			;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand

ADDQ_reg5_out			                    MOVE.L      #ea_data5,A1		    				;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand

ADDQ_reg6_out			                    MOVE.L      #ea_data6,A1	    					;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand

ADDQ_reg7_out			                    MOVE.L      #ea_data7,A1    						;load string constant into A1
											JSR         ADDQ_determine_second_operand                 ;jump to subroutine to determine the second operand
				

;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
ADDQ_determine_second_operand
ADDQ_data_reg_dir                CMP.L             #match_ADDQ_Dn,D1                             ;check to see if mode is data reg direct
                                 BNE               ADDQ_add_reg_dir                                   ;if not, go check add reg dir
                                 BEQ               ADDQ_Dn_reg                                        ;if equal go figure out the register

ADDQ_add_reg_dir                 CMP.L             #match_ADDQ_An,D1                             ;check if mode is add reg direct
                                 BNE               ADDQ_add_reg_indir                                 ;if not, go check add reg indir
                                 BEQ               ADDQ_An_reg                                        ;if equal go figure out the reg
 
ADDQ_add_reg_indir               CMP.L             #match_ADDQ_An_indir,D1                       ;check to see if mode is add reg indir
                                 BNE               ADDQ_add_reg_indir_predec                          ;if not, go check add reg indir predec 
                                 BEQ               ADDQ_An_indir_reg                                  ;if equal go figure out the register           
           
ADDQ_add_reg_indir_predec        CMP.L             #match_ADDQ_An_indir_predec,D1                ;check to see if mode is add reg indor w/ postinc
                                 BNE               ADDQ_add_reg_indir_postinc                         ;if not go check add reg indir/predec
                                 BEQ               ADDQ_An_indir_predec                               ;if equal go figure out the register
                      
ADDQ_add_reg_indir_postinc       CMP.L             #match_ADDQ_An_indir_postinc,D1               ;check to see if mode is add reg indir w/predec
                                 BNE               ADDQ_abs_add_word                                  ;if not go check abs add word
                                 BEQ               ADDQ_An_indir_pinc_reg                          ;if equal go figure out the register

ADDQ_abs_add_word                AND.L             #mask_ADDQ_abs_add,D2                         ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_ADDQ_abs_add_word,D2                   ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               ADDQ_abs_add_long                                  ;if not go check abs add long
                                 BEQ               ADDQ_abs_add_word_out                              ;if equal go to output
  
ADDQ_abs_add_long                CMP.L             #match_ADDQ_abs_add_long,D2                    ;check to see if abs add long
                                 BEQ               ADDQ_abs_add_long_out                               ;if equal go to output
								 BNE               ERROR

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 
;-----------------------------------Data Register Direct--------------------------------
ADDQ_Dn_reg                      AND.L              #mask_ADDQ_ea_reg_and_mode,D2                       ;load the mask into D2 for the mode and the register
                                 CMP.L              #match_ADDQ_D0,D2                       ;check to see in the register is 0
                                 BNE                ADDQ_rD1                                     ;if not go check register 1
                                 BEQ                ADDQ_D0_out                              ;if equal go to output subroutine

ADDQ_rD1                         CMP.L              #match_ADDQ_D1,D2                       ;check to see in the register is 1
                                 BNE                ADDQ_rD2                                     ;if not go check register 2
                                 BEQ                ADDQ_D1_out                              ;if equal go to output subroutine

ADDQ_rD2                         CMP.L              #match_ADDQ_D2,D2                       ;check to see in the register is 2
                                 BNE                ADDQ_rD3                                     ;if not go check register 3
                                 BEQ                ADDQ_D2_out                              ;if equal go to output subroutine

ADDQ_rD3                         CMP.L              #match_ADDQ_D3,D2                       ;check to see in the register is 3
                                 BNE                ADDQ_rD4                                     ;if not go check register 4
                                 BEQ                ADDQ_D3_out                              ;if equal go to output subroutine

ADDQ_rD4                         CMP.L              #match_ADDQ_D4,D2                       ;check to see in the register is 4
                                 BNE                ADDQ_rD5                                     ;if not go check register 5
                                 BEQ                ADDQ_D4_out                              ;if equal go to output subroutine

ADDQ_rD5                         CMP.L              #match_ADDQ_D5,D2                       ;check to see in the register is 5
                                 BNE                ADDQ_rD6                                     ;if not go check register 6
                                 BEQ                ADDQ_D5_out                              ;if equal go to output subroutine

ADDQ_rD6                         CMP.L              #match_ADDQ_D6,D2                       ;check to see in the register is 6
                                 BNE                ADDQ_rD7                                     ;if not go check register 7
                                 BEQ                ADDQ_D6_out                              ;if equal go to output subroutine

ADDQ_rD7                         CMP.L              #match_ADDQ_D7,D2                       ;check to see in the register is 7
                                 BEQ                ADDQ_D7_out                              ;if equal go to output subroutine
                                 BNE                ERROR                                   ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
ADDQ_D0_out                     MOVE.L              #ea_D0,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                RTS								        				;return to subroutine

ADDQ_D1_out                     MOVE.L              #ea_D1,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						RTS						        						;return to subroutine


ADDQ_D2_out                     MOVE.L              #ea_D2,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						RTS				        								;return to subroutine

ADDQ_D3_out                     MOVE.L              #ea_D3,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						RTS		        										;return to subroutine


ADDQ_D4_out                     MOVE.L              #ea_D4,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
           						RTS     												;return to subroutine
    

ADDQ_D5_out                     MOVE.L              #ea_D5,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						RTS									        			;return to subroutine


ADDQ_D6_out                     MOVE.L              #ea_D6,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						RTS							        					;return to subroutine


ADDQ_D7_out                     MOVE.L              #ea_D7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						RTS					        							;return to subroutine

;------------------Address Register Direct-----------------------
ADDQ_An_reg                      CMP.L           #match_ADDQ_A0,D2                           ;check reg is equal to 0
                                 BNE             ADDQ_rA1                                    ;if not try reg 1
                                 BEQ             ADDQ_An_indir_reg0_out                      ;if equal go to output subroutine

ADDQ_rA1                         CMP.L           #match_ADDQ_A1,D2                           ;check reg is equal to 1
                                 BNE             ADDQ_rA2                                    ;if not try reg 2
                                 BEQ             ADDQ_An_indir_reg1_out                      ;if equal go to output subroutine

ADDQ_rA2                         CMP.L           #match_ADDQ_A2,D2                           ;check reg is equal to 2
                                 BNE             ADDQ_rA3                                    ;if not try reg 3
                                 BEQ             ADDQ_An_indir_reg2_out                      ;if equal go to output subroutine

ADDQ_rA3                         CMP.L           #match_ADDQ_A3,D2                           ;check reg is equal to 3
                                 BNE             ADDQ_rA4                                    ;if not try reg 4
                                 BEQ             ADDQ_An_indir_reg3_out                      ;if equal go to output subroutine

ADDQ_rA4                         CMP.L           #match_ADDQ_A4,D2                           ;check reg is equal to 4
                                 BNE             ADDQ_rA5                                    ;if not try reg 5
                                 BEQ             ADDQ_An_indir_reg4_out                      ;if equal go to output subroutine
            
ADDQ_rA5                         CMP.L           #match_ADDQ_A5,D2                           ;check reg is equal to 5
                                 BNE             ADDQ_rA6                                    ;if not try reg 6
                                 BEQ             ADDQ_An_indir_reg5_out                      ;if equal go to output subroutine

ADDQ_rA6                         CMP.L           #match_ADDQ_A6,D2                           ;check reg is equal to 6
                                 BNE             ADDQ_rA7                                    ;if not try reg 7
                                 BEQ             ADDQ_An_indir_reg6_out                      ;if equal go to output subroutine

ADDQ_rA7                         CMP.L           #match_ADDQ_A7,D2                           ;check reg is equal to 7
                                 BEQ             ADDQ_An_indir_reg7_out                      ;if equal go to output subroutine
                                 BNE             ERROR                                       ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Direct Output-----------------------
ADDQ_A0_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											return to subroutine
        						
ADDQ_A1_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											;return to subroutine
        						
ADDQ_A2_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											;return to subroutine
        						
ADDQ_A3_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											;return to subroutine

ADDQ_A4_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											;return to subroutine

ADDQ_A5_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											;return to subroutine

ADDQ_A6_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        						     RTS											;return to subroutine

ADDQ_A7_out                          MOVE.L      #ea_A7,A1							;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
              						 RTS											;return to subroutine

;------------------Address Register Indirect-----------------------
ADDQ_An_indir_reg                CMP.L           #match_ADDQ_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             ADDQ_An_indir_reg1                      ;if not try reg 1
                                 BEQ             ADDQ_An_indir_reg0_out                  ;if equal go to output subroutine

ADDQ_An_indir_reg1               CMP.L           #match_ADDQ_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             ADDQ_An_indir_reg2                      ;if not try reg 2
                                 BEQ             ADDQ_An_indir_reg1_out                  ;if equal go to output subroutine

ADDQ_An_indir_reg2               CMP.L           #match_ADDQ_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             ADDQ_An_indir_reg3                      ;if not try reg 3
                                 BEQ             ADDQ_An_indir_reg2_out                  ;if equal go to output subroutine

ADDQ_An_indir_reg3               CMP.L           #match_ADDQ_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             ADDQ_An_indir_reg4                      ;if not try reg 4
                                 BEQ             ADDQ_An_indir_reg3_out                  ;if equal go to output subroutine
    
ADDQ_An_indir_reg4               CMP.L           #match_ADDQ_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             ADDQ_An_indir_reg5                      ;if not try reg 5
                                 BEQ             ADDQ_An_indir_reg4_out                  ;if equal go to output subroutine
        
ADDQ_An_indir_reg5               CMP.L           #match_ADDQ_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             ADDQ_An_indir_reg6                      ;if not try reg 6
                                 BEQ             ADDQ_An_indir_reg5_out                  ;if equal go to output subroutine

ADDQ_An_indir_reg6               CMP.L           #match_ADDQ_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             ADDQ_An_indir_reg7                      ;if not try reg 7
                                 BEQ             ADDQ_An_indir_reg6_out                  ;if equal go to output subroutine

ADDQ_An_indir_reg7               CMP.L           #match_ADDQ_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             ADDQ_An_indir_reg7_out                  ;if equal go to output subroutine
                                 BNE             ERROR                                   ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
ADDQ_An_indir_reg0_out			            MOVE.L      #ea_indir_A0,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

ADDQ_An_indir_reg1_out			            MOVE.L      #ea_indir_A1,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

ADDQ_An_indir_reg2_out			            MOVE.L      #ea_indir_A2,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

ADDQ_An_indir_reg3_out			            MOVE.L      #ea_indir_A3,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

ADDQ_An_indir_reg4_out			            MOVE.L      #ea_indir_A4,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

ADDQ_An_indir_reg5_out			            MOVE.L      #ea_indir_A5,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

ADDQ_An_indir_reg6_out			            MOVE.L      #ea_indir_A6,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine
								        
ADDQ_An_indir_reg7_out			            MOVE.L      #ea_indir_A7,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								            RTS										            	;return to subroutine

;------------------Address Register Indirect with Post Increment-----------------------
ADDQ_An_indir_pinc_reg                      CMP.L      #match_ADDQ_An_indir_postinc_reg0,D2            ;check reg is equal to 0
                                            BNE        ADDQ_An_indir_pinc_r1                           ;if not try reg 1
                                            BEQ        ADDQ_An_indir_pinc_r0_out                       ;if equal go to output subroutine

ADDQ_An_indir_pinc_r1                       CMP.L      #match_ADDQ_An_indir_postinc_reg1,D2            ;check reg is equal to 1
                                            BNE        ADDQ_An_indir_pinc_r2                           ;if not try reg 2
                                            BEQ        ADDQ_An_indir_pinc_r1_out                       ;if equal go to output subroutine

ADDQ_An_indir_pinc_r2                       CMP.L      #match_ADDQ_An_indir_postinc_reg2,D2            ;check reg is equal to 2
                                            BNE        ADDQ_An_indir_pinc_r3                           ;if not try reg 3
                                            BEQ        ADDQ_An_indir_pinc_r2_out                       ;if equal go to output subroutine

ADDQ_An_indir_pinc_r3                       CMP.L      #match_ADDQ_An_indir_postinc_reg3,D2            ;check reg is equal to 3
                                            BNE        ADDQ_An_indir_pinc_r4                           ;if not try reg 4
                                            BEQ        ADDQ_An_indir_pinc_r3_out                       ;if equal go to output subroutine
 
ADDQ_An_indir_pinc_r4                       CMP.L      #match_ADDQ_An_indir_postinc_reg4,D2            ;check reg is equal to 4
                                            BNE        ADDQ_An_indir_pinc_r5                           ;if not try reg 5
                                            BEQ        ADDQ_An_indir_pinc_r4_out                       ;if equal go to output subroutine

ADDQ_An_indir_pinc_r5                       CMP.L      #match_ADDQ_An_indir_postinc_reg5,D2            ;check reg is equal to 5
                                            BNE        ADDQ_An_indir_pinc_r6                           ;if not try reg 6
                                            BEQ        ADDQ_An_indir_pinc_r5_out                       ;if equal go to output subroutine

ADDQ_An_indir_pinc_r6                       CMP.L      #match_ADDQ_An_indir_postinc_reg6,D2             ;check reg is equal to 6
                                            BNE        ADDQ_An_indir_pinc_r7                            ;if not try reg 7
                                            BEQ        ADDQ_An_indir_pinc_r6_out                        ;if equal go to output subroutine

ADDQ_An_indir_pinc_r7                       CMP.L      #match_ADDQ_An_indir_postinc_reg7,D2             ;check reg is equal to 7
                                            BEQ        ADDQ_An_indir_pinc_r7_out                        ;if equal go to output subroutine
                                            BNE        ERROR                                            ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
ADDQ_An_indir_pinc_r0_out			            MOVE.L      #ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
        							  	        RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r1_out			            MOVE.L      #ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r2_out		    	        MOVE.L      #ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r3_out			            MOVE.L      #ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r4_out			            MOVE.L      #ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r5_out			            MOVE.L      #ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r6_out		    	        MOVE.L      #ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

ADDQ_An_indir_pinc_r7_out	    		        MOVE.L      #ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
								                RTS										            		;return to subroutine

;------------------Address Register Indirect with Pre Decrement-----------------------
ADDQ_An_indir_predec                       	CMP.L      #match_ADDQ_An_indir_predec_reg0,D2           ;check reg is equal to 0
                                            BNE        ADDQ_An_indir_pdec_r1                         ;if not try reg 1
                                            BEQ        ADDQ_An_indir_pdec_r0_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r1                       CMP.L      #match_ADDQ_An_indir_predec_reg1,D2           ;check reg is equal to 1
                                            BNE        ADDQ_An_indir_pdec_r2                         ;if not try reg 2
                                            BEQ        ADDQ_An_indir_pdec_r1_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r2                       CMP.L      #match_ADDQ_An_indir_predec_reg2,D2           ;check reg is equal to 2
                                            BNE        ADDQ_An_indir_pdec_r3                         ;if not try reg 3
                                            BEQ        ADDQ_An_indir_pdec_r2_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r3                       CMP.L      #match_ADDQ_An_indir_predec_reg3,D2           ;check reg is equal to 3
                                            BNE        ADDQ_An_indir_pdec_r4                         ;if not try reg 4
                                            BEQ        ADDQ_An_indir_pdec_r3_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r4                       CMP.L      #match_ADDQ_An_indir_predec_reg4,D2           ;check reg is equal to 4
                                            BNE        ADDQ_An_indir_pdec_r5                         ;if not try reg 5
                                            BEQ        ADDQ_An_indir_pdec_r4_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r5                       CMP.L      #match_ADDQ_An_indir_predec_reg5,D2           ;check reg is equal to 5
                                            BNE        ADDQ_An_indir_pdec_r6                         ;if not try reg 6
                                            BEQ        ADDQ_An_indir_pdec_r5_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r6                       CMP.L      #match_ADDQ_An_indir_predec_reg6,D2           ;check reg is equal to 6
                                            BNE        ADDQ_An_indir_pdec_r7                         ;if not try reg 7
                                            BEQ        ADDQ_An_indir_pdec_r6_out                     ;if equal go to output subroutine

ADDQ_An_indir_pdec_r7                       CMP.L      #match_ADDQ_An_indir_predec_reg7,D2           ;check reg is equal to 7
                                            BEQ        ADDQ_An_indir_pdec_r7_out                    ;if equal go to output subroutine
                                            BNE        ERROR                                        ;if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
ADDQ_An_indir_pdec_r0_out			        MOVE.L      #ea_indir_predec_A0,A1					      ;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine
											
ADDQ_An_indir_pdec_r1_out			        MOVE.L      #ea_indir_predec_A1,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

ADDQ_An_indir_pdec_r2_out			        MOVE.L      #ea_indir_predec_A2,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

ADDQ_An_indir_pdec_r3_out			        MOVE.L      #ea_indir_predec_A3,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

ADDQ_An_indir_pdec_r4_out			        MOVE.L      #ea_indir_predec_A4,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

ADDQ_An_indir_pdec_r5_out			        MOVE.L      #ea_indir_predec_A5,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

ADDQ_An_indir_pdec_r6_out			        MOVE.L      #ea_indir_predec_A6,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

ADDQ_An_indir_pdec_r7_out			        MOVE.L      #ea_indir_predec_A7,A1						;load string constant into A1
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
											RTS														;return to subroutine

;------------------Absolute Addressing Output-----------------------
ADDQ_abs_add_word_out					 MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                         RTS                                            :return to subroutine
                                           

ADDQ_abs_add_long_out    				 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                MOVEM.L           (SP)+, D1-D5/D7/A2-A6
                                         RTS                                           
;----------------------Error Handling----------------------------------------


mask_ADDQ_ea_mode			EQU			$0038
mask_ADDQ_abs_add			EQU			$003F
mask_ADDQ_ea_reg_and_mode	EQU			$003F
mask_ADDQ_reg				EQU			$0E00

match_ADDQ_Dn				EQU			$0000
match_ADDQ_An				EQU			$0008
match_ADDQ_An_indir			EQU			$0010
match_ADDQ_An_indir_predec	EQU			$0020
match_ADDQ_An_indir_postinc	EQU			$0018
match_ADDQ_abs_add_word		EQU			$0038
match_ADDQ_abs_add_long		EQU			$0039

match_ADDQ_D0				EQU			$0000
match_ADDQ_D1				EQU			$0001
match_ADDQ_D2				EQU			$0002
match_ADDQ_D3				EQU			$0003
match_ADDQ_D4				EQU			$0004
match_ADDQ_D5				EQU			$0005
match_ADDQ_D6				EQU			$0006
match_ADDQ_D7				EQU			$0007

match_ADDQ_A0				EQU			$0008
match_ADDQ_A1				EQU			$0009
match_ADDQ_A2				EQU			$000A
match_ADDQ_A3				EQU			$000B
match_ADDQ_A4				EQU			$000C
match_ADDQ_A5				EQU			$000D
match_ADDQ_A6				EQU			$000E
match_ADDQ_A7				EQU			$000F

match_ADDQ_An_indir_r0		EQU			$0010
match_ADDQ_An_indir_r1		EQU			$0011
match_ADDQ_An_indir_r2		EQU			$0012
match_ADDQ_An_indir_r3		EQU			$0013
match_ADDQ_An_indir_r4		EQU			$0014
match_ADDQ_An_indir_r5		EQU			$0015
match_ADDQ_An_indir_r6		EQU			$0016
match_ADDQ_An_indir_r7		EQU			$0017

match_ADDQ_An_indir_postinc_reg0		EQU			$0018
match_ADDQ_An_indir_postinc_reg1		EQU			$0019
match_ADDQ_An_indir_postinc_reg2		EQU			$001A
match_ADDQ_An_indir_postinc_reg3		EQU			$001B
match_ADDQ_An_indir_postinc_reg4		EQU			$001C
match_ADDQ_An_indir_postinc_reg5		EQU			$001D
match_ADDQ_An_indir_postinc_reg6		EQU			$001E
match_ADDQ_An_indir_postinc_reg7		EQU			$001F

match_ADDQ_An_indir_predec_reg0			EQU			$0020
match_ADDQ_An_indir_predec_reg1			EQU			$0021
match_ADDQ_An_indir_predec_reg2			EQU			$0022
match_ADDQ_An_indir_predec_reg3			EQU			$0023
match_ADDQ_An_indir_predec_reg4			EQU			$0024
match_ADDQ_An_indir_predec_reg5			EQU			$0025
match_ADDQ_An_indir_predec_reg6			EQU			$0026
match_ADDQ_An_indir_predec_reg7			EQU			$0027


match_ADDQ_reg0							EQU			$0000
match_ADDQ_reg1							EQU			$0200
match_ADDQ_reg2							EQU			$0400
match_ADDQ_reg3							EQU			$0600
match_ADDQ_reg4							EQU			$0800
match_ADDQ_reg5							EQU			$0A00
match_ADDQ_reg6							EQU			$0C00
match_ADDQ_reg7							EQU			$0E00







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
