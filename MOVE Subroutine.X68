*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
  
MOVE_sub                                                       ;preserve the registers, 

*-----------------------------------------------------------------------------------------------------------------------------------
* 
*                                       Determine Source EA                            
*
*------------------------------------------------------------------------------------------------------------------------------------
                                AND.L             #mask_MOVE_src_ea_mode,D1                          ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
MOVE_data_reg_dir               CMP.L             #match_MOVE_src_Dn,D1                              ;check to see if mode is data reg direct
                                 BNE               MOVE_add_reg_indir                             ;if not, go check add reg dir
                                 BEQ               MOVE_Dn_reg                                  ;if equal go figure out the register

MOVE_add_reg_indir              CMP.L             #match_MOVE_src_An_indir,D1                        ;check to see if mode is add reg indir
                                 BNE               MOVE_add_reg_indir_predec                    ;if not, go check add reg indir predec 
                                 BEQ               MOVE_An_indir_reg                            ;if equal go figure out the register           
           
MOVE_add_reg_indir_predec       CMP.L             #match_MOVE_src_An_indir_predec,D1                  ;check to see if mode is add reg indor w/ postinc
                                 BNE               MOVE_add_reg_indir_postinc                    ;if not go check add reg indir/predec
                                 BEQ               MOVE_An_indir_predec                          ;if equal go figure out the register
                      
MOVE_add_reg_indir_postinc      CMP.L             #match_MOVE_src_An_indir_postinc,D1              ;check to see if mode is add reg indir w/predec
                                 BNE               MOVE_abs_add_word                                  ;if not go check abs add word
                                 BEQ               MOVE_An_indir_postinc_reg                          ;if equal go figure out the register

MOVE_abs_add_word               CLR.L               D2
                                MOVE.W              D0,D2
                                AND.L             #mask_MOVE_src_abs_add,D2                        ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_MOVE_src_abs_add_word,D2                  ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               MOVE_abs_add_long                                  ;if not go check abs add long
                                 BEQ               MOVE_abs_add_word_out                              ;if equal go to output
  
MOVE_abs_add_long               CMP.L             #match_MOVE_src_abs_add_long,D2                  ;check to see if abs add long
                                 BEQ               MOVE_abs_add_long_out                              ;if equal go to output
                                 BNE               ERROR                                         ;if not equal go to error mesage MOVE routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                                       ;load the mask into D2 for the mode and the register
;-----------------------------------Data Register Direct--------------------------------
MOVE_Dn_reg                     CLR.L   D2
                                MOVE.W  D0,D2
                                AND.L              #mask_MOVE_src_ea_reg_and_mode,D2 
                                CMP.L              #match_MOVE_src_D0,D2                       ;check to see in the register is 0
                                 BNE                MOVE_rD1                                     ;if not go check register 1
                                 BEQ                MOVE_D0_out                              ;if equal go to output MOVEroutine

MOVE_rD1                        CMP.L              #match_MOVE_src_D1,D2                       ;check to see in the register is 1
                                 BNE                MOVE_rD2                                     ;if not go check register 2
                                 BEQ                MOVE_D1_out                              ;if equal go to output MOVEroutine

MOVE_rD2                        CMP.L              #match_MOVE_src_D2,D2                       ;check to see in the register is 2
                                 BNE                MOVE_rD3                                     ;if not go check register 3
                                 BEQ                MOVE_D2_out                              ;if equal go to output MOVEroutine

MOVE_rD3                        CMP.L              #match_MOVE_src_D3,D2                       ;check to see in the register is 3
                                 BNE                MOVE_rD4                                     ;if not go check register 4
                                 BEQ                MOVE_D3_out                              ;if equal go to output MOVEroutine

MOVE_rD4                        CMP.L              #match_MOVE_src_D4,D2                       ;check to see in the register is 4
                                 BNE                MOVE_rD5                                     ;if not go check register 5
                                 BEQ                MOVE_D4_out                              ;if equal go to output MOVEroutine

MOVE_rD5                        CMP.L              #match_MOVE_src_D5,D2                       ;check to see in the register is 5
                                 BNE                MOVE_rD6                                     ;if not go check register 6
                                 BEQ                MOVE_D5_out                              ;if equal go to output MOVEroutine

MOVE_rD6                        CMP.L              #match_MOVE_src_D6,D2                       ;check to see in the register is 6
                                 BNE                MOVE_rD7                                     ;if not go check register 7
                                 BEQ                MOVE_D6_out                              ;if equal go to output MOVEroutine

MOVE_rD7                        CMP.L              #match_MOVE_src_D7,D2                       ;check to see in the register is 7
                                 BEQ                MOVE_D7_out                              ;if equal go to output MOVEroutine
                                 BNE                ERROR                               ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
MOVE_D0_out                    MOVE.L          #ea_D0,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS
                                
MOVE_D1_out                    MOVE.L          #ea_D1,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS

MOVE_D2_out                    MOVE.L          #ea_D2,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS
                                
MOVE_D3_out                    MOVE.L			#ea_D3,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS

MOVE_D4_out                    MOVE.L			#ea_D4,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS

MOVE_D5_out                    MOVE.L			#ea_D5,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS

MOVE_D6_out                    MOVE.L			#ea_D6,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS

MOVE_D7_out                    MOVE.L			#ea_D7,A1							;load string constant into A1
                                JSR             print_first
                                JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                RTS
;------------------Address Register Indirect-----------------------
MOVE_An_indir_reg               CLR.L   D2
                                MOVE.W  D0,D2
                                AND.L              #mask_MOVE_src_ea_reg_and_mode,D2 
                                CMP.L          #match_MOVE_src_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             MOVE_An_indir_reg1                           ;if not try reg 1
                                 BEQ             MOVE_An_indir_reg0_out                       ;if equal go to output MOVEroutine

MOVE_An_indir_reg1              CMP.L           #match_MOVE_src_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             MOVE_An_indir_reg2                           ;if not try reg 2
                                 BEQ             MOVE_An_indir_reg1_out                       ;if equal go to output MOVEroutine

MOVE_An_indir_reg2              CMP.L           #match_MOVE_src_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             MOVE_An_indir_reg3                           ;if not try reg 3
                                 BEQ             MOVE_An_indir_reg2_out                       ;if equal go to output MOVEroutine

MOVE_An_indir_reg3              CMP.L           #match_MOVE_src_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             MOVE_An_indir_reg4                           ;if not try reg 4
                                 BEQ             MOVE_An_indir_reg3_out                       ;if equal go to output MOVEroutine
    
MOVE_An_indir_reg4              CMP.L           #match_MOVE_src_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             MOVE_An_indir_reg5                           ;if not try reg 5
                                 BEQ             MOVE_An_indir_reg4_out                       ;if equal go to output MOVEroutine
        
MOVE_An_indir_reg5              CMP.L           #match_MOVE_src_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             MOVE_An_indir_reg6                           ;if not try reg 6
                                 BEQ             MOVE_An_indir_reg5_out                       ;if equal go to output MOVEroutine

MOVE_An_indir_reg6              CMP.L           #match_MOVE_src_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             MOVE_An_indir_reg7                           ;if not try reg 7
                                 BEQ             MOVE_An_indir_reg6_out                       ;if equal go to output MOVEroutine

MOVE_An_indir_reg7              CMP.L           #match_MOVE_src_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             MOVE_An_indir_reg7_out                       ;if equal go to output MOVEroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
MOVE_An_indir_reg0_out			       MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
                                        
MOVE_An_indir_reg1_out			       MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
                                        
MOVE_An_indir_reg2_out			       MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
                                        
MOVE_An_indir_reg3_out			       MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
                                        
MOVE_An_indir_reg4_out			       MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
                                        
MOVE_An_indir_reg5_out			       MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
                                        
MOVE_An_indir_reg6_out			       MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
								        
MOVE_An_indir_reg7_out			       MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                JSR             print_first
                                        JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                        RTS
;------------------Address Register Indirect with Post Increment-----------------------
MOVE_An_indir_postinc_reg                  CLR.L   D2
                                            MOVE.W  D0,D2
                                            AND.L              #mask_MOVE_src_ea_reg_and_mode,D2 
                                            CMP.L      #match_MOVE_src_An_indir_pinc_r0,D2        ;check reg is equal to 0
                                            BNE        MOVE_An_indir_postinc_reg1                      ;if not try reg 1
                                            BEQ        MOVE_An_indir_postinc_reg0_out               ;if equal go to output MOVEroutine

MOVE_An_indir_postinc_reg1                 CMP.L      #match_MOVE_src_An_indir_pinc_r1,D2        ;check reg is equal to 1
                                            BNE        MOVE_An_indir_postinc_reg2                      ;if not try reg 2
                                            BEQ        MOVE_An_indir_postinc_reg1_out               ;if equal go to output MOVEroutine

MOVE_An_indir_postinc_reg2                 CMP.L      #match_MOVE_src_An_indir_pinc_r2,D2        ;check reg is equal to 2
                                            BNE        MOVE_An_indir_postinc_reg3                      ;if not try reg 3
                                            BEQ        MOVE_An_indir_postinc_reg2_out               ;if equal go to output MOVEroutine

MOVE_An_indir_postinc_reg3                 CMP.L      #match_MOVE_src_An_indir_pinc_r3,D2        ;check reg is equal to 3
                                            BNE        MOVE_An_indir_postinc_reg4                      ;if not try reg 4
                                            BEQ        MOVE_An_indir_postinc_reg3_out               ;if equal go to output MOVEroutine
 
MOVE_An_indir_postinc_reg4                 CMP.L      #match_MOVE_src_An_indir_pinc_r4,D2        ;check reg is equal to 4
                                            BNE        MOVE_An_indir_postinc_reg5                      ;if not try reg 5
                                            BEQ        MOVE_An_indir_postinc_reg4_out               ;if equal go to output MOVEroutine

MOVE_An_indir_postinc_reg5                 CMP.L      #match_MOVE_src_An_indir_pinc_r5,D2        ;check reg is equal to 5
                                            BNE        MOVE_An_indir_postinc_reg6                      ;if not try reg 6
                                            BEQ        MOVE_An_indir_postinc_reg5_out               ;if equal go to output MOVEroutine

MOVE_An_indir_postinc_reg6                 CMP.L      #match_MOVE_src_An_indir_pinc_r6,D2         ;check reg is equal to 6
                                            BNE        MOVE_An_indir_postinc_reg7                        ;if not try reg 7
                                            BEQ        MOVE_An_indir_postinc_reg6_out                    ;if equal go to output MOVEroutine

MOVE_An_indir_postinc_reg7                 CMP.L      #match_MOVE_src_An_indir_pinc_r7,D2         ;check reg is equal to 7
                                            BEQ        MOVE_An_indir_postinc_reg7_out                    ;if equal go to output MOVEroutine
                                            BNE        ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
MOVE_An_indir_postinc_reg0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_postinc_reg7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                JSR             print_first
                                             JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
;------------------Address Register Indirect with Pre Decrement-----------------------
MOVE_An_indir_predec                   	   CLR.L   D2
                                             MOVE.W  D0,D2
                                            AND.L              #mask_MOVE_src_ea_reg_and_mode,D2 
                                            CMP.L      #match_MOVE_src_An_indir_prede_r0,D2       ;check reg is equal to 0
                                            BNE        MOVE_An_indir_predec_reg1                      ;if not try reg 1
                                            BEQ        MOVE_An_indir_predec_reg0_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg1                  CMP.L      #match_MOVE_src_An_indir_prede_r1,D2       ;check reg is equal to 1
                                            BNE        MOVE_An_indir_predec_reg2                      ;if not try reg 2
                                            BEQ        MOVE_An_indir_predec_reg1_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg2                  CMP.L      #match_MOVE_src_An_indir_prede_r2,D2       ;check reg is equal to 2
                                            BNE        MOVE_An_indir_predec_reg3                      ;if not try reg 3
                                            BEQ        MOVE_An_indir_predec_reg2_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg3                  CMP.L      #match_MOVE_src_An_indir_prede_r3,D2       ;check reg is equal to 3
                                            BNE        MOVE_An_indir_predec_reg4                      ;if not try reg 4
                                            BEQ        MOVE_An_indir_predec_reg3_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg4                  CMP.L      #match_MOVE_src_An_indir_prede_r4,D2       ;check reg is equal to 4
                                            BNE        MOVE_An_indir_predec_reg5                      ;if not try reg 5
                                            BEQ        MOVE_An_indir_predec_reg4_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg5                  CMP.L      #match_MOVE_src_An_indir_prede_r5,D2       ;check reg is equal to 5
                                            BNE        MOVE_An_indir_predec_reg6                     ;if not try reg 6
                                            BEQ        MOVE_An_indir_predec_reg5_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg6                  CMP.L      #match_MOVE_src_An_indir_prede_r6,D2       ;check reg is equal to 6
                                            BNE        MOVE_An_indir_predec_reg7                     ;if not try reg 7
                                            BEQ        MOVE_An_indir_predec_reg6_out               ;if equal go to output MOVEroutine

MOVE_An_indir_predec_reg7                  CMP.L      #match_MOVE_src_An_indir_prede_r7,D2       ;check reg is equal to 7
                                            BEQ        MOVE_An_indir_predec_reg7_out               ;if equal go to output MOVEroutine
                                            BNE        ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
MOVE_An_indir_predec_reg0_out			   MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
											
MOVE_An_indir_predec_reg1_out			   MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_predec_reg2_out			   MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_predec_reg3_out			   MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_predec_reg4_out			   MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_predec_reg5_out			   MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_predec_reg6_out			   MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                             RTS
                                             
MOVE_An_indir_predec_reg7_out			   MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                JSR             print_first
                                            JSR             MOVE_determine_second_op                 ;jump to MOVEroutine to determine second operand
                                            RTS
;------------------Absolute Addressing Output-----------------------
MOVE_abs_add_word_out				 MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      RTS                                            :return to MOVEroutine
                                           

MOVE_abs_add_long_out    			 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                      MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                      MOVE.L      D5,(A1)+                           ;load address                  
                                      RTS                                            :return to MOVEroutine                                            

*-----------------------------------------------------------------------------------------------------------------------------------------------
* 
*                                                   Determine Destiation EA
* 
*-----------------------------------------------------------------------------------------------------------------------------------------------
MOVE_determine_second_op                CLR         D1

                                                                  ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
MOVE_dest_data_reg_dir           MOVE.W     D0,D1
                                AND.L             #mask_MOVE_dest_ea_mode,D1  
                                CMP.L             #match_MOVE_dest_Dn,D1                             ;check to see if mode is data reg direct
                                 BNE               MOVE_dest_add_reg_dir                                   ;if not, go check add reg dir
                                 BEQ               MOVE_dest_Dn_reg                                        ;if equal go figure out the register

MOVE_dest_add_reg_dir            CMP.L             #match_MOVE_dest_An,D1                             ;check if mode is add reg direct
                                 BNE               MOVE_dest_add_reg_indir                                 ;if not, go check add reg indir
                                 BEQ               MOVE_dest_An_reg                                        ;if equal go figure out the reg
 
MOVE_dest_add_reg_indir          CMP.L             #match_MOVE_dest_An_indir,D1                       ;check to see if mode is add reg indir
                                 BNE               MOVE_dest_add_reg_indir_predec                          ;if not, go check add reg indir predec 
                                 BEQ               MOVE_dest_An_indir_reg                                  ;if equal go figure out the register           
           
MOVE_dest_add_reg_indir_predec   CMP.L             #match_MOVE_dest_An_indir_predec,D1                ;check to see if mode is add reg indor w/ postinc
                                 BNE               MOVE_dest_add_reg_indir_postinc                         ;if not go check add reg indir/predec
                                 BEQ               MOVE_dest_An_indir_predec                               ;if equal go figure out the register
                      
MOVE_dest_add_reg_indir_postinc  CMP.L             #match_MOVE_dest_An_indir_postinc,D1               ;check to see if mode is add reg indir w/predec
                                 BNE               MOVE_dest_abs_add_word                                  ;if not go check abs add word
                                 BEQ               MOVE_dest_An_indir_pinc_r                          ;if equal go figure out the register

MOVE_dest_abs_add_word           AND.L             #mask_MOVE_dest_abs_add,D2                         ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_MOVE_dest_abs_add_word,D2                   ;check if abs add word
                                 MOVE.L            (A0)+,D5                                      ;pull the next word instruction that holds the address
                                 BNE               MOVE_dest_abs_add_long                                  ;if not go check abs add long
                                 BEQ               MOVE_dest_abs_add_word_out                              ;if equal go to output
  
MOVE_dest_abs_add_long           CMP.L             #match_MOVE_dest_abs_add_long,D2                    ;check to see if abs add long
                                 BEQ               MOVE_dest_abs_add_long_out                               ;if equal go to output
                                 
MOVE_dest_immediate_add          CMP.L             #match_MOVE_dest_imm_add,D1                                ;check if immediate address
                                 BEQ               MOVE_dest_immediate_add_out                                    ;if equal go to immediate add MOVE routine
								 BNE               ERROR                                            ;if not equal go to error mesage MOVE routine

;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                                                     ;load the mask into D2 for the mode and the register
;-----------------------------------Data Register Direct--------------------------------
MOVE_dest_Dn_reg                CLR.L       D2
                                MOVE.W     D0,D2
                                AND.L              #mask_MOVE_dest_ea_reg_and_mode,D2   
                                 CMP.L              #match_MOVE_dest_D0,D2                       ;check to see in the register is 0
                                 BNE                MOVE_dest_rD1                                     ;if not go check register 1
                                 BEQ                MOVE_dest_D0_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD1                    CMP.L              #match_MOVE_dest_D1,D2                       ;check to see in the register is 1
                                 BNE                MOVE_dest_rD2                                     ;if not go check register 2
                                 BEQ                MOVE_dest_D1_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD2                    CMP.L              #match_MOVE_dest_D2,D2                       ;check to see in the register is 2
                                 BNE                MOVE_dest_rD3                                     ;if not go check register 3
                                 BEQ                MOVE_dest_D2_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD3                    CMP.L              #match_MOVE_dest_D3,D2                       ;check to see in the register is 3
                                 BNE                MOVE_dest_rD4                                     ;if not go check register 4
                                 BEQ                MOVE_dest_D3_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD4                    CMP.L              #match_MOVE_dest_D4,D2                       ;check to see in the register is 4
                                 BNE                MOVE_dest_rD5                                     ;if not go check register 5
                                 BEQ                MOVE_dest_D4_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD5                    CMP.L              #match_MOVE_dest_D5,D2                       ;check to see in the register is 5
                                 BNE                MOVE_dest_rD6                                     ;if not go check register 6
                                 BEQ                MOVE_dest_D5_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD6                    CMP.L              #match_MOVE_dest_D6,D2                       ;check to see in the register is 6
                                 BNE                MOVE_dest_rD7                                     ;if not go check register 7
                                 BEQ                MOVE_dest_D6_out                              ;if equal go to output MOVEroutine

MOVE_dest_rD7                    CMP.L              #match_MOVE_dest_D7,D2                       ;check to see in the register is 7
                                 BEQ                MOVE_dest_D7_out                              ;if equal go to output MOVEroutine
                                 BNE                ERROR                               ;if not equal, got to error message
;--------------------Data Register Direct Output-----------------------
MOVE_dest_D0_out                MOVE.L          #ea_D0,A1							;load string constant into A1
                                RTS

MOVE_dest_D1_out                MOVE.L          #ea_D1,A1							;load string constant into A1
                                RTS

MOVE_dest_D2_out                MOVE.L          #ea_D2,A1							;load string constant into A1
                                RTS

MOVE_dest_D3_out                MOVE.L			#ea_D3,A1							;load string constant into A1
                                RTS

MOVE_dest_D4_out                MOVE.L			#ea_D4,A1							;load string constant into A1
                                RTS

MOVE_dest_D5_out                MOVE.L			#ea_D5,A1							;load string constant into A1
                                RTS

MOVE_dest_D6_out                MOVE.L			#ea_D6,A1							;load string constant into A1
                                RTS

MOVE_dest_D7_out                MOVE.L			#ea_D7,A1							;load string constant into A1
                                RTS

;------------------Address Register Direct-----------------------
MOVE_dest_An_reg                CLR.L       D2
                                MOVE.W     D0,D2
                                AND.L              #mask_MOVE_dest_ea_reg_and_mode,D2  
                                CMP.L           #match_MOVE_dest_A0,D2                      ;check reg is equal to 0
                                 BNE             MOVE_dest_rA1                                  ;if not try reg 1
                                 BEQ             MOVE_dest_An_indir_reg0_out                     ;if equal go to output MOVEroutine

MOVE_dest_rA1                     CMP.L           #match_MOVE_dest_A1,D2                      ;check reg is equal to 1
                                 BNE             MOVE_dest_rA2                                  ;if not try reg 2
                                 BEQ             MOVE_dest_An_indir_reg1_out                     ;if equal go to output MOVEroutine

MOVE_dest_rA2                     CMP.L           #match_MOVE_dest_A2,D2                     ;check reg is equal to 2
                                 BNE             MOVE_dest_rA3                                  ;if not try reg 3
                                 BEQ             MOVE_dest_An_indir_reg2_out                     ;if equal go to output MOVEroutine

MOVE_dest_rA3                     CMP.L           #match_MOVE_dest_A3,D2                       ;check reg is equal to 3
                                 BNE             MOVE_dest_rA4                                    ;if not try reg 4
                                 BEQ             MOVE_dest_An_indir_reg3_out                     ;if equal go to output MOVEroutine

MOVE_dest_rA4                     CMP.L           #match_MOVE_dest_A4,D2                       ;check reg is equal to 4
                                 BNE             MOVE_dest_rA5                                    ;if not try reg 5
                                 BEQ             MOVE_dest_An_indir_reg4_out                     ;if equal go to output MOVEroutine
            
MOVE_dest_rA5                     CMP.L           #match_MOVE_dest_A5,D2                      ;check reg is equal to 5
                                 BNE             MOVE_dest_rA6                                  ;if not try reg 6
                                 BEQ             MOVE_dest_An_indir_reg5_out                     ;if equal go to output MOVEroutine

MOVE_dest_rA6                     CMP.L           #match_MOVE_dest_A6,D2                                     ;check reg is equal to 6
                                 BNE             MOVE_dest_rA7                                  ;if not try reg 7
                                 BEQ             MOVE_dest_An_indir_reg6_out                     ;if equal go to output MOVEroutine

MOVE_dest_rA7                     CMP.L           #match_MOVE_dest_A7,D2                      ;check reg is equal to 7
                                 BEQ             MOVE_dest_An_indir_reg7_out                      ;if equal go to output MOVEroutine
                                 BNE             ERROR                                  :if not equal to an addresssing mode, pritn error

;--------------------Address Register Direct Output-----------------------
MOVE_dest_A0_out                 MOVE.L			#ea_A0,A1							;load string constant into A1
                                RTS
        						
MOVE_dest_A1_out                 MOVE.L			#ea_A1,A1							;load string constant into A1
                                RTS
        						
MOVE_dest_A2_out                 MOVE.L			#ea_A2,A1							;load string constant into A1
                                RTS
                                
MOVE_dest_A3_out                 MOVE.L			#ea_A3,A1							;load string constant into A1
                                RTS

MOVE_dest_A4_out                 MOVE.L			#ea_A4,A1							;load string constant into A1
                                RTS

MOVE_dest_A5_out                 MOVE.L			#ea_A5,A1							;load string constant into A1
                                RTS

MOVE_dest_A6_out                 MOVE.L			#ea_A6,A1							;load string constant into A1
                                RTS

MOVE_dest_A7_out                 MOVE.L			#ea_A7,A1							;load string constant into A1
                                RTS

;------------------Address Register Indirect-----------------------
MOVE_dest_An_indir_reg          CLR.L       D2
                                MOVE.W     D0,D2
                                AND.L              #mask_MOVE_dest_ea_reg_and_mode,D2   
                                CMP.L          #match_MOVE_dest_An_indir_r0,D2              ;check reg is equal to 0
                                 BNE             MOVE_dest_An_indir_reg1                           ;if not try reg 1
                                 BEQ             MOVE_dest_An_indir_reg0_out                       ;if equal go to output MOVEroutine

MOVE_dest_An_indir_reg1           CMP.L           #match_MOVE_dest_An_indir_r1,D2              ;check reg is equal to 1
                                 BNE             MOVE_dest_An_indir_reg2                           ;if not try reg 2
                                 BEQ             MOVE_dest_An_indir_reg1_out                       ;if equal go to output MOVEroutine

MOVE_dest_An_indir_reg2           CMP.L           #match_MOVE_dest_An_indir_r2,D2              ;check reg is equal to 2
                                 BNE             MOVE_dest_An_indir_reg3                           ;if not try reg 3
                                 BEQ             MOVE_dest_An_indir_reg2_out                       ;if equal go to output MOVEroutine

MOVE_dest_An_indir_reg3           CMP.L           #match_MOVE_dest_An_indir_r3,D2              ;check reg is equal to 3
                                 BNE             MOVE_dest_An_indir_reg4                           ;if not try reg 4
                                 BEQ             MOVE_dest_An_indir_reg3_out                       ;if equal go to output MOVEroutine
    
MOVE_dest_An_indir_reg4           CMP.L           #match_MOVE_dest_An_indir_r4,D2              ;check reg is equal to 4
                                 BNE             MOVE_dest_An_indir_reg5                           ;if not try reg 5
                                 BEQ             MOVE_dest_An_indir_reg4_out                       ;if equal go to output MOVEroutine
        
MOVE_dest_An_indir_reg5           CMP.L           #match_MOVE_dest_An_indir_r5,D2              ;check reg is equal to 5
                                 BNE             MOVE_dest_An_indir_reg6                           ;if not try reg 6
                                 BEQ             MOVE_dest_An_indir_reg5_out                       ;if equal go to output MOVEroutine

MOVE_dest_An_indir_reg6           CMP.L           #match_MOVE_dest_An_indir_r6,D2              ;check reg is equal to 6
                                 BNE             MOVE_dest_An_indir_reg7                           ;if not try reg 7
                                 BEQ             MOVE_dest_An_indir_reg6_out                       ;if equal go to output MOVEroutine

MOVE_dest_An_indir_reg7           CMP.L           #match_MOVE_dest_An_indir_r7,D2              ;check reg is equal to 7
                                 BEQ             MOVE_dest_An_indir_reg7_out                       ;if equal go to output MOVEroutine
                                 BNE             ERROR                                   :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect Output-----------------------
MOVE_dest_An_indir_reg0_out			            MOVE.L			#ea_indir_A0,A1		    	        ;load string constant into A1
                                                RTS

MOVE_dest_An_indir_reg1_out			            MOVE.L			#ea_indir_A1,A1		    		  ;load string constant into A1
                                                RTS

MOVE_dest_An_indir_reg2_out			            MOVE.L			#ea_indir_A2,A1		    		  ;load string constant into A1
                                                RTS

MOVE_dest_An_indir_reg3_out			            MOVE.L			#ea_indir_A3,A1		    		  ;load string constant into A1
                                                RTS

MOVE_dest_An_indir_reg4_out			            MOVE.L			#ea_indir_A4,A1		    		  ;load string constant into A1
                                                RTS

MOVE_dest_An_indir_reg5_out			            MOVE.L			#ea_indir_A5,A1		    		  ;load string constant into A1
                                                RTS

MOVE_dest_An_indir_reg6_out			            MOVE.L			#ea_indir_A6,A1		    		  ;load string constant into A1
                                                RTS
								        
MOVE_dest_An_indir_reg7_out			            MOVE.L			#ea_indir_A7,A1		    		  ;load string constant into A1
                                                RTS

;------------------Address Register Indirect with Post Increment-----------------------
MOVE_dest_An_indir_pinc_r                   CLR.L       D2
                                             MOVE.W     D0,D2
                                            AND.L              #mask_MOVE_dest_ea_reg_and_mode,D2  
                                            CMP.L      #match_MOVE_dest_An_indir_pinc_r0,D2        ;check reg is equal to 0
                                            BNE        MOVE_dest_An_indir_pinc_r1                      ;if not try reg 1
                                            BEQ        MOVE_dest_An_indir_pinc_r0_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pinc_r1                   CMP.L      #match_MOVE_dest_An_indir_pinc_r1,D2        ;check reg is equal to 1
                                            BNE        MOVE_dest_An_indir_pinc_r2                      ;if not try reg 2
                                            BEQ        MOVE_dest_An_indir_pinc_r1_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pinc_r2                   CMP.L      #match_MOVE_dest_An_indir_pinc_r2,D2        ;check reg is equal to 2
                                            BNE        MOVE_dest_An_indir_pinc_r3                      ;if not try reg 3
                                            BEQ        MOVE_dest_An_indir_pinc_r2_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pinc_r3                   CMP.L      #match_MOVE_dest_An_indir_pinc_r3,D2        ;check reg is equal to 3
                                            BNE        MOVE_dest_An_indir_pinc_r4                      ;if not try reg 4
                                            BEQ        MOVE_dest_An_indir_pinc_r3_out               ;if equal go to output MOVEroutine
 
MOVE_dest_An_indir_pinc_r4                   CMP.L      #match_MOVE_dest_An_indir_pinc_r4,D2        ;check reg is equal to 4
                                            BNE        MOVE_dest_An_indir_pinc_r5                      ;if not try reg 5
                                            BEQ        MOVE_dest_An_indir_pinc_r4_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pinc_r5                   CMP.L      #match_MOVE_dest_An_indir_pinc_r5,D2        ;check reg is equal to 5
                                            BNE        MOVE_dest_An_indir_pinc_r6                      ;if not try reg 6
                                            BEQ        MOVE_dest_An_indir_pinc_r5_out               ;if equal go to output MOVEroutine
    
MOVE_dest_An_indir_pinc_r6                   CMP.L      #match_MOVE_dest_An_indir_pinc_r6,D2         ;check reg is equal to 6
                                            BNE        MOVE_dest_An_indir_pinc_r7                        ;if not try reg 7
                                            BEQ        MOVE_dest_An_indir_pinc_r6_out                    ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pinc_r7                   CMP.L      #match_MOVE_dest_An_indir_pinc_r7,D2         ;check reg is equal to 7
                                            BEQ        MOVE_dest_An_indir_pinc_r7_out                    ;if equal go to output MOVEroutine
                                            BNE        ERROR                                        :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Post Increment Output-----------------------
MOVE_dest_An_indir_pinc_r0_out			    MOVE.L			#ea_indir_postinc_A0,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r1_out			    MOVE.L			#ea_indir_postinc_A1,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r2_out			    MOVE.L			#ea_indir_postinc_A2,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r3_out			    MOVE.L			#ea_indir_postinc_A3,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r4_out			    MOVE.L			#ea_indir_postinc_A4,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r5_out			    MOVE.L			#ea_indir_postinc_A5,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r6_out			    MOVE.L			#ea_indir_postinc_A6,A1		    			      ;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pinc_r7_out			    MOVE.L			#ea_indir_postinc_A7,A1		    			      ;load string constant into A1
                                            RTS

;------------------Address Register Indirect with Pre Decrement-----------------------
MOVE_dest_An_indir_predec                   CLR.L       D2
                                            MOVE.W     D0,D2
                                            AND.L              #mask_MOVE_dest_ea_reg_and_mode,D2  
                                            CMP.L      #match_MOVE_dest_An_indir_pdec_r0,D2       ;check reg is equal to 0
                                            BNE        MOVE_dest_An_indir_pdec_r1                      ;if not try reg 1
                                            BEQ        MOVE_dest_An_indir_pdec_r0_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r1                   CMP.L      #match_MOVE_dest_An_indir_pdec_r1,D2       ;check reg is equal to 1
                                            BNE        MOVE_dest_An_indir_pdec_r2                      ;if not try reg 2
                                            BEQ        MOVE_dest_An_indir_pdec_r1_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r2                   CMP.L      #match_MOVE_dest_An_indir_pdec_r2,D2       ;check reg is equal to 2
                                            BNE        MOVE_dest_An_indir_pdec_r3                      ;if not try reg 3
                                            BEQ        MOVE_dest_An_indir_pdec_r2_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r3                   CMP.L      #match_MOVE_dest_An_indir_pdec_r3,D2       ;check reg is equal to 3
                                            BNE        MOVE_dest_An_indir_pdec_r4                      ;if not try reg 4
                                            BEQ        MOVE_dest_An_indir_pdec_r3_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r4                   CMP.L      #match_MOVE_dest_An_indir_pdec_r4,D2       ;check reg is equal to 4
                                            BNE        MOVE_dest_An_indir_pdec_r5                      ;if not try reg 5
                                            BEQ        MOVE_dest_An_indir_pdec_r4_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r5                   CMP.L      #match_MOVE_dest_An_indir_pdec_r5,D2       ;check reg is equal to 5
                                            BNE        MOVE_dest_An_indir_pdec_r6                     ;if not try reg 6
                                            BEQ        MOVE_dest_An_indir_pdec_r5_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r6                   CMP.L      #match_MOVE_dest_An_indir_pdec_r6,D2       ;check reg is equal to 6
                                            BNE        MOVE_dest_An_indir_pdec_r7                     ;if not try reg 7
                                            BEQ        MOVE_dest_An_indir_pdec_r6_out               ;if equal go to output MOVEroutine

MOVE_dest_An_indir_pdec_r7                   CMP.L      #match_MOVE_dest_An_indir_pdec_r7,D2       ;check reg is equal to 7
                                            BEQ        MOVE_dest_An_indir_pdec_r7_out               ;if equal go to output MOVEroutine
                                            BNE        ERROR                                    :if not equal to an addresssing mode, pritn error

;--------------------Address Register Indirect with Pre Decrement Output-----------------------
MOVE_dest_An_indir_pdec_r0_out		        MOVE.L			#ea_indir_predec_A0,A1					      ;load string constant into A1
                                            RTS
											
MOVE_dest_An_indir_pdec_r1_out		        MOVE.L			#ea_indir_predec_A1,A1						;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pdec_r2_out		        MOVE.L			#ea_indir_predec_A2,A1						;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pdec_r3_out		        MOVE.L			#ea_indir_predec_A3,A1						;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pdec_r4_out		        MOVE.L			#ea_indir_predec_A4,A1						;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pdec_r5_out		        MOVE.L			#ea_indir_predec_A5,A1						;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pdec_r6_out		        MOVE.L			#ea_indir_predec_A6,A1						;load string constant into A1
                                            RTS

MOVE_dest_An_indir_pdec_r7_out		        MOVE.L			#ea_indir_predec_A7,A1						;load string constant into A1
                                            RTS
;------------------Absolute Addressing Output-----------------------
MOVE_dest_abs_add_word_out				 MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to MOVEroutine
                                           

MOVE_dest_abs_add_long_out    			 MOVE.L      (A0)+,D5                           ;pull the next long instruction that holds the address
                                         MOVE.L      #ea_$,(A1)+                         ;load $ for hex and increment A1
                                         MOVE.L      D5,(A1)+                           ;load address                  
                                         RTS                                            :return to MOVEroutine                                            
;---------------Immediate Addresing---------------------------
MOVE_dest_immediate_add_out               MOVE.L		(A0)+,D5                             ;capture the immediate address
										 CMP.L       #match_MOVE_dest_imm_add_word,D6               ;check to see if need to pull word
										 MOVE.L      (A0)+,D5                            ;pull the word
                                         BEQ         MOVE_dest_imm_add_w                           ;if equal go pull word    
										 BNE         MOVE_dest_imm_add_l                           ;if not equal, go check long
										 
MOVE_dest_imm_add_w                       MOVE.L     #ea_$,(A1)+                          ;load the $
                                         MOVE.W     D5,(A1)+                             ;load the word address                           
                                         RTS
                                         
MOVE_dest_imm_add_l                       MOVE.L     (A0)+,D5                             ;pull the long and increase the pointer
                                         MOVE.L     #ea_$,(A1)+                          ;load the $
                                         MOVE.L      D5,A1                               ;move to A1
                                         RTS


*----------------------------------------------------------------------------------------
*                       Source EA Variables
*----------------------------------------------------------------------------------------
mask_MOVE_src_ea_mode			EQU			$0038
mask_MOVE_src_abs_add			EQU			$003F
mask_MOVE_src_ea_reg_and_mode	EQU			$003F


match_MOVE_src_Dn				EQU			$0000
match_MOVE_src_An				EQU			$0008
match_MOVE_src_An_indir			EQU			$0010
match_MOVE_src_An_indir_predec	EQU			$0020
match_MOVE_src_An_indir_postinc	EQU			$0018
match_MOVE_src_abs_add_word		EQU			$0038
match_MOVE_src_abs_add_long		EQU			$0039

match_MOVE_src_D0				EQU			$0000
match_MOVE_src_D1				EQU			$0001
match_MOVE_src_D2				EQU			$0002
match_MOVE_src_D3				EQU			$0003
match_MOVE_src_D4				EQU			$0004
match_MOVE_src_D5				EQU			$0005
match_MOVE_src_D6				EQU			$0006
match_MOVE_src_D7				EQU			$0007

match_MOVE_src_A0				EQU			$0008
match_MOVE_src_A1				EQU			$0009
match_MOVE_src_A2				EQU			$000A
match_MOVE_src_A3				EQU			$000B
match_MOVE_src_A4				EQU			$000C
match_MOVE_src_A5				EQU			$000D
match_MOVE_src_A6				EQU			$000E
match_MOVE_src_A7				EQU			$000F

match_MOVE_src_An_indir_r0		EQU			$0010
match_MOVE_src_An_indir_r1		EQU			$0011
match_MOVE_src_An_indir_r2		EQU			$0012
match_MOVE_src_An_indir_r3		EQU			$0013
match_MOVE_src_An_indir_r4		EQU			$0014
match_MOVE_src_An_indir_r5		EQU			$0015
match_MOVE_src_An_indir_r6		EQU			$0016
match_MOVE_src_An_indir_r7		EQU			$0017

match_MOVE_src_An_indir_pinc_r0		EQU			$0018
match_MOVE_src_An_indir_pinc_r1		EQU			$0019
match_MOVE_src_An_indir_pinc_r2		EQU			$001A
match_MOVE_src_An_indir_pinc_r3		EQU			$001B
match_MOVE_src_An_indir_pinc_r4		EQU			$001C
match_MOVE_src_An_indir_pinc_r5		EQU			$001D
match_MOVE_src_An_indir_pinc_r6		EQU			$001E
match_MOVE_src_An_indir_pinc_r7		EQU			$001F

match_MOVE_src_An_indir_prede_r0			EQU			$0020
match_MOVE_src_An_indir_prede_r1			EQU			$0021
match_MOVE_src_An_indir_prede_r2			EQU			$0022
match_MOVE_src_An_indir_prede_r3			EQU			$0023
match_MOVE_src_An_indir_prede_r4			EQU			$0024
match_MOVE_src_An_indir_prede_r5			EQU			$0025
match_MOVE_src_An_indir_prede_r6			EQU			$0026
match_MOVE_src_An_indir_prede_r7			EQU			$0027

match_MOVE_src_imm_add                           EQU         $003C
match_MOVE_src_imm_add_word                      EQU         $00FC
match_MOVE_src_imm_add_long                      EQU         $01FC



*----------------------------------------------------------------------------------------
*                       Destination EA Variables
*----------------------------------------------------------------------------------------


mask_MOVE_dest_ea_mode			EQU			$01C0
mask_MOVE_dest_abs_add			EQU			$01C0
mask_MOVE_dest_ea_reg_and_mode	EQU			$0FC0


match_MOVE_dest_Dn				EQU			$0000
match_MOVE_dest_An				EQU			$0040
match_MOVE_dest_An_indir			EQU			$0080
match_MOVE_dest_An_indir_predec	EQU			$0100
match_MOVE_dest_An_indir_postinc	EQU			$00C0
match_MOVE_dest_abs_add_word		EQU			$01C0
match_MOVE_dest_abs_add_long		EQU			$09C0

match_MOVE_dest_D0				EQU			$0000
match_MOVE_dest_D1				EQU			$0200
match_MOVE_dest_D2				EQU			$0400
match_MOVE_dest_D3				EQU			$0600
match_MOVE_dest_D4				EQU			$0800
match_MOVE_dest_D5				EQU			$0A00
match_MOVE_dest_D6				EQU			$0C00
match_MOVE_dest_D7				EQU			$0E00

match_MOVE_dest_A0				EQU			$0040
match_MOVE_dest_A1				EQU			$0240
match_MOVE_dest_A2				EQU			$0440
match_MOVE_dest_A3				EQU			$0640
match_MOVE_dest_A4				EQU			$0840
match_MOVE_dest_A5				EQU			$0A40
match_MOVE_dest_A6				EQU			$0C40
match_MOVE_dest_A7				EQU			$0E40

match_MOVE_dest_An_indir_r0		EQU			$0080
match_MOVE_dest_An_indir_r1		EQU			$0280
match_MOVE_dest_An_indir_r2		EQU			$0480
match_MOVE_dest_An_indir_r3		EQU			$0680
match_MOVE_dest_An_indir_r4		EQU			$0880
match_MOVE_dest_An_indir_r5		EQU			$0A80
match_MOVE_dest_An_indir_r6		EQU			$0C80
match_MOVE_dest_An_indir_r7		EQU			$0E80

match_MOVE_dest_An_indir_pinc_r0		EQU			$00C0
match_MOVE_dest_An_indir_pinc_r1		EQU			$02C0
match_MOVE_dest_An_indir_pinc_r2		EQU			$04C0
match_MOVE_dest_An_indir_pinc_r3		EQU			$06C0
match_MOVE_dest_An_indir_pinc_r4		EQU			$08C0
match_MOVE_dest_An_indir_pinc_r5		EQU			$0AC0
match_MOVE_dest_An_indir_pinc_r6		EQU			$0CC0
match_MOVE_dest_An_indir_pinc_r7		EQU			$0EC0

match_MOVE_dest_An_indir_pdec_r0			EQU			$0100
match_MOVE_dest_An_indir_pdec_r1			EQU			$0300
match_MOVE_dest_An_indir_pdec_r2			EQU			$0500
match_MOVE_dest_An_indir_pdec_r3			EQU			$0700
match_MOVE_dest_An_indir_pdec_r4			EQU			$0900
match_MOVE_dest_An_indir_pdec_r5			EQU			$0B00
match_MOVE_dest_An_indir_pdec_r6			EQU			$0D00
match_MOVE_dest_An_indir_pdec_r7			EQU			$0F00

match_MOVE_dest_imm_add                           EQU         $01C0
match_MOVE_dest_imm_add_word                      EQU         $01C0
match_MOVE_dest_imm_add_long                      EQU         $09C0






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
