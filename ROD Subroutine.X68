*-----------------------------------------------------------
* Title      :ROD EA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
* Bits 6&7 will be masked to determine the type of shift
* First bits 6&7 will be masked to determine the shift type
* Then in mem shift subroutine, the EA mode and register are determined
* In Reg shift, bit 5 is masked to determine if the count/reg is either an immediate value or data register
* the count/register is added to the print register (A0)
* after that the data register is decoded and added to the print register
*-----------------------------------------------------------
START               ORG         $1000

ROD_sub                          MOVEM.L           D1-D5/D7/A0-A6, -(A7)                     ;preserve the registers,\ 
                                 
;------------------------Determine Shift Type-----------------------------------------------------------------
ROD_shift_type                   AND.L              #mask_ROD_shift_type,D1                 ;load mask into D1
                                 CMP.L              #match_ROD_mem_shift,D1                 ;check to see if memory shift
                                 BEQ                ROD_mem_shift                               ;if equal go to mem shift subroutine
                                 BNE                ROD_reg_shift                               ;if ROD mem shift, go to reg shift

;--------------Determine EFFECTIVE ADDRESS Mode-------------MEMORY SHIFT-----------------------------------                
ROD_mem_shift                    CLR               D1                                        ;clear shift mask
                                 AND.L             #mask_ROD_ea_mode,D1                      ;move the mask to D1

ROD_An_indir                     CMP.L             #match_ROD_An_indir,D1                    ;check to see if mode is add reg indir
                                 BNE               ROD_An_indir_predec                           ;if ROD, go check add reg indir predec 
                                 BEQ               ROD_An_indir_reg                              ;if equal go figure out the register           
          
ROD_An_indir_postinc             CMP.L             #match_ROD_An_indir_postinc,D1            ;check to see if mode is add reg indor w/ postinc
                                 BNE               ROD_An_indir_predec                           ;if ROD go check add reg indir/predec
                                 BEQ               ROD_An_indir_postinc_reg                      ;if equal go figure out the register
                      
ROD_An_indir_predec              CMP.L             #match_ROD_An_indir_predec,D1             ;check to see if mode is add reg indir w/predec
                                 BNE               ROD_abs_add_word                              ;if ROD go check abs add word
                                 BEQ               ROD_An_indir_predec_reg                       ;if equal go figure out the register

ROD_abs_add_word                 AND.L             #mask_ROD_ea_mode_abs_add,D2              ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_ROD_abs_add_word,D2                ;check if abs add word
                                 MOVE.L            (A0)+,D5                                  ;pull the next word instruction that holds the address 
                                 BNE               ROD_abs_add_long                              ;if ROD go check abs add long
                                 BEQ               ROD_abs_add_word_out                          ;if equal go to output
  
ROD_abs_add_long                 CMP.L             #match_ROD_abs_add_long,D2                ;check to see if abs add long
                                 BEQ               ROD_abs_add_long_out                          ;if equal go to output
								 BNE               ERROR                                     ;if ROD equal to an addresssing mode, pritn error
							 

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
;------------------Address Register Indirect-----------------------
ROD_An_indir_reg                            CLR             D2                                      ;make sure D2 is empty
                                            AND.L           #mask_ROD_ea_reg_and_mode,D2            ;load the mask into D2 for the mode and the register

                                            CMP.L           #match_ROD_An_indir_r0,D2              ;check reg is equal to 0
                                            BNE             ROD_An_indir_reg1                            ;if ROD try reg 1
                                            BEQ             ROD_An_indir_reg0_out                     ;if equal go to output subroutine

ROD_An_indir_reg1                           CMP.L           #match_ROD_An_indir_r1,D2              ;check reg is equal to 1
                                            BNE             ROD_An_indir_reg2                            ;if ROD try reg 2
                                            BEQ             ROD_An_indir_reg1_out                     ;if equal go to output subroutine

ROD_An_indir_reg2                           CMP.L           #match_ROD_An_indir_r2,D2              ;check reg is equal to 2
                                            BNE             ROD_An_indir_reg3                            ;if ROD try reg 3
                                            BEQ             ROD_An_indir_reg2_out                     ;if equal go to output subroutine

ROD_An_indir_reg3                           CMP.L           #match_ROD_An_indir_r3,D2              ;check reg is equal to 3
                                            BNE             ROD_An_indir_reg4                            ;if ROD try reg 4
                                            BEQ             ROD_An_indir_reg3_out                     ;if equal go to output subroutine

ROD_An_indir_reg4                           CMP.L           #match_ROD_An_indir_r4,D2              ;check reg is equal to 4
                                            BNE             ROD_An_indir_reg5                            ;if ROD try reg 5
                                            BEQ             ROD_An_indir_reg4_out                    ;if equal go to output subroutine

ROD_An_indir_reg5                           CMP.L           #match_ROD_An_indir_r5,D2              ;check reg is equal to 5
                                            BNE             ROD_An_indir_reg6                            ;if ROD try reg 6
                                            BEQ             ROD_An_indir_reg5_out                     ;if equal go to output subroutine

ROD_An_indir_reg6                           CMP.L           #match_ROD_An_indir_r6,D2              ;check reg is equal to 6
                                            BEQ             ROD_An_indir_reg6_out                     ;if equal go to output subroutine
                                            BNE             ROD_An_indir_reg7
                                            
ROD_An_indir_reg7                           CMP.L           #match_ROD_An_indir_r6,D2              ;check reg is equal to 6
                                            BEQ             ROD_An_indir_reg7_out                     ;if equal go to output subroutine
                                            BNE             ERROR                                        :if ROD equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
ROD_An_indir_reg0_out		            MOVE.L			#ea_indir_A0,A1							;load string constant into A1
								        RTS												            ;return to subroutine
									
ROD_An_indir_reg1_out		            MOVE.L			#ea_indir_A1,A1							;load string constant into A1
								        RTS												            ;return to subroutine
											
ROD_An_indir_reg2_out	             	MOVE.L			#ea_indir_A2,A1							;load string constant into A1
							        	RTS							        					;return to subroutine

ROD_An_indir_reg3_out	             	MOVE.L			#ea_indir_A3,A1							;load string constant into A1
    					            	RTS									        			;return to subroutine
											
ROD_An_indir_reg4_out	             	MOVE.L			#ea_indir_A4,A1							;load string constant into A1
						        		RTS											            	;return to subroutine
										
ROD_An_indir_reg5_out		            MOVE.L			#ea_indir_A5,A1							;load string constant into A1
								        RTS			        									;return to subroutine

ROD_An_indir_reg6_out    	            MOVE.L			#ea_indir_A6,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

ROD_An_indir_reg7_out    	            MOVE.L			#ea_indir_A7,A1		    			      ;load string constant into A1
								        RTS										            		;return to subroutine

;------------------Address Register Indirect with Post Increment-----------------------
ROD_An_indir_postinc_reg                    CMP.L      #match_ROD_An_indir_postinc_r0,D2        ;check reg is equal to 0

                                            BNE        ROD_An_indir_pinc_r1                      ;if ROD try reg 1
                                            BEQ        ROD_An_indir_pinc_r0_out               ;if equal go to output subroutine

ROD_An_indir_pinc_r1                        CMP.L      #match_ROD_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                            BNE        ROD_An_indir_pinc_r2                      ;if ROD try reg 2
                                            BEQ        ROD_An_indir_pinc_r1_out               ;if equal go to output subroutine

ROD_An_indir_pinc_r2                        CMP.L      #match_ROD_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                            BNE        ROD_An_indir_pinc_r3                      ;if ROD try reg 3
                                            BEQ        ROD_An_indir_pinc_r2_out               ;if equal go to output subroutine
    
ROD_An_indir_pinc_r3                        CMP.L      #match_ROD_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                            BNE        ROD_An_indir_pinc_r4                      ;if ROD try reg 4
                                            BEQ        ROD_An_indir_pinc_r3_out               ;if equal go to output subroutine
 
ROD_An_indir_pinc_r4                        CMP.L      #match_ROD_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                            BNE        ROD_An_indir_pinc_r5                      ;if ROD try reg 5
                                            BEQ        ROD_An_indir_pinc_r4_out               ;if equal go to output subroutine

ROD_An_indir_pinc_r5                        CMP.L      #match_ROD_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                            BNE        ROD_An_indir_pinc_r6                      ;if ROD try reg 6
                                            BEQ        ROD_An_indir_pinc_r5_out               ;if equal go to output subroutine

ROD_An_indir_pinc_r6                        CMP.L      #match_ROD_An_indir_postinc_r6,D2        ;check reg is equal to 6
                                            BEQ        ROD_An_indir_pinc_r6_out              ;if equal go to output subroutine
                                            BNE        ROD_An_indir_pinc_r7

ROD_An_indir_pinc_r7                        CMP.L      #match_ROD_An_indir_postinc_r6,D2        ;check reg is equal to 6
                                            BEQ        ROD_An_indir_pinc_r7_out              ;if equal go to output subroutine
                                            BNE        ERROR                                        :if ROD equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
ROD_An_indir_pinc_r0_out		        	MOVE.L			#ea_indir_postinc_A1,A1							;load string constant into A1
											RTS												;return to subroutine

ROD_An_indir_pinc_r1_out		        	MOVE.L			#ea_indir_postinc_A1,A1							;load string constant into A1
											RTS												;return to subroutine

ROD_An_indir_pinc_r2_out		        	MOVE.L			#ea_indir_postinc_A2,A1							;load string constant into A1
											RTS												;return to subroutine

ROD_An_indir_pinc_r3_out		        	MOVE.L			#ea_indir_postinc_A3,A1							;load string constant into A1
											RTS												;return to subroutine

ROD_An_indir_pinc_r4_out		          	MOVE.L			#ea_indir_postinc_A4,A1							;load string constant into A1
								  			RTS												;return to subroutine

ROD_An_indir_pinc_r5_out			        MOVE.L			#ea_indir_postinc_A5,A1							;load string constant into A1
											RTS												;return to subroutine
 
ROD_An_indir_pinc_r6_out			        MOVE.L			#ea_indir_postinc_A6,A1							;load string constant into A1
											RTS												;return to subroutine

ROD_An_indir_pinc_r7_out			        MOVE.L			#ea_indir_postinc_A7,A1							;load string constant into A1
											RTS												;return to subroutine
													
;------------------Address Register Indirect with Pre Decrement-----------------------
ROD_An_indir_predec_reg                     CMP.L      #match_ROD_An_indir_predec_r0,D2         ;check reg is equal to 0
                                            BNE        ROD_An_indir_pdec_r1                      ;if ROD try reg 1
                                            BEQ        ROD_An_indir_pdec_r0_out               ;if equal go to output subroutine

ROD_An_indir_pdec_r1                         CMP.L      #match_ROD_An_indir_predec_r1,D2         ;check reg is equal to 1
                                            BNE        ROD_An_indir_pdec_r2                      ;if ROD try reg 2
                                            BEQ        ROD_An_indir_pdec_r1_out              ;if equal go to output subroutine

ROD_An_indir_pdec_r2                        CMP.L      #match_ROD_An_indir_predec_r2,D2         ;check reg is equal to 2
                                            BNE        ROD_An_indir_pdec_r3                      ;if ROD try reg 3
                                            BEQ        ROD_An_indir_pdec_r2_out               ;if equal go to output subroutine

ROD_An_indir_pdec_r3                        CMP.L      #match_ROD_An_indir_predec_r3,D2         ;check reg is equal to 3
                                            BNE        ROD_An_indir_pdec_r4                      ;if ROD try reg 4
                                            BEQ        ROD_An_indir_pdec_r5_out               ;if equal go to output subroutine

ROD_An_indir_pdec_r4                        CMP.L      #match_ROD_An_indir_predec_r4,D2         ;check reg is equal to 4
                                            BNE        ROD_An_indir_pdec_r5                      ;if ROD try reg 5
                                            BEQ        ROD_An_indir_pdec_r4_out               ;if equal go to output subroutine

ROD_An_indir_pdec_r5                        CMP.L      #match_ROD_An_indir_predec_r5,D2         ;check reg is equal to 5
                                            BNE        ROD_An_indir_pdec_r6                      ;if ROD try reg 6
                                            BEQ        ROD_An_indir_pdec_r5_out               ;if equal go to output subroutine

ROD_An_indir_pdec_r6                        CMP.L      #match_ROD_An_indir_predec_r6,D2         ;check reg is equal to 6
                                            BEQ        ROD_An_indir_pdec_r6_out               ;if equal go to output subroutine
                                            BNE        ROD_An_indir_pdec_r7
                                            
ROD_An_indir_pdec_r7                        CMP.L      #match_ROD_An_indir_predec_r7,D2         ;check reg is equal to 6
                                            BEQ        ROD_An_indir_pdec_r7_out               ;if equal go to output subroutine
                                            BNE        ERROR                                        :if ROD equal to an addresssing mode, pritn error
;--------------------Address Register Indirect with Pre Decrement Output-----------------------
ROD_An_indir_pdec_r0_out			        MOVE.L			#ea_indir_predec_A0,A1							;load string constant into A1
											RTS														;return to subroutine

ROD_An_indir_pdec_r1_out			        MOVE.L			#ea_indir_predec_A1,A1							;load string constant into A1
											RTS														;return to subroutine
													
ROD_An_indir_pdec_r2_out			        MOVE.L			#ea_indir_predec_A2,A1							;load string constant into A1
											RTS														;return to subroutine

ROD_An_indir_pdec_r3_out			        MOVE.L			#ea_indir_predec_A3,A1							;load string constant into A1
											RTS														;return to subroutine

ROD_An_indir_pdec_r4_out			        MOVE.L			#ea_indir_predec_A4,A1							;load string constant into A1
											RTS														;return to subroutine
	
ROD_An_indir_pdec_r5_out		        	MOVE.L			#ea_indir_predec_A5,A1							;load string constant into A1
											RTS														;return to subroutine
	
ROD_An_indir_pdec_r6_out		        	MOVE.L			#ea_indir_predec_A6,A1							;load string constant into A1
											RTS														;return to subroutine

ROD_An_indir_pdec_r7_out		        	MOVE.L			#ea_indir_predec_A7,A1							;load string constant into A1
											RTS														;return to subroutine
													
;------------------Absolute Addressing Output-----------------------
ROD_abs_add_word_out     				 MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to subroutine
                                           

ROD_abs_add_long_out    				 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to subroutine                                            
;----------------------Error Handling----------------------------------------
ERROR                                    LEA     ERROR_MESSAGE,A1                       ;load error messge into A3
										 RTS                                            ;return to subroutine
												
;-----------------------------------------------------------------Register Shift-----------------------------------------------------------
; determine if the shift is a data register or a immediate value
ROD_reg_shift                       CLR         D1                              ;clear D1
                                    AND.L       #mask_ROD_reg_shift_ir,D1           ;load the mask into D1
                                    CMP.L       #match_ROD_shift_reg,D1             ;check to see if the shift is a data register
									BEQ         ROD_shift_reg                       ;if the shift is a register, go to subroutine
                                    BNE         ROD_count_val			            ;if ROD go to immediate value subroutine

;i/r = 1, the shift is a Data register                                    
; this the subroutine for the data register shift
ROD_shift_reg                       CLR         D1                              ;clear D1
                                    AND.L       #mask_ROD_reg_shift,D1              ;load mask into D1 for bits 11-9

ROD_count_reg0                      CMP.L       #match_ROD_count_reg0,D1            ;check to see if count/shift = 0
                                    BNE         ROD_count_reg1                    ;if ROD go check 1
                                    BEQ         ROD_count_reg0_out                ;got to output
                                    
ROD_count_reg1                      CMP.L       #match_ROD_count_reg1,D1            ;check to see if count/shift = 1
                                    BNE         ROD_count_reg2                    ;if ROD go check 2
                                    BEQ         ROD_count_reg1_out                ;got to output

ROD_count_reg2                      CMP.L       #match_ROD_count_reg2,D1            ;check to see if count/shift = 2
                                    BNE         ROD_count_reg3                    ;if ROD go check 3
                                    BEQ         ROD_count_reg2_out                ;got to output

ROD_count_reg3                      CMP.L       #match_ROD_count_reg3,D1            ;check to see if count/shift = 3
                                    BNE         ROD_count_reg4                    ;if ROD go check 4
                                    BEQ         ROD_count_reg3_out                ;got to output

ROD_count_reg4                      CMP.L       #match_ROD_count_reg4,D1            ;check to see if count/shift = 4
                                    BNE         ROD_count_reg5                    ;if ROD go check 5
                                    BEQ         ROD_count_reg4_out                ;got to output

ROD_count_reg5                      CMP.L       #match_ROD_count_reg5,D1            ;check to see if count/shift = 5
                                    BNE         ROD_count_reg6                      ;if ROD go check 6
                                    BEQ         ROD_count_reg5_out                  ;got to output

ROD_count_reg6                      CMP.L       #match_ROD_count_reg6,D1            ;check to see if count/shift = 6
                                    BNE         ROD_count_reg7                      ;if ROD go check 7
                                    BEQ         ROD_count_reg6_out                  ;got to output

ROD_count_reg7                      CMP.L       #match_ROD_count_reg7,D1            ;check to see if count/shift = 7
                                    BNE         ERROR                           ; if none of the registers, then print error message
                                    BEQ         ROD_count_reg7_out                  ;got to output



;i/r = 0, the shift is an immediate value
;1-7 = 1-7
;0 = 8
; this is the subroutine for the immedite value shift
ROD_count_val                       CMP.L       #match_ROD_count_val0,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val1                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val0_out                ;if 0 got to output

ROD_count_val1                      CMP.L       #match_ROD_count_val1,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val2                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val1_out                ;if 0 got to output

ROD_count_val2                      CMP.L       #match_ROD_count_val2,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val3                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val2_out                ;if 0 got to output

ROD_count_val3                      CMP.L       #match_ROD_count_val3,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val4                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val3_out                ;if 0 got to output

ROD_count_val4                      CMP.L       #match_ROD_count_val4,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val5                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val4_out                ;if 0 got to output

ROD_count_val5                      CMP.L       #match_ROD_count_val5,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val6                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val5_out                ;if 0 got to output

ROD_count_val6                      CMP.L       #match_ROD_count_val6,D1          ;check to see if shift count is 0
                                    BNE         ROD_count_val7                    ;if ROD 0 check 1
                                    BEQ         ROD_count_val6_out                ;if 0 got to output

ROD_count_val7                      CMP.L       #match_ROD_count_val7,D1          ;check to see if shift count is 0
                                    BNE         ERROR                           ;if none of the registers, invlid EA mode
                                    BEQ         ROD_count_val7_out                ;if 0 got to output

;-----------------------------------Count Shift Immedite Value Output---------------------------
ROD_count_val0_out            MOVE.L			#ea_val0,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_val1_out            MOVE.L			#ea_val1,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

ROD_count_val2_out            MOVE.L			#ea_val2,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

ROD_count_val3_out            MOVE.L			#ea_val3,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

ROD_count_val4_out            MOVE.L			#ea_val4,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

ROD_count_val5_out            MOVE.L			#ea_val5,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

ROD_count_val6_out            MOVE.L			#ea_val6,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

ROD_count_val7_out            MOVE.L			#ea_val7,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand

;-------------------------Count Shift Output (Dn)-----------------------------------------
ROD_count_reg0_out            MOVE.L			#ea_D0,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg1_out            MOVE.L			#ea_D1,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg2_out            MOVE.L			#ea_D2,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg3_out            MOVE.L			#ea_D3,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg4_out            MOVE.L			#ea_D4,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg5_out            MOVE.L			#ea_D5,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg6_out            MOVE.L			#ea_D6,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand
						      
ROD_count_reg7_out            MOVE.L			#ea_D7,A1			;load string constant into A1
						      JSR               ROD_Dn0	                ;jump to subroutine to determine the second operand                                    
                                    
                                    
;----------------------------------------------Determine Second Operand Data Register-----------------------------------------------------
ROD_Dn0                         CLR             D1                  ;clear D1
                                AND.L           #mask_ROD_data_reg,D1   ;load data register mask for second operand
                                
                                CMP.L           #match_ROD_D_reg0,D1          ;check if data register is D0
                                BEQ             ROD_D0_out              ;if equal got to output subroutine
                                BNE             ROD_Dn1                 ;if ROD check D1
                                
ROD_Dn1                         CMP.L           #match_ROD_D_reg1,D1          ;check if data register is D0
                                BEQ             ROD_D1_out              ;if equal got to output subroutine
                                BNE             ROD_Dn2                 ;if ROD check D2

ROD_Dn2                         CMP.L           #match_ROD_D_reg2,D1          ;check if data register is D0
                                BEQ             ROD_D2_out              ;if equal got to output subroutine
                                BNE             ROD_Dn3                 ;if ROD check D3

ROD_Dn3                         CMP.L           #match_ROD_D_reg3,D1          ;check if data register is D0
                                BEQ             ROD_D3_out              ;if equal got to output subroutine
                                BNE             ROD_Dn4                 ;if ROD check D4

ROD_Dn4                         CMP.L           #match_ROD_D_reg4,D1          ;check if data register is D0
                                BEQ             ROD_D4_out              ;if equal got to output subroutine
                                BNE             ROD_Dn5                 ;if ROD check D5

ROD_Dn5                         CMP.L           #match_ROD_D_reg5,D1          ;check if data register is D0
                                BEQ             ROD_D5_out              ;if equal got to output subroutine
                                BNE             ROD_Dn6                 ;if ROD check D6

ROD_Dn6                         CMP.L           #match_ROD_D_reg6,D1          ;check if data register is D0
                                BEQ             ROD_D6_out              ;if equal got to output subroutine
                                BNE             ROD_Dn7                 ;if ROD check D7

ROD_Dn7                         CMP.L           #match_ROD_D_reg7,D1          ;check if data register is D0
                                BEQ             ROD_D7_out              ;if equal got to output subroutine
                                BNE             ERROR               :if none of the registers go to error sub routine
                                
                                
;-------------------------------Dn Second Operand Output-----------------------------------------------------------------
ROD_D0_out                    MOVE.L			#ea_D0,A1			;load string constant into A1
					          RTS	                                ;return to subroutine


ROD_D1_out                    MOVE.L			#ea_D1,A1			;load string constant into A1
					          RTS	                                ;return to subroutine


ROD_D2_out                    MOVE.L			#ea_D2,A1			;load string constant into A1
					          RTS	                                ;return to subroutine

            
ROD_D3_out                    MOVE.L			#ea_D3,A1			;load string constant into A1
					          RTS	                                ;return to subroutine


ROD_D4_out                    MOVE.L			#ea_D4,A1			;load string constant into A1
			    	          RTS	                                ;return to subroutine


ROD_D5_out                    MOVE.L			#ea_D5,A1			;load string constant into A1
					          RTS	                                ;return to subroutine


ROD_D6_out                    MOVE.L			#ea_D6,A1			;load string constant into A1
					          RTS	                                ;return to subroutine


ROD_D7_out                    MOVE.L			#ea_D7,A1			;load string constant into A1
					          RTS	                                ;return to subroutine


*----------------------------------------------------------------------------------------------------------------------------
*                               Variables
* 
*----------------------------------------------------------------------------------------------------------------------------
                                    
ERROR_MESSAGE                               DC.B            'Incorrect EA Format',0
mask_ROD_shift_type                         EQU             $00C0              ;masks bits 6&7 to determine if mem shift or reg shift
mask_ROD_ea_mode							EQU				$0038              ;masks bits 5-3 to determine ea mode
mask_ROD_ea_reg_and_mode					EQU				$003F              ;masks bits 5-0 to determine the register with the given mode
mask_ROD_ea_mode_abs_add					EQU				$003F              ;masks ea absolute addressing mode 
mask_ROD_reg_shift_ir                           EQU             $0020              ;masks bit 5 to determine if the shift is immediate value or register
mask_ROD_count_shift                            EQU             $0E00              ;masks bits 11-9 to determine data register or immediate value
mask_ROD_reg_shift                              EQU             $0020              ;mask to determine if reg shift or value shift
mask_ROD_data_reg                               EQU             $0007              ;masks bits 2-0 to determine the data register in the second operand

match_ROD_D_reg0                                EQU             $0000               ;match for second operand data register 0
match_ROD_D_reg1                                EQU             $0001               ;match for second operand data register 1
match_ROD_D_reg2                                EQU             $0002               ;match for second operand data register 2
match_ROD_D_reg3                                EQU             $0003               ;match for second operand data register 3
match_ROD_D_reg4                                EQU             $0004               ;match for second operand data register 4
match_ROD_D_reg5                                EQU             $0005               ;match for second operand data register 5
match_ROD_D_reg6                                EQU             $0006               ;match for second operand data register 6
match_ROD_D_reg7                                EQU             $0007               ;match for second operand data register 7

match_ROD_count_reg0                            EQU             $0000               ;match for bits 11-9 output D0
match_ROD_count_reg1                            EQU             $0200               ;match for bits 11-9 output D1
match_ROD_count_reg2                            EQU             $0400               ;match for bits 11-9 output D2
match_ROD_count_reg3                            EQU             $0600               ;match for bits 11-9 output D3
match_ROD_count_reg4                            EQU             $0800               ;match for bits 11-9 output D4
match_ROD_count_reg5                            EQU             $0A00               ;match for bits 11-9 output D5
match_ROD_count_reg6                            EQU             $0C00               ;match for bits 11-9 output D6
match_ROD_count_reg7                            EQU             $0E00               ;match for bits 11-9 output D7

match_ROD_shift_reg                             EQU             $0020               ;match to for a register shift
match_ROD_count_val0                            EQU             $0000               ;match for shift reg 0
match_ROD_count_val1                           EQU             $0200               ;match for shift reg 1
match_ROD_count_val2                            EQU             $0400               ;match for shift reg 2
match_ROD_count_val3                            EQU             $0600               ;match for shift reg 3
match_ROD_count_val4                            EQU             $0800               ;match for shift reg 4
match_ROD_count_val5                            EQU             $0A00               ;match for shift reg 5
match_ROD_count_val6                            EQU             $0C00               ;match for shift reg 6
match_ROD_count_val7                            EQU             $0E00               ;match for shift reg 7

match_ROD_shift_count                           EQU             $0020
match_ROD_mem_shift                         EQU             $00C0              ;match for memory shift
match_ROD_An_indir							EQU				$0010              ;match for add reg indir
match_ROD_An_indir_postinc			      	EQU				$0020              ;match for add reg indir with postinc
match_ROD_An_indir_predec				    EQU				$0018              ;match for add reg indir with predec
match_ROD_abs_add_word						EQU				$0039      		   ;match for word abs add 
match_ROD_abs_add_long						EQU				$003C              ;match for long abs add


match_ROD_An_indir_r0				        EQU				$0010              ;match for add reg indir with add reg 0
match_ROD_An_indir_r1			        	EQU				$0011              ;match for add reg indir with add reg 1
match_ROD_An_indir_r2			        	EQU				$0012              ;match for add reg indir with add reg 2
match_ROD_An_indir_r3			        	EQU				$0013              ;match for add reg indir with add reg 3
match_ROD_An_indir_r4		        		EQU				$0014              ;match for add reg indir with add reg 4
match_ROD_An_indir_r5		        		EQU				$0015              ;match for add reg indir with add reg 5
match_ROD_An_indir_r6			        	EQU				$0016              ;match for add reg indir with add reg 6
match_ROD_An_indir_r7			        	EQU				$0017              ;match for add reg indir with add reg 7


match_ROD_An_indir_postinc_r0	        	EQU				$0020              ;match for add reg indir with postinc with add reg 0
match_ROD_An_indir_postinc_r1	        	EQU				$0021              ;match for add reg indir with postinc with add reg 1
match_ROD_An_indir_postinc_r2	        	EQU				$0022              ;match for add reg indir with postinc with add reg 2
match_ROD_An_indir_postinc_r3	        	EQU				$0023              ;match for add reg indir with postinc with add reg 3
match_ROD_An_indir_postinc_r4	        	EQU				$0024              ;match for add reg indir with postinc with add reg 4
match_ROD_An_indir_postinc_r5	        	EQU				$0025              ;match for add reg indir with postinc with add reg 5
match_ROD_An_indir_postinc_r6	        	EQU				$0026              ;match for add reg indir with postinc with add reg 6
match_ROD_An_indir_postinc_r7	        	EQU				$0027              ;match for add reg indir with postinc with add reg 7

match_ROD_An_indir_predec_r0		       	EQU				$0018              ;match for add reg indir with predec with add reg 0
match_ROD_An_indir_predec_r1		       	EQU				$0019              ;match for add reg indir with predec with add reg 1
match_ROD_An_indir_predec_r2		    	EQU				$001A              ;match for add reg indir with predec with add reg 2
match_ROD_An_indir_predec_r3		    	EQU				$001B              ;match for add reg indir with predec with add reg 3
match_ROD_An_indir_predec_r4		    	EQU				$001C              ;match for add reg indir with predec with add reg 4
match_ROD_An_indir_predec_r5	    		EQU				$001D              ;match for add reg indir with predec with add reg 5
match_ROD_An_indir_predec_r6		    	EQU				$001E              ;match for add reg indir with predec with add reg 6
match_ROD_An_indir_predec_r7		    	EQU				$001F              ;match for add reg indir with predec with add reg 7

ea_D0				    	DC.B		'D0',0
ea_D1			    		DC.B		'D1',0
ea_D2			    		DC.B		'D2',0
ea_D3				    	DC.B		'D3',0
ea_D4			    		DC.B		'D4',0
ea_D5			    		DC.B		'D5',0
ea_D6				    	DC.B		'D6',0
ea_D7			   	    	DC.B		'D7',0

ea_val0                     DC.B        '8',0
ea_val1                     DC.B        '1',0
ea_val2                     DC.B        '2',0
ea_val3                     DC.B        '3',0
ea_val4                     DC.B        '4',0
ea_val5                     DC.B        '5',0
ea_val6                     DC.B        '6',0
ea_val7                     DC.B        '7',0

ea_indir_A0		    		DC.B		'(A0)',0
ea_indir_A1		    		DC.B		'(A1)',0
ea_indir_A2		    		DC.B		'(A2)',0
ea_indir_A3		    		DC.B		'(A3)',0
ea_indir_A4			    	DC.B		'(A4)',0
ea_indir_A5			    	DC.B		'(A5)',0
ea_indir_A6			    	DC.B		'(A6)',0
ea_indir_A7			    	DC.B		'(A7)',0


ea_indir_postinc_A0			DC.B		'(A0)+',0
ea_indir_postinc_A1			DC.B		'(A1)+',0
ea_indir_postinc_A2			DC.B		'(A2)+',0
ea_indir_postinc_A3			DC.B		'(A3)+',0
ea_indir_postinc_A4			DC.B		'(A4)+',0
ea_indir_postinc_A5			DC.B		'(A5)+',0
ea_indir_postinc_A6			DC.B		'(A6)+',0
ea_indir_postinc_A7			DC.B		'(A7)+',0


ea_indir_predec_A0			DC.B		'-(A0)',0
ea_indir_predec_A1			DC.B		'-(A1)',0
ea_indir_predec_A2			DC.B		'-(A2)',0
ea_indir_predec_A3			DC.B		'-(A3)',0
ea_indir_predec_A4			DC.B		'-(A4)',0
ea_indir_predec_A5			DC.B		'-(A5)',0
ea_indir_predec_A6			DC.B		'-(A6)',0
ea_indir_predec_A7			DC.B		'-(A7)',0

ea_paren_open			    DC.B		'(',0
ea_paren_closed		    	DC.B		')',0
ea_abs_word_string	    	DC.B		'.W',0
ea_abs_long_string	    	DC.B		'.L',0
ea_$				    	DC.B		'$',0

                            END                     START






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
