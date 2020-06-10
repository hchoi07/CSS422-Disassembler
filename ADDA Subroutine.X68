*-----------------------------------------------------------
* Title      :ADDA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matchs of the dettermined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------    
   
ADDA_sub                                                 ;preserve the registers, 
                                 AND.L             #mask_ADDA_ea_mode,D1                         ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
ADDA_data_reg_dir                CMP.L             #match_ADDA_Dn,D1                             ;check to see if mode is data reg direct
                                 BNE               ADDA_add_reg_dir                              ;if not, go check add reg dir
                                 BEQ               ADDA_Dn_reg                                   ;if equal go figure out the register

ADDA_add_reg_dir                 CMP.L             #match_ADDA_An,D1                             ;check if mode is add reg direct
                                 BNE               ADDA_add_reg_indir                            ;if not, go check add reg indir
                                 BEQ               ADDA_An_reg                                   ;if equal go figure out the reg
 
ADDA_add_reg_indir               CMP.L             #match_ADDA_An_indir,D1                       ;check to see if mode is add reg indir
                                 BNE               ADDA_add_reg_indir_predec                     ;if not, go check add reg indir predec 
                                 BEQ               ADDA_An_indir_reg                             ;if equal go figure out the register           
           
ADDA_add_reg_indir_predec        CMP.L             #match_ADDA_An_indir_predec,D1                ;check to see if mode is add reg indor w/ postinc
                                 BNE               ADDA_add_reg_indir_postinc                    ;if not go check add reg indir/predec
                                 BEQ               ADDA_An_indir_predec                          ;if equal go figure out the register
                      
ADDA_add_reg_indir_postinc       CMP.L             #match_ADDA_An_indir_postinc,D1               ;check to see if mode is add reg indir w/predec
                                 BNE               ADDA_abs_add_word                             ;if not go check abs add word
                                 BEQ               ADDA_An_indir_postinc_reg                     ;if equal go figure out the register

ADDA_abs_add_word                AND.L             #mask_ADDA_abs_add,D2                         ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_ADDA_abs_add_word,D2                   ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               ADDA_abs_add_long                             ;if not go check abs add long
                                 BEQ               ADDA_abs_add_word_out                         ;if equal go to output
  
ADDA_abs_add_long                CMP.L             #match_ADDA_abs_add_long,D2                   ;check to see if abs add long
                                 BEQ               ADDA_abs_add_long_out                         ;if equal go to output
                                 
ADDA_immediate_add               CMP.L             #match_ADDA_imm_add,D1                             ;check if immediate address
                                 BEQ               ADDA_immediate_add_out                        ;if equal go to immediate add sub routine
				                 BNE               ERROR                                         ;if not equal go to error mesage sub routine


;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                 
;-----------------------------------Data Register Direct--------------------------------
ADDA_Dn_reg                      AND.L              #mask_ADDA_ea_reg_and_mode,D2                ;load the mask into D2 for the mode and the register
                                 CMP.L              #match_ADDA_D0,D2                            ;check to see in the register is 0
                                 BNE                ADDA_rD1                                     ;if not go check register 1
                                 BEQ                ADDA_D0_out                                  ;if equal go to output subroutine

ADDA_rD1                         CMP.L              #match_ADDA_D1,D2                            ;check to see in the register is 1
                                 BNE                ADDA_rD2                                     ;if not go check register 2
                                 BEQ                ADDA_D1_out                                  ;if equal go to output subroutine

ADDA_rD2                         CMP.L              #match_ADDA_D2,D2                            ;check to see in the register is 2
                                 BNE                ADDA_rD3                                     ;if not go check register 3
                                 BEQ                ADDA_D2_out                                  ;if equal go to output subroutine

ADDA_rD3                         CMP.L              #match_ADDA_D3,D2                            ;check to see in the register is 3
                                 BNE                ADDA_rD4                                     ;if not go check register 4
                                 BEQ                ADDA_D3_out                                  ;if equal go to output subroutine

ADDA_rD4                         CMP.L              #match_ADDA_D4,D2                            ;check to see in the register is 4
                                 BNE                ADDA_rD5                                     ;if not go check register 5
                                 BEQ                ADDA_D4_out                                  ;if equal go to output subroutine

ADDA_rD5                         CMP.L              #match_ADDA_D5,D2                            ;check to see in the register is 5
                                 BNE                ADDA_rD6                                     ;if not go check register 6
                                 BEQ                ADDA_D5_out                                  ;if equal go to output subroutine

ADDA_rD6                         CMP.L              #match_ADDA_D6,D2                            ;check to see in the register is 6
                                 BNE                ADDA_rD7                                     ;if not go check register 7
                                 BEQ                ADDA_D6_out                                  ;if equal go to output subroutine

ADDA_rD7                         CMP.L              #match_ADDA_D7,D2                            ;check to see in the register is 7
                                 BEQ                ADDA_D7_out                                  ;if equal go to output subroutine
                                 BNE                ERROR                                        ;if not equal, got to error message


;--------------------Data Register Direct Output-----------------------
ADDA_D0_out                     MOVE.L              #ea_D0,A1					                 ;load string constant into A1
                                JSR                 ADDA_determine_second_op                                
                                RTS

ADDA_D1_out                     MOVE.L              #ea_D1,A1					                 ;load string constant into A1
                                JSR                 ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS
                                
ADDA_D2_out                     MOVE.L              #ea_D2,A1					                 ;load string constant into A1
                                JSR                 ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS
                                
ADDA_D3_out                     MOVE.L	 	        #ea_D3,A1					                 ;load string constant into A1
                                JSR                 ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS
                                
ADDA_D4_out                     MOVE.L		        #ea_D4,A1				       	             ;load string constant into A1
                                JSR                 ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS
                                
ADDA_D5_out                     MOVE.L	   	        #ea_D5,A1					                 ;load string constant into A1
                                JSR            	    ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS

ADDA_D6_out                     MOVE.L		        #ea_D6,A1		            			 ;load string constant into A1
                                JSR                 ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS
                                
ADDA_D7_out                     MOVE.L		        #ea_D7,A1					                 ;load string constant into A1
                                JSR                 ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                RTS
                                
;------------------Address Register Direct-----------------------
ADDA_An_reg                      CMP.L           #match_ADDA_A0,D2                               ;check reg is equal to 0
                                 BNE             ADDA_rA1                                        ;if not try reg 1
                                 BEQ             ADDA_An_indir_reg0_out                          ;if equal go to output subroutine

ADDA_rA1                         CMP.L           #match_ADDA_A1,D2                               ;check reg is equal to 1
                                 BNE             ADDA_rA2                                        ;if not try reg 2
                                 BEQ             ADDA_An_indir_reg1_out                          ;if equal go to output subroutine

ADDA_rA2                         CMP.L           #match_ADDA_A2,D2                               ;check reg is equal to 2
                                 BNE             ADDA_rA3                                        ;if not try reg 3
                                 BEQ             ADDA_An_indir_reg2_out                          ;if equal go to output subroutine

ADDA_rA3                         CMP.L           #match_ADDA_A3,D2                               ;check reg is equal to 3
                                 BNE             ADDA_rA4                                        ;if not try reg 4
                                 BEQ             ADDA_An_indir_reg3_out                          ;if equal go to output subroutine

ADDA_rA4                         CMP.L           #match_ADDA_A4,D2                               ;check reg is equal to 4
                                 BNE             ADDA_rA5                                        ;if not try reg 5
                                 BEQ             ADDA_An_indir_reg4_out                          ;if equal go to output subroutine
            
ADDA_rA5                         CMP.L           #match_ADDA_A5,D2                               ;check reg is equal to 5
                                 BNE             ADDA_rA6                                        ;if not try reg 6
                                 BEQ             ADDA_An_indir_reg5_out                          ;if equal go to output subroutine

ADDA_rA6                         CMP.L           #match_ADDA_A6,D2                               ;check reg is equal to 6
                                 BNE             ADDA_rA7                                        ;if not try reg 7
                                 BEQ             ADDA_An_indir_reg6_out                          ;if equal go to output subroutine

ADDA_rA7                         CMP.L           #match_ADDA_A7,D2                               ;check reg is equal to 7
                                 BEQ             ADDA_An_indir_reg7_out                          ;if equal go to output subroutine
                                 BNE             ERROR                                           ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Direct Output-----------------------
ADDA_A0_out                      MOVE.L		         #ea_A0,A1					                     ;load string constant into A1
                                 JSR                ADDA_determine_second_op                         ;jump to subroutine to determine second operand
                                 RTS        						
                                 
ADDA_A1_out                      MOVE.L	            #ea_A1,A1					                 ;load string constant into A1
                                 JSR                ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS
        						
ADDA_A2_out                      MOVE.L	 	        #ea_A2,A1					                 ;load string constant into A1
                                 JSR                ADDA_determine_second_op                	 ;jump to subroutine to determine second operand
                                 RTS
       						
ADDA_A3_out                      MOVE.L		        #ea_A3,A1					                 ;load string constant into A1
                                 JSR                ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_A4_out                      MOVE.L		        #ea_A4,A1					                 ;load string constant into A1
                                 JSR                ADDA_determine_second_op                 	 ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_A5_out                      MOVE.L		        #ea_A5,A1					                  ;load string constant into A1
                                 JSR                ADDA_determine_second_op                 	 ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_A6_out                      MOVE.L		        #ea_A6,A1					                 ;load string constant into A1
                                 JSR                ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_A7_out                      MOVE.L		        #ea_A7,A1					                 ;load string constant into A1
                                 JSR                ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS

;------------------Address Register Indirect-----------------------
ADDA_An_indir_reg                CMP.L              #match_ADDA_An_indir_r0,D2                   ;check reg is equal to 0
                                 BNE                ADDA_An_indir_reg1                           ;if not try reg 1
                                 BEQ                ADDA_An_indir_reg0_out                       ;if equal go to output subroutine

ADDA_An_indir_reg1               CMP.L              #match_ADDA_An_indir_r1,D2                   ;check reg is equal to 1
                                 BNE                ADDA_An_indir_reg2                           ;if not try reg 2
                                 BEQ                ADDA_An_indir_reg1_out                       ;if equal go to output subroutine

ADDA_An_indir_reg2               CMP.L              #match_ADDA_An_indir_r2,D2                   ;check reg is equal to 2
                                 BNE                ADDA_An_indir_reg3                           ;if not try reg 3
                                 BEQ                ADDA_An_indir_reg2_out                       ;if equal go to output subroutine

ADDA_An_indir_reg3               CMP.L              #match_ADDA_An_indir_r3,D2                   ;check reg is equal to 3
                                 BNE                ADDA_An_indir_reg4                           ;if not try reg 4
                                 BEQ                ADDA_An_indir_reg3_out                       ;if equal go to output subroutine
    
ADDA_An_indir_reg4               CMP.L              #match_ADDA_An_indir_r4,D2                   ;check reg is equal to 4
                                 BNE                ADDA_An_indir_reg5                           ;if not try reg 5
                                 BEQ                ADDA_An_indir_reg4_out                       ;if equal go to output subroutine
        
ADDA_An_indir_reg5               CMP.L              #match_ADDA_An_indir_r5,D2                   ;check reg is equal to 5
                                 BNE                ADDA_An_indir_reg6                           ;if not try reg 6
                                 BEQ                ADDA_An_indir_reg5_out                       ;if equal go to output subroutine

ADDA_An_indir_reg6               CMP.L              #match_ADDA_An_indir_r6,D2                   ;check reg is equal to 6
                                 BNE                ADDA_An_indir_reg7                           ;if not try reg 7
                                 BEQ                ADDA_An_indir_reg6_out                       ;if equal go to output subroutine

ADDA_An_indir_reg7               CMP.L              #match_ADDA_An_indir_r7,D2                   ;check reg is equal to 7
                                 BEQ                ADDA_An_indir_reg7_out                       ;if equal go to output subroutine
                                 BNE                ERROR                                        ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Indirect Output-----------------------
ADDA_An_indir_reg0_out		     MOVE.L		    #ea_indir_A0,A1		    	                ;load string constant into A1
                                 JSR            ADDA_determine_second_op                    ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_An_indir_reg1_out	         MOVE.L		    #ea_indir_A1,A1		    		            ;load string constant into A1
                                 JSR            ADDA_determine_second_op                    ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_An_indir_reg2_out	         MOVE.L		    #ea_indir_A2,A1		    	                 ;load string constant into A1
                                 JSR            ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_An_indir_reg3_out		     MOVE.L		    #ea_indir_A3,A1		    		             ;load string constant into A1
                                 JSR            ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_An_indir_reg4_out		     MOVE.L		    #ea_indir_A4,A1		            		   ;load string constant into A1
                                 JSR            ADDA_determine_second_op                     ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_An_indir_reg5_out	         MOVE.L		    #ea_indir_A5,A1         	    		    ;load string constant into A1
                                 JSR            ADDA_determine_second_op                      ;jump to subroutine to determine second operand
                                 RTS
                                
ADDA_An_indir_reg6_out		     MOVE.L		    #ea_indir_A6,A1		            		    ;load string constant into A1
                                 JSR            ADDA_determine_second_op                      ;jump to subroutine to determine second operand
                                 RTS
								        
ADDA_An_indir_reg7_out	         MOVE.L		    #ea_indir_A7,A1          	    		    ;load string constant into A1
                                 JSR            ADDA_determine_second_op                      ;jump to subroutine to determine second operand
                                 RTS

;------------------Address Register Indirect with Post Increment-----------------------
ADDA_An_indir_postinc_reg        CMP.L              #match_ADDA_An_indir_postinc_reg0,D2         ;check reg is equal to 0
                                 BNE                ADDA_An_indir_postinc_reg1                   ;if not try reg 1
                                 BEQ                ADDA_An_indir_postinc_reg0_out               ;if equal go to output subroutine

ADDA_An_indir_postinc_reg1       CMP.L              #match_ADDA_An_indir_postinc_reg1,D2         ;check reg is equal to 1
                                 BNE       	    ADDA_An_indir_postinc_reg2                   ;if not try reg 2
                                 BEQ      	    ADDA_An_indir_postinc_reg1_out               ;if equal go to output subroutine

ADDA_An_indir_postinc_reg2       CMP.L     	    #match_ADDA_An_indir_postinc_reg2,D2         ;check reg is equal to 2
                                 BNE       	    ADDA_An_indir_postinc_reg3                   ;if not try reg 3
                                 BEQ      	    ADDA_An_indir_postinc_reg2_out               ;if equal go to output subroutine

ADDA_An_indir_postinc_reg3       CMP.L     	    #match_ADDA_An_indir_postinc_reg3,D2         ;check reg is equal to 3
                                 BNE       	    ADDA_An_indir_postinc_reg4                   ;if not try reg 4
                                 BEQ       	    ADDA_An_indir_postinc_reg3_out               ;if equal go to output subroutine
 
ADDA_An_indir_postinc_reg4       CMP.L     	    #match_ADDA_An_indir_postinc_reg4,D2         ;check reg is equal to 4
                                 BNE       	    ADDA_An_indir_postinc_reg5                   ;if not try reg 5
                                 BEQ       	    ADDA_An_indir_postinc_reg4_out               ;if equal go to output subroutine

ADDA_An_indir_postinc_reg5       CMP.L     	    #match_ADDA_An_indir_postinc_reg5,D2         ;check reg is equal to 5
                                 BNE       	    ADDA_An_indir_postinc_reg6                   ;if not try reg 6
                                 BEQ       	    ADDA_An_indir_postinc_reg5_out               ;if equal go to output subroutine

ADDA_An_indir_postinc_reg6       CMP.L     	    #match_ADDA_An_indir_postinc_reg6,D2         ;check reg is equal to 6
                                 BNE       	    ADDA_An_indir_postinc_reg7                   ;if not try reg 7
                                 BEQ       	    ADDA_An_indir_postinc_reg6_out               ;if equal go to output subroutine

ADDA_An_indir_postinc_reg7       CMP.L     	    #match_ADDA_An_indir_postinc_reg7,D2         ;check reg is equal to 7
                                 BEQ       	    ADDA_An_indir_postinc_reg7_out               ;if equal go to output subroutine
                                 BNE        	    ERROR                                        ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Indirect with Post Increment Output-----------------------
ADDA_An_indir_postinc_reg0_out	      MOVE.L		    #ea_indir_postinc_A0,A1		         ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg1_out	      MOVE.L		    #ea_indir_postinc_A1,A1		    	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg2_out	      MOVE.L		    #ea_indir_postinc_A2,A1		    	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg3_out	      MOVE.L		    #ea_indir_postinc_A3,A1		    	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg4_out	      MOVE.L		    #ea_indir_postinc_A4,A1		 	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg5_out	      MOVE.L		    #ea_indir_postinc_A5,A1		    	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg6_out	      MOVE.L		    #ea_indir_postinc_A6,A1		    	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_postinc_reg7_out	      MOVE.L		    #ea_indir_postinc_A7,A1		    	 ;load string constant into A1
                                      JSR               ADDA_determine_second_op                 ;jump to subroutine to determine second operand
                                      RTS

;------------------Address Register Indirect with Pre Decrement-----------------------
ADDA_An_indir_predec                  CMP.L             #match_ADDA_An_indir_predec_reg0,D2        ;check reg is equal to 0
                                      BNE               ADDA_An_indir_predec_reg1                  ;if not try reg 1
                                      BEQ               ADDA_An_indir_predec_reg0_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg1             CMP.L             #match_ADDA_An_indir_predec_reg1,D2        ;check reg is equal to 1
                                      BNE               ADDA_An_indir_predec_reg2                  ;if not try reg 2
                                      BEQ               ADDA_An_indir_predec_reg1_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg2             CMP.L             #match_ADDA_An_indir_predec_reg2,D2        ;check reg is equal to 2
                                      BNE               ADDA_An_indir_predec_reg3                  ;if not try reg 3
                                      BEQ               ADDA_An_indir_predec_reg2_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg3             CMP.L             #match_ADDA_An_indir_predec_reg3,D2        ;check reg is equal to 3
                                      BNE               ADDA_An_indir_predec_reg4                  ;if not try reg 4
                                      BEQ               ADDA_An_indir_predec_reg3_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg4             CMP.L             #match_ADDA_An_indir_predec_reg4,D2        ;check reg is equal to 4
                                      BNE               ADDA_An_indir_predec_reg5                  ;if not try reg 5
                                      BEQ               ADDA_An_indir_predec_reg4_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg5             CMP.L             #match_ADDA_An_indir_predec_reg5,D2        ;check reg is equal to 5
                                      BNE               ADDA_An_indir_predec_reg6                  ;if not try reg 6
                                      BEQ               ADDA_An_indir_predec_reg5_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg6             CMP.L             #match_ADDA_An_indir_predec_reg6,D2        ;check reg is equal to 6
                                      BNE               ADDA_An_indir_predec_reg7                  ;if not try reg 7
                                      BEQ               ADDA_An_indir_predec_reg6_out              ;if equal go to output subroutine

ADDA_An_indir_predec_reg7             CMP.L             #match_ADDA_An_indir_predec_reg7,D2        ;check reg is equal to 7
                                      BEQ               ADDA_An_indir_predec_reg7_out              ;if equal go to output subroutine
                                      BNE               ERROR                                      ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Indirect with Pre Decrement Output-----------------------
ADDA_An_indir_predec_reg0_out	      MOVE.L		#ea_indir_predec_A0,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
											
ADDA_An_indir_predec_reg1_out	      MOVE.L		#ea_indir_predec_A1,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_predec_reg2_out	      MOVE.L		#ea_indir_predec_A2,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_predec_reg3_out	      MOVE.L		#ea_indir_predec_A3,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_predec_reg4_out	      MOVE.L		#ea_indir_predec_A4,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_predec_reg5_out         MOVE.L		#ea_indir_predec_A5,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_predec_reg6_out	      MOVE.L		#ea_indir_predec_A6,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS
                                      
ADDA_An_indir_predec_reg7_out	      MOVE.L		#ea_indir_predec_A7,A1			   ;load string constant into A1
                                      JSR               ADDA_determine_second_op                   ;jump to subroutine to determine second operand
                                      RTS        

;------------------Absolute Addressing Output-----------------------
ADDA_abs_add_word_out			         MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         JSR         ADDA_determine_second_op           ;jump to subroutine to determine second operand
                                         RTS                                           

ADDA_abs_add_long_out    		         MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                        ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         JSR         ADDA_determine_second_op           ;jump to subroutine to determine second operand
                                         RTS                                            
;---------------Immediate Addresing---------------------------
ADDA_immediate_add_out                  MOVE.L	     (A0)+,D5                           ;capture the immediate address
					                    CMP.L       #match_ADDA_imm_add_word,D6             ;check to see if need to pull word
                					    MOVE.L      (A0)+,D5                           ;pull the word
                                        BEQ         ADDA_imm_add_w                     ;if equal go pull word    
					                    BNE         ADDA_imm_add_l                     ;if not equal, go check long
										 
ADDA_imm_add_w                           MOVE.L      #ea_$,(A1)+                        ;load the $
                                         MOVE.W      D5,(A1)+                           ;load the word address                           
                                         JSR         ADDA_determine_second_op           ;jump to subroutine to determine second operand
                                         RTS
                                         
ADDA_imm_add_l                           MOVE.L      (A0)+,D5                           ;pull the long and increase the pointer
                                         MOVE.L      #ea_$,(A1)+                        ;load the $
                                         MOVE.L      D5,A1                              ;move to A1
                                         JSR         ADDA_determine_second_op           ;jump to subroutine to determine second operand
                                         RTS                                              
                                              
                                              
;---------------------------------Determine Register----------------------------------------------------------------------------------------
ADDA_determine_second_op		CLR.L		D2				            ;clear D2 
					            AND.L		#mask_ADDA_An_reg,D2		;load the mask for the register into D2, masks bit 11-9
												
ADDA_reg0				        CMP.L		#match_ADDA_reg0,D2		;check to see if reg equal 0
					            BNE		    ADDA_reg1			    ;if not equal got check reg 1
					            BEQ		    ADDA_reg0_out			;if equal go to output
												
ADDA_reg1				        CMP.L		#match_ADDA_reg1,D2		;check to see if reg equal 1
					            BNE		    ADDA_reg2			    ;if not equal got check reg 2
					            BEQ		    ADDA_reg1_out			;if equal go to output

ADDA_reg2				        CMP.L		#match_ADDA_reg2,D2		;check to see if reg equal 2
					            BNE		    ADDA_reg3			    ;if not equal got check reg 3
					            BEQ 	    ADDA_reg2_out			;if equal go to output

ADDA_reg3       				CMP.L		#match_ADDA_reg3,D2		;check to see if reg equal 3
				            	BNE		    ADDA_reg4			    ;if not equal got check reg 4
					            BEQ		    ADDA_reg3_out			;if equal go to output
												
ADDA_reg4				        CMP.L		#match_ADDA_reg4,D2		;check to see if reg equal 4
					            BNE		    ADDA_reg5			    ;if not equal got check reg 5
					            BEQ		    ADDA_reg4_out			;if equal go to output

ADDA_reg5				        CMP.L		#match_ADDA_reg5,D2		;check to see if reg equal 5
					            BNE		    ADDA_reg6			    ;if not equal got check reg 6
					            BEQ		    ADDA_reg5_out			;if equal go to output

ADDA_reg6				        CMP.L		#match_ADDA_reg6,D2		;check to see if reg equal 6
					            BNE		    ADDA_reg7			    ;if not equal got check reg 7
					            BEQ		    ADDA_reg6_out			;if equal go to output			

ADDA_reg7				        CMP.L		#match_ADDA_reg7,D2		;check to see if reg equal 7
					            BEQ		    ADDA_reg7_out			;if equal go to output
					            BNE         ERROR                           ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
ADDA_reg0_out			        MOVE.L		#ea_A0,A1		        ;load string constant into A1
                                RTS
											
ADDA_reg1_out			        MOVE.L		#ea_A1,A1			;load string constant into A1
                                RTS
                                            
ADDA_reg2_out			        MOVE.L		#ea_A2,A1			;load string constant into A1
                                RTS
                                            
ADDA_reg3_out			        MOVE.L		#ea_A3,A1			;load string constant into A1
                                RTS
                                            
ADDA_reg4_out			        MOVE.L		#ea_A4,A1			;load string constant into A1
                                RTS
                                            
ADDA_reg5_out			        MOVE.L		#ea_A5,A1			;load string constant into A1
                                RTS
                                            
ADDA_reg6_out			        MOVE.L		#ea_A6,A1			;load string constant into A1
                                RTS
                                            
ADDA_reg7_out			        MOVE.L		#ea_A7,A1			;load string constant into A1
                                RTS
                                

;----------------------Error Handling----------------------------------------

					                            
					                            



mask_ADDA_ea_mode			    EQU			$0038
mask_ADDA_abs_add			    EQU			$003F
mask_ADDA_ea_reg_and_mode		EQU			$003F
mask_ADDA_An_reg			    EQU			$0E00

match_ADDA_Dn				    EQU			$0000
match_ADDA_An				    EQU			$0008
match_ADDA_An_indir			    EQU			$0010
match_ADDA_An_indir_predec		EQU			$0020
match_ADDA_An_indir_postinc		EQU			$0018
match_ADDA_abs_add_word			EQU			$0038
match_ADDA_abs_add_long			EQU			$0039

match_ADDA_D0				EQU			$0000
match_ADDA_D1				EQU			$0001
match_ADDA_D2				EQU			$0002
match_ADDA_D3				EQU			$0003
match_ADDA_D4				EQU			$0004
match_ADDA_D5				EQU			$0005
match_ADDA_D6				EQU			$0006
match_ADDA_D7				EQU			$0007

match_ADDA_A0				EQU			$0008
match_ADDA_A1				EQU			$0009
match_ADDA_A2				EQU			$000A
match_ADDA_A3				EQU			$000B
match_ADDA_A4				EQU			$000C
match_ADDA_A5				EQU			$000D
match_ADDA_A6				EQU			$000E
match_ADDA_A7				EQU			$000F

match_ADDA_An_indir_r0			EQU			$0010
match_ADDA_An_indir_r1			EQU			$0011
match_ADDA_An_indir_r2			EQU			$0012
match_ADDA_An_indir_r3			EQU			$0013
match_ADDA_An_indir_r4			EQU			$0014
match_ADDA_An_indir_r5			EQU			$0015
match_ADDA_An_indir_r6			EQU			$0016
match_ADDA_An_indir_r7			EQU			$0017

match_ADDA_An_indir_postinc_reg0	EQU			$0018
match_ADDA_An_indir_postinc_reg1	EQU			$0019
match_ADDA_An_indir_postinc_reg2	EQU			$001A
match_ADDA_An_indir_postinc_reg3	EQU			$001B
match_ADDA_An_indir_postinc_reg4	EQU			$001C
match_ADDA_An_indir_postinc_reg5	EQU			$001D
match_ADDA_An_indir_postinc_reg6	EQU			$001E
match_ADDA_An_indir_postinc_reg7	EQU			$001F

match_ADDA_An_indir_predec_reg0		EQU			$0020
match_ADDA_An_indir_predec_reg1		EQU			$0021
match_ADDA_An_indir_predec_reg2		EQU			$0022
match_ADDA_An_indir_predec_reg3		EQU			$0023
match_ADDA_An_indir_predec_reg4		EQU			$0024
match_ADDA_An_indir_predec_reg5		EQU			$0025
match_ADDA_An_indir_predec_reg6		EQU			$0026
match_ADDA_An_indir_predec_reg7		EQU			$0027

match_ADDA_imm_add                      EQU         		$003C
match_ADDA_imm_add_word                 EQU         		$00FC
match_ADDA_imm_add_long                 EQU         		$01FC

match_ADDA_reg0				EQU			$0000
match_ADDA_reg1				EQU			$0200
match_ADDA_reg2				EQU			$0400
match_ADDA_reg3				EQU			$0600
match_ADDA_reg4				EQU			$0800
match_ADDA_reg5				EQU			$0A00
match_ADDA_reg6				EQU			$0C00
match_ADDA_reg7				EQU			$0E00








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
