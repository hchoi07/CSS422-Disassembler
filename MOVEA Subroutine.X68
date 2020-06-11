*-----------------------------------------------------------
* Title      :MOVEA Subroutine
* D0 holds the whole instruction, D6 holds the size
* D1 will be loaded with the mask for the EA mode
* D2 will be loaded with the mask for the EA mode and register to be compared with matches of the determined mode and register
* A1 will point to the location of the string constants
*-----------------------------------------------------------    
   
MOVEA_sub                                         ;preserve the registers, 
                                 CLR                D1
                                 MOVE.W             D0,D1
                                 AND.L             #mask_MOVEA_ea_mode,D1                  ;move the mask to D1
;--------------Determine EFFECTIVE ADDRESS Mode-----------------------------------                
MOVEA_data_reg_dir               CMP.L             #match_MOVEA_Dn,D1                      ;check to see if mode is data reg direct
                                 BNE               MOVEA_add_reg_dir                       ;if not, go check add reg dir
                                 BEQ               MOVEA_Dn_reg                            ;if equal go figure out the register

MOVEA_add_reg_dir                CMP.L             #match_MOVEA_An,D1                      ;check if mode is add reg direct
                                 BNE               MOVEA_add_reg_indir                     ;if not, go check add reg indir
                                 BEQ               MOVEA_An_reg                            ;if equal go figure out the reg
 
MOVEA_add_reg_indir              CMP.L             #match_MOVEA_An_indir,D1                ;check to see if mode is add reg indir
                                 BNE               MOVEA_add_reg_indir_predec              ;if not, go check add reg indir predec 
                                 BEQ               MOVEA_An_indir_reg                      ;if equal go figure out the register           
           
MOVEA_add_reg_indir_predec       CMP.L             #match_MOVEA_An_indir_predec,D1         ;check to see if mode is add reg indor w/ postinc
                                 BNE               MOVEA_add_reg_indir_postinc             ;if not go check add reg indir/predec
                                 BEQ               MOVEA_An_indir_predec                   ;if equal go figure out the register
                      
MOVEA_add_reg_indir_postinc      CMP.L             #match_MOVEA_An_indir_postinc,D1        ;check to see if mode is add reg indir w/predec
                                 BNE               MOVEA_abs_add_word                      ;if not go check abs add word
                                 BEQ               MOVEA_An_indir_postinc_reg              ;if equal go figure out the register

MOVEA_abs_add_word               CLR               D2
                                 MOVE.W            D0,D2
                                 AND.L             #mask_MOVEA_abs_add,D2                  ;load mask to determine if abs add word or long
                                 
                                 CMP.L             #match_MOVEA_abs_add_word,D2            ;check if abs add word
                                 MOVE.L            (A0)+,D5                                ;pull the next word instruction that holds the address
                                 BNE               MOVEA_abs_add_long                      ;if not go check abs add long
                                 BEQ               MOVEA_abs_add_word_out                  ;if equal go to output
  
MOVEA_abs_add_long               CMP.L             #match_MOVEA_abs_add_long,D2            ;check to see if abs add long
                                 BEQ               MOVEA_abs_add_long_out                  ;if equal go to output
                                 
MOVEA_immediate_add              CMP.L             #match_MOVEA_imm_add,D1                       ;check if immediate address
                                 BEQ               MOVEA_immediate_add_out                 ;if equal go to immediate add sub routine
				                 BNE               ERROR                                   ;if not equal go to error mesage sub routine


;--------------------Determine EFFECTIVE ADDRESS Register----------------------------------------------------------------------------------------
                                 
                            
;-----------------------------------Data Register Direct--------------------------------
MOVEA_Dn_reg                CLR.L               D2
                            MOVE.W              D0,D2
                            AND.L              #mask_MOVEA_ea_reg_and_mode,D2     ;load the mask into D2 for the mode and the register
                            CMP.L              #match_MOVEA_D0,D2              ;check to see in the register is 0
                            BNE                MOVEA_rD1                       ;if not go check register 1
                            BEQ                MOVEA_D0_out                    ;if equal go to output subroutine

MOVEA_rD1                   CMP.L              #match_MOVEA_D1,D2              ;check to see in the register is 1
                            BNE                MOVEA_rD2                       ;if not go check register 2
                            BEQ                MOVEA_D1_out                    ;if equal go to output subroutine

MOVEA_rD2                   CMP.L              #match_MOVEA_D2,D2              ;check to see in the register is 2
                            BNE                MOVEA_rD3                       ;if not go check register 3
                            BEQ                MOVEA_D2_out                    ;if equal go to output subroutine

MOVEA_rD3                   CMP.L              #match_MOVEA_D3,D2              ;check to see in the register is 3
                            BNE                MOVEA_rD4                       ;if not go check register 4
                            BEQ                MOVEA_D3_out                    ;if equal go to output subroutine

MOVEA_rD4                   CMP.L              #match_MOVEA_D4,D2              ;check to see in the register is 4
                            BNE                MOVEA_rD5                       ;if not go check register 5
                            BEQ                MOVEA_D4_out                    ;if equal go to output subroutine

MOVEA_rD5                   CMP.L              #match_MOVEA_D5,D2              ;check to see in the register is 5
                            BNE                MOVEA_rD6                       ;if not go check register 6
                            BEQ                MOVEA_D5_out                    ;if equal go to output subroutine

MOVEA_rD6                   CMP.L              #match_MOVEA_D6,D2              ;check to see in the register is 6
                            BNE                MOVEA_rD7                       ;if not go check register 7
                            BEQ                MOVEA_D6_out                    ;if equal go to output subroutine

MOVEA_rD7                   CMP.L              #match_MOVEA_D7,D2              ;check to see in the register is 7
                            BEQ                MOVEA_D7_out                    ;if equal go to output subroutine
                            BNE                ERROR                           ;if not equal, got to error message


;--------------------Data Register Direct Output-----------------------
MOVEA_D0_out                MOVE.L          #ea_D0,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS
                            
MOVEA_D1_out                MOVE.L          #ea_D1,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS

MOVEA_D2_out                MOVE.L          #ea_D2,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS
                            
MOVEA_D3_out                MOVE.L	        #ea_D3,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS

MOVEA_D4_out                MOVE.L	        #ea_D4,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS

MOVEA_D5_out                MOVE.L	        #ea_D5,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS

MOVEA_D6_out                MOVE.L	        #ea_D6,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS

MOVEA_D7_out                MOVE.L	        #ea_D7,A1			      ;load string constant into A1
                            JSR             print_first
                            JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                            RTS

;------------------Address Register Direct-----------------------
MOVEA_An_reg                CLR.L           D2
                            MOVE.W          D0,D2
                            AND.L              #mask_MOVEA_ea_reg_and_mode,D2
                            CMP.L           #match_MOVEA_A0,D2                ;check reg is equal to 0
                            BNE             MOVEA_rA1                         ;if not try reg 1
                            BEQ             MOVEA_An_indir_reg0_out           ;if equal go to output subroutine

MOVEA_rA1                   CMP.L           #match_MOVEA_A1,D2                ;check reg is equal to 1
                            BNE             MOVEA_rA2                         ;if not try reg 2
                            BEQ             MOVEA_An_indir_reg1_out           ;if equal go to output subroutine

MOVEA_rA2                   CMP.L           #match_MOVEA_A2,D2                ;check reg is equal to 2
                            BNE             MOVEA_rA3                         ;if not try reg 3
                            BEQ             MOVEA_An_indir_reg2_out           ;if equal go to output subroutine

MOVEA_rA3                   CMP.L           #match_MOVEA_A3,D2                ;check reg is equal to 3
                            BNE             MOVEA_rA4                         ;if not try reg 4
                            BEQ             MOVEA_An_indir_reg3_out           ;if equal go to output subroutine

MOVEA_rA4                   CMP.L           #match_MOVEA_A4,D2                ;check reg is equal to 4
                            BNE             MOVEA_rA5                         ;if not try reg 5
                            BEQ             MOVEA_An_indir_reg4_out           ;if equal go to output subroutine
            
MOVEA_rA5                   CMP.L           #match_MOVEA_A5,D2                ;check reg is equal to 5
                            BNE             MOVEA_rA6                         ;if not try reg 6
                            BEQ             MOVEA_An_indir_reg5_out           ;if equal go to output subroutine

MOVEA_rA6                   CMP.L           #match_MOVEA_A6,D2                ;check reg is equal to 6
                            BNE             MOVEA_rA7                         ;if not try reg 7
                            BEQ             MOVEA_An_indir_reg6_out           ;if equal go to output subroutine

MOVEA_rA7                   CMP.L           #match_MOVEA_A7,D2                ;check reg is equal to 7
                            BEQ             MOVEA_An_indir_reg7_out           ;if equal go to output subroutine
                            BNE             ERROR                             ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Direct Output-----------------------
MOVEA_A0_out          MOVE.L	      #ea_A0,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
        						
MOVEA_A1_out          MOVE.L	      #ea_A1,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
        						
MOVEA_A2_out          MOVE.L	      #ea_A2,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
        						
MOVEA_A3_out          MOVE.L	      #ea_A3,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
                      
MOVEA_A4_out          MOVE.L	      #ea_A4,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
                      
MOVEA_A5_out          MOVE.L	      #ea_A5,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
                      
MOVEA_A6_out          MOVE.L	      #ea_A6,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS
                      
MOVEA_A7_out          MOVE.L	      #ea_A7,A1				;load string constant into A1
                            JSR             print_first
                      JSR             MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                      RTS

;------------------Address Register Indirect-----------------------
MOVEA_An_indir_reg       CLR.L      D2
                        MOVE.W      Do,D2
                        AND.L              #mask_MOVEA_ea_reg_and_mode,D2
                        CMP.L           #match_MOVEA_An_indir_r0,D2           ;check reg is equal to 0
                         BNE             MOVEA_An_indir_reg1                   ;if not try reg 1
                         BEQ             MOVEA_An_indir_reg0_out               ;if equal go to output subroutine

MOVEA_An_indir_reg1      CMP.L           #match_MOVEA_An_indir_r1,D2           ;check reg is equal to 1
                         BNE             MOVEA_An_indir_reg2                   ;if not try reg 2
                         BEQ             MOVEA_An_indir_reg1_out               ;if equal go to output subroutine

MOVEA_An_indir_reg2      CMP.L           #match_MOVEA_An_indir_r2,D2           ;check reg is equal to 2
                         BNE             MOVEA_An_indir_reg3                   ;if not try reg 3
                         BEQ             MOVEA_An_indir_reg2_out               ;if equal go to output subroutine

MOVEA_An_indir_reg3      CMP.L           #match_MOVEA_An_indir_r3,D2           ;check reg is equal to 3
                         BNE             MOVEA_An_indir_reg4                   ;if not try reg 4
                         BEQ             MOVEA_An_indir_reg3_out               ;if equal go to output subroutine
    
MOVEA_An_indir_reg4      CMP.L           #match_MOVEA_An_indir_r4,D2           ;check reg is equal to 4
                         BNE             MOVEA_An_indir_reg5                   ;if not try reg 5
                         BEQ             MOVEA_An_indir_reg4_out               ;if equal go to output subroutine
        
MOVEA_An_indir_reg5      CMP.L           #match_MOVEA_An_indir_r5,D2           ;check reg is equal to 5
                         BNE             MOVEA_An_indir_reg6                   ;if not try reg 6
                         BEQ             MOVEA_An_indir_reg5_out               ;if equal go to output subroutine

MOVEA_An_indir_reg6      CMP.L           #match_MOVEA_An_indir_r6,D2           ;check reg is equal to 6
                         BNE             MOVEA_An_indir_reg7                   ;if not try reg 7
                         BEQ             MOVEA_An_indir_reg6_out               ;if equal go to output subroutine

MOVEA_An_indir_reg7      CMP.L           #match_MOVEA_An_indir_r7,D2           ;check reg is equal to 7
                         BEQ             MOVEA_An_indir_reg7_out               ;if equal go to output subroutine
                         BNE             ERROR                                 ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Indirect Output-----------------------
MOVEA_An_indir_reg0_out		    MOVE.L		#ea_indir_A0,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
                                
MOVEA_An_indir_reg1_out		    MOVE.L		#ea_indir_A1,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
                                
MOVEA_An_indir_reg2_out		    MOVE.L		#ea_indir_A2,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
                                
MOVEA_An_indir_reg3_out		    MOVE.L		#ea_indir_A3,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
                                
MOVEA_An_indir_reg4_out		    MOVE.L		#ea_indir_A4,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
                                
MOVEA_An_indir_reg5_out		    MOVE.L		#ea_indir_A5,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
                                
MOVEA_An_indir_reg6_out		    MOVE.L		#ea_indir_A6,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS
								        
MOVEA_An_indir_reg7_out		    MOVE.L		#ea_indir_A7,A1		    	  ;load string constant into A1
                            JSR             print_first
                                JSR         MOVEA_determine_second_op         ;jump to subroutine to determine second operand
                                RTS

;------------------Address Register Indirect with Post Increment-----------------------
MOVEA_An_indir_postinc_reg        CLR.L     D2
                                    MOVE.W  D0,D2
                                    AND.L              #mask_MOVEA_ea_reg_and_mode,D2
                                    CMP.L      #match_MOVEA_An_indir_postinc_r0,D2        ;check reg is equal to 0
                                  BNE        MOVEA_An_indir_postinc_reg1                ;if not try reg 1
                                  BEQ        MOVEA_An_indir_postinc_reg0_out            ;if equal go to output subroutine

MOVEA_An_indir_postinc_reg1       CMP.L      #match_MOVEA_An_indir_postinc_r1,D2        ;check reg is equal to 1
                                  BNE        MOVEA_An_indir_postinc_reg2                ;if not try reg 2
                                  BEQ        MOVEA_An_indir_postinc_reg1_out            ;if equal go to output subroutine

MOVEA_An_indir_postinc_reg2       CMP.L      #match_MOVEA_An_indir_postinc_r2,D2        ;check reg is equal to 2
                                  BNE        MOVEA_An_indir_postinc_reg3                ;if not try reg 3
                                  BEQ        MOVEA_An_indir_postinc_reg2_out            ;if equal go to output subroutine

MOVEA_An_indir_postinc_reg3       CMP.L      #match_MOVEA_An_indir_postinc_r3,D2        ;check reg is equal to 3
                                  BNE        MOVEA_An_indir_postinc_reg4                ;if not try reg 4
                                  BEQ        MOVEA_An_indir_postinc_reg3_out            ;if equal go to output subroutine
 
MOVEA_An_indir_postinc_reg4       CMP.L      #match_MOVEA_An_indir_postinc_r4,D2        ;check reg is equal to 4
                                  BNE        MOVEA_An_indir_postinc_reg5                ;if not try reg 5
                                  BEQ        MOVEA_An_indir_postinc_reg4_out            ;if equal go to output subroutine

MOVEA_An_indir_postinc_reg5       CMP.L      #match_MOVEA_An_indir_postinc_r5,D2        ;check reg is equal to 5
                                  BNE        MOVEA_An_indir_postinc_reg6                ;if not try reg 6
                                  BEQ        MOVEA_An_indir_postinc_reg5_out            ;if equal go to output subroutine

MOVEA_An_indir_postinc_reg6       CMP.L      #match_MOVEA_An_indir_postinc_r6,D2        ;check reg is equal to 6
                                  BNE        MOVEA_An_indir_postinc_reg7                ;if not try reg 7
                                  BEQ        MOVEA_An_indir_postinc_reg6_out            ;if equal go to output subroutine

MOVEA_An_indir_postinc_reg7       CMP.L      #match_MOVEA_An_indir_postinc_r7,D2        ;check reg is equal to 7
                                  BEQ        MOVEA_An_indir_postinc_reg7_out            ;if equal go to output subroutine
                                  BNE        ERROR                                      ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Indirect with Post Increment Output-----------------------
MOVEA_An_indir_postinc_reg0_out	      MOVE.L	    #ea_indir_postinc_A0,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS

MOVEA_An_indir_postinc_reg1_out	      MOVE.L	    #ea_indir_postinc_A1,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS
                                      
MOVEA_An_indir_postinc_reg2_out	      MOVE.L	    #ea_indir_postinc_A2,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS
                                      
MOVEA_An_indir_postinc_reg3_out	      MOVE.L	    #ea_indir_postinc_A3,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS
                                      
MOVEA_An_indir_postinc_reg4_out	      MOVE.L	    #ea_indir_postinc_A4,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS
                                      
MOVEA_An_indir_postinc_reg5_out	      MOVE.L	    #ea_indir_postinc_A5,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS
                                      
MOVEA_An_indir_postinc_reg6_out	      MOVE.L	    #ea_indir_postinc_A6,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS
                                      
MOVEA_An_indir_postinc_reg7_out	      MOVE.L	    #ea_indir_postinc_A7,A1	    ;load string constant into A1
                                      JSR           print_first
                                      JSR           MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                      RTS

;------------------Address Register Indirect with Pre Decrement-----------------------
MOVEA_An_indir_predec              CLR.L        D2
                                    MOVE.W  D0,D2
                                    CMP.L      #match_MOVEA_An_indir_predec_reg0,D2       ;check reg is equal to 0
                                   BNE        MOVEA_An_indir_predec_reg1                 ;if not try reg 1
                                   BEQ        MOVEA_An_indir_predec_reg0_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg1         CMP.L      #match_MOVEA_An_indir_predec_reg1,D2       ;check reg is equal to 1
                                   BNE        MOVEA_An_indir_predec_reg2                 ;if not try reg 2
                                   BEQ        MOVEA_An_indir_predec_reg1_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg2         CMP.L      #match_MOVEA_An_indir_predec_reg2,D2       ;check reg is equal to 2
                                   BNE        MOVEA_An_indir_predec_reg3                 ;if not try reg 3
                                   BEQ        MOVEA_An_indir_predec_reg2_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg3         CMP.L      #match_MOVEA_An_indir_predec_reg3,D2       ;check reg is equal to 3
                                   BNE        MOVEA_An_indir_predec_reg4                 ;if not try reg 4
                                   BEQ        MOVEA_An_indir_predec_reg3_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg4         CMP.L      #match_MOVEA_An_indir_predec_reg4,D2       ;check reg is equal to 4
                                   BNE        MOVEA_An_indir_predec_reg5                 ;if not try reg 5
                                   BEQ        MOVEA_An_indir_predec_reg4_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg5         CMP.L      #match_MOVEA_An_indir_predec_reg5,D2       ;check reg is equal to 5
                                   BNE        MOVEA_An_indir_predec_reg6                 ;if not try reg 6
                                   BEQ        MOVEA_An_indir_predec_reg5_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg6         CMP.L      #match_MOVEA_An_indir_predec_reg6,D2       ;check reg is equal to 6
                                   BNE        MOVEA_An_indir_predec_reg7                 ;if not try reg 7
                                   BEQ        MOVEA_An_indir_predec_reg6_out             ;if equal go to output subroutine

MOVEA_An_indir_predec_reg7         CMP.L      #match_MOVEA_An_indir_predec_reg7,D2       ;check reg is equal to 7
                                   BEQ        MOVEA_An_indir_predec_reg7_out             ;if equal go to output subroutine
                                   BNE        ERROR                                      ;if not equal to an addresssing mode, pritn error


;--------------------Address Register Indirect with Pre Decrement Output-----------------------
MOVEA_An_indir_predec_reg0_out		    MOVE.L		#ea_indir_predec_A0,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
											
MOVEA_An_indir_predec_reg1_out		    MOVE.L		#ea_indir_predec_A1,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
                                      
MOVEA_An_indir_predec_reg2_out		    MOVE.L		#ea_indir_predec_A2,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
                                        
MOVEA_An_indir_predec_reg3_out		    MOVE.L		#ea_indir_predec_A3,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
                                      
MOVEA_An_indir_predec_reg4_out		    MOVE.L		#ea_indir_predec_A4,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
                                      
MOVEA_An_indir_predec_reg5_out		    MOVE.L		#ea_indir_predec_A5,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
                                      
MOVEA_An_indir_predec_reg6_out		    MOVE.L		#ea_indir_predec_A6,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
                                      
MOVEA_An_indir_predec_reg7_out		    MOVE.L		#ea_indir_predec_A7,A1		 ;load string constant into A1
                                        JSR         print_first
                                        JSR             MOVEA_determine_second_op        ;jump to subroutine to determine second operand
                                        RTS
;------------------Absolute Addressing Output-----------------------
MOVEA_abs_add_word_out		    MOVE.L      	#ea_$,(A1)+            ;load $ for hex and increment A1
                                MOVE.L      	D5,(A1)+               ;load address                  
                                        JSR         print_first
                                RTS                                    ;return to subroutine
                                           

MOVEA_abs_add_long_out    	    MOVE.L      	(A0)+,D5               ;pull the next long instruction that holds the address
                                MOVE.L      	#ea_$,(A1)+            ;load $ for hex and increment A1
                                MOVE.L      	D5,(A1)+               ;load address                  
                                        JSR         print_first
                                RTS                                    ;return to subroutine    

                                        
;---------------Immediate Addresing---------------------------
MOVEA_immediate_add_out         MOVE.L		(A0)+,D5                        ;capture the immediate address
				                CMP.L      	#match_MOVEA_imm_add_word,D6          ;check to see if need to pull word
				                MOVE.L     	(A0)+,D5                        ;pull the word
                                BEQ        	MOVEA_imm_add_w                 ;if equal go pull word    
				                BNE        	MOVEA_imm_add_l                 ;if not equal, go check long
										 
MOVEA_imm_add_w                 MOVE.L     	#ea_$,(A1)+                     ;load the $
                                MOVE.W     	D5,(A1)+                        ;load the word address                           
                                JSR         print_first
                                JSR         MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                RTS
                                         
MOVEA_imm_add_l                 MOVE.L     	(A0)+,D5                        ;pull the long and increase the pointer
                                MOVE.L     	#ea_$,(A1)+                     ;load the $
                                MOVE.L     	D5,A1                           ;move to A1
                                JSR         print_first
                                JSR        	MOVEA_determine_second_op       ;jump to subroutine to determine second operand
                                RTS                                              

;---------------------------------Determine Register----------------------------------------------------------------------------------------
MOVEA_determine_second_op	    CLR.L		D2				;clear D2 
                                MOVE.W      D0,D2
                				AND.L		#mask_MOVEA_An_reg,D2		;load the mask for the register into D2, masks bit 11-9
												
MOVEA_reg0		            	CMP.L		#match_MOVEA_reg0,D2		;check to see if reg equal 0
                				BNE		    MOVEA_reg1			;if not equal got check reg 1
				                BEQ		    MOVEA_reg0_out			;if equal go to output
												
MOVEA_reg1			            CMP.L		#match_MOVEA_reg1,D2		;check to see if reg equal 1
                				BNE		    MOVEA_reg2			;if not equal got check reg 2
				                BEQ 		MOVEA_reg1_out			;if equal go to output
    
MOVEA_reg2			            CMP.L		#match_MOVEA_reg2,D2		;check to see if reg equal 2
                				BNE 		MOVEA_reg3			;if not equal got check reg 3
				                BEQ	    	MOVEA_reg2_out			;if equal go to output

MOVEA_reg3			            CMP.L		#match_MOVEA_reg3,D2		;check to see if reg equal 3
                				BNE		    MOVEA_reg4			;if not equal got check reg 4
				                BEQ		    MOVEA_reg3_out			;if equal go to output
												
MOVEA_reg4			            CMP.L		#match_MOVEA_reg4,D2		;check to see if reg equal 4
                				BNE		    MOVEA_reg5			;if not equal got check reg 5
				                BEQ		    MOVEA_reg4_out			;if equal go to output

MOVEA_reg5			            CMP.L		#match_MOVEA_reg5,D2		;check to see if reg equal 5
				                BNE		    MOVEA_reg6			;if not equal got check reg 6
				                BEQ		    MOVEA_reg5_out			;if equal go to output

MOVEA_reg6			            CMP.L		#match_MOVEA_reg6,D2		;check to see if reg equal 6
				                BNE		    MOVEA_reg7			;if not equal got check reg 7
				                BEQ		    MOVEA_reg6_out			;if equal go to output			

MOVEA_reg7			            CMP.L		#match_MOVEA_reg7,D2		;check to see if reg equal 7
				                BEQ		    MOVEA_reg7_out			;if equal go to output
				                BNE         ERROR                           ;if not equal to an addresssing mode, pritn error
								

;--------------------Data Output-----------------------
MOVEA_reg0_out			        MOVE.L		#ea_A0,A1		;load string constant into A1
                                RTS
											
MOVEA_reg1_out			        MOVE.L		#ea_A1,A1		;load string constant into A1
                                RTS
                                            
MOVEA_reg2_out			        MOVE.L		#ea_A2,A1		;load string constant into A1
                                RTS
                                            
MOVEA_reg3_out			        MOVE.L		#ea_A3,A1		;load string constant into A1
                                RTS
                                            
MOVEA_reg4_out			        MOVE.L		#ea_A4,A1		;load string constant into A1
                                RTS
                                            
MOVEA_reg5_out			        MOVE.L		#ea_A5,A1		;load string constant into A1
                                RTS
                                            
MOVEA_reg6_out			        MOVE.L		#ea_A6,A1		;load string constant into A1
                                RTS
                                            
MOVEA_reg7_out			        MOVE.L		#ea_A7,A1		;load string constant into A1
                                RTS				




mask_MOVEA_ea_mode			    EQU		$0038
mask_MOVEA_abs_add			    EQU		$003F
mask_MOVEA_ea_reg_and_mode		EQU		$003F
mask_MOVEA_An_reg			    EQU		$0E00

match_MOVEA_Dn				    EQU		$0000
match_MOVEA_An				    EQU		$0008
match_MOVEA_An_indir			EQU		$0010
match_MOVEA_An_indir_predec		EQU		$0020
match_MOVEA_An_indir_postinc	EQU		$0018
match_MOVEA_abs_add_word		EQU		$0038
match_MOVEA_abs_add_long		EQU		$0039

match_MOVEA_D0				EQU		$0000
match_MOVEA_D1				EQU		$0001
match_MOVEA_D2				EQU		$0002
match_MOVEA_D3				EQU		$0003
match_MOVEA_D4				EQU		$0004
match_MOVEA_D5				EQU		$0005
match_MOVEA_D6				EQU		$0006
match_MOVEA_D7				EQU		$0007

match_MOVEA_A0				EQU		$0008
match_MOVEA_A1				EQU		$0009
match_MOVEA_A2				EQU		$000A
match_MOVEA_A3				EQU		$000B
match_MOVEA_A4				EQU		$000C
match_MOVEA_A5				EQU		$000D
match_MOVEA_A6				EQU		$000E
match_MOVEA_A7				EQU		$000F

match_MOVEA_An_indir_r0			EQU		$0010
match_MOVEA_An_indir_r1			EQU		$0011
match_MOVEA_An_indir_r2			EQU		$0012
match_MOVEA_An_indir_r3			EQU		$0013
match_MOVEA_An_indir_r4			EQU		$0014
match_MOVEA_An_indir_r5			EQU		$0015
match_MOVEA_An_indir_r6			EQU		$0016
match_MOVEA_An_indir_r7			EQU		$0017

match_MOVEA_An_indir_postinc_r0		EQU		$0018
match_MOVEA_An_indir_postinc_r1		EQU		$0019
match_MOVEA_An_indir_postinc_r2		EQU		$001A
match_MOVEA_An_indir_postinc_r3		EQU		$001B
match_MOVEA_An_indir_postinc_r4		EQU		$001C
match_MOVEA_An_indir_postinc_r5		EQU		$001D
match_MOVEA_An_indir_postinc_r6		EQU		$001E
match_MOVEA_An_indir_postinc_r7		EQU		$001F

match_MOVEA_An_indir_predec_reg0	EQU		$0020
match_MOVEA_An_indir_predec_reg1	EQU		$0021
match_MOVEA_An_indir_predec_reg2	EQU		$0022
match_MOVEA_An_indir_predec_reg3	EQU		$0023
match_MOVEA_An_indir_predec_reg4	EQU		$0024
match_MOVEA_An_indir_predec_reg5	EQU		$0025
match_MOVEA_An_indir_predec_reg6	EQU		$0026
match_MOVEA_An_indir_predec_reg7	EQU		$0027

match_MOVEA_imm_add                 EQU     $003C
match_MOVEA_imm_add_word            EQU     $00FC
match_MOVEA_imm_add_long            EQU     $01FC

match_MOVEA_reg0			EQU		$0000
match_MOVEA_reg1			EQU		$0200
match_MOVEA_reg2			EQU		$0400
match_MOVEA_reg3			EQU		$0600
match_MOVEA_reg4			EQU		$0800
match_MOVEA_reg5			EQU		$0A00
match_MOVEA_reg6			EQU		$0C00
match_MOVEA_reg7			EQU		$0E00





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
