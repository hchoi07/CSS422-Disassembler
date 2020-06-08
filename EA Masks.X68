*------------EA Masks----------------------

*-----------MOVE masks---------------
mask_MOVE_EA		    	EQU		$0FFF
mask_MOVE_dst_reg	    	EQU		$0E00
mask_MOVE_dst_mode	    	EQU		$01C0
mask_MOVE_src_reg	    	EQU		$0038
mask_MOVE_src_mode	    	EQU		$0007

*----------MOVEA masks---------------
mask_MOVEA_EA		    	EQU		$0E3F
mask_MOVEA_dst_reg		    EQU		$0E00
mask_MOVEA_src_mode		    EQU		$0038
mask_MOVEA_src_reg	    	EQU		$0007

*----------MOVEQ masks---------------
mask_MOVEQ_EA		    	EQU		$0EFF
mask_MOVEQ_reg		    	EQU		$0E00
mask_MOVEQ_data		    	EQU		$00FF

*----------MOVEM masks---------------
mask_MOVEM_EA		    	EQU		$047F		
mask_MOVEM_direct	    	EQU		$0400
mask_MOVEM_size			    EQU		$0040
;using predecrement bits go from 15-0 15 = D0, 0 = A7
;using post increment bits ggo from 15-0, 15 = A7, 0 = D0
;the low order bit is the register transfered first
mask_MOVEM_ea_reg		    EQU		$0007

*----------ADD masks-----------------
mask_ADD_EA					EQU		$0FFF
mask_ADD_reg				EQU		$0E00
mask_ADD_opmode				EQU		$01C0
mask_ADD_ea_reg				EQU		$0007

*----------ADDA masks----------------
mask_ADDA_EA				EQU		$0FFF
mask_ADDA_reg				EQU		$0E00
mask_ADDA_opmode			EQU		$01C0
mask_ADDA_ea_mode			EQU		$0038
mask_ADDA_ea_reg			EQU		$0007

*----------ADDQ masks----------------
mask_ADDQ_EA				EQU		$0EFF
mask_ADDQ_data				EQU		$0E00
mask_ADDQ_size				EQU		$00C0
mask_ADDQ_ea_mode			EQU		$0038
mask_ADDQ_ea_reg			EQU		$0007

*------------SUB masks--------------------
mask_SUB_EA					EQU		$0FFF
mask_SUB_reg				EQU		$0E00
mask_SUB_opmode				EQU		$01C0
mask_SUB_ea_mode			EQU		$0038
mask_SUB_ea_reg				EQU		$0007

*------------LEA masks----------------------
mask_LEA_EA					EQU		$0E3F
mask_LEA_reg				EQU		$0E00
mask_LEA_ea_mode			EQU		$0038
mask_LEA_ea_reg				EQU		$0007

*--------------AND masks------------------
mask_AND_EA					EQU		$0FFF
mask_AND_reg				EQU		$0E00
mask_AND_opmode				EQU		$01C0
mask_AND_ea_mode			EQU		$0038
mask_AND_ea_reg				EQU		$0007

*-------------OR masks-------------------
mask_OR_EA					EQU		$0FFF
mask_OR_reg					EQU		$0E00
mask_OR_opmode				EQU		$01C0
mask_OR_ea_mode				EQU		$0038
mask_OR_ea_reg				EQU		$0007

*-------------NOT masks-------------------
mask_NOT_EA					EQU		$00FF
mask_NOT_size				EQU		$00C0
mask_NOT_ea_mode			EQU		$0038
mask_NOT_ea_reg				EQU		$0007

*---------ASR memory shift masks----------------
mask_ASR_mem_shift_EA		EQU		$013F
mask_ASR_mem_shift_direct	EQU		$0100
mask_ASR_mem_shift_ea_mode	EQU		$0038
mask_ASR_mem_shift_ea_reg	EQU		$0007

*---------ASL memory shift masks----------------
mask_ASL_mem_shift_EA		EQU		$013F
mask_ASL_mem_shift_direct	EQU		$0100
mask_ASL_mem_shift_ea_mode	EQU		$0038
mask_ASL_mem_shift_ea_reg	EQU		$0007

*---------ASR register shift masks----------------
mask_ASR_reg_shift_EA		EQU		$0FE7
mask_ASR_reg_shift_count	EQU		$0E00
mask_ASR_reg_shift_direct	EQU		$0100
mask_ASR_reg_shift_size		EQU		$00C0
mask_ASR_reg_shift_ir		EQU		$0020
mask_ASR_reg_shift_reg		EQU		$0007

*---------ASL register shift masks----------------
mask_ASL_reg_shift_EA		EQU		$0FE7
mask_ASL_reg_shift_count	EQU		$0E00
mask_ASL_reg_shift_direct	EQU		$0100
mask_ASL_reg_shift_size		EQU		$00C0
mask_ASL_reg_shift_ir		EQU		$0020
mask_ASL_reg_shift_reg		EQU		$0007

*---------LSR memory shift masks----------------
mask_LSR_mem_shift_EA		EQU		$013F
mask_LSR_mem_shift_direct	EQU		$0100
mask_LSR_mem_shift_ea_mode	EQU		$0038
mask_LSR_mem_shift_ea_reg	EQU		$0007

*---------LSL memory shift masks----------------
mask_LSL_mem_shift_EA		EQU		$013F
mask_LSL_mem_shift_direct	EQU		$0100
mask_LSL_mem_shift_ea_mode	EQU		$0038
mask_LSL_mem_shift_ea_reg	EQU		$0007

*---------LSR register shift masks----------------
mask_LSR_reg_shift_EA		EQU		$0FE7
mask_LSR_reg_shift_count	EQU		$0E00
mask_LSR_reg_shift_direct	EQU		$0100
mask_LSR_reg_shift_size		EQU		$00C0
mask_LSR_reg_shift_ir		EQU		$0020
mask_LSR_reg_shift_reg		EQU		$0007

*---------LSL register shift masks----------------
mask_LSL_reg_shift_EA		EQU		$0FE7
mask_LSL_reg_shift_count	EQU		$0E00
mask_LSL_reg_shift_direct	EQU		$0100
mask_LSL_reg_shift_sIze		EQU		$00C0
mask_LSL_reg_shift_ir   	EQU		$0020
mask_LSL_reg_shift_reg		EQU		$0007


*---------ROR memory rotate masks----------------
mask_ROR_mem_rot_EA			EQU		$013F
mask_ROR_mem_rot_direct		EQU		$0100
mask_ROR_mem_rot_ea_mode	EQU		$0038
mask_ROR_mem_rot_ea_reg		EQU		$0007

*---------ROL memory rotate masks----------------
mask_ROL_mem_rot_EA			EQU		$013F
mask_ROL_mem_rot_direct		EQU		$0100
mask_ROL_mem_rot_ea_mode	EQU		$0038
mask_ROL_mem_rot_ea_reg		EQU		$0007

*---------ROR register rotate masks----------------
mask_ROR_reg_rot_EA			EQU		$0FE7
mask_ROR_reg_rot_count		EQU		$0E00
mask_ROR_reg_rot_direct		EQU		$0100
mask_ROR_reg_rot_size		EQU		$00C0
mask_ROR_reg_rot_ir 		EQU		$0020
mask_ROR_reg_rot_reg		EQU		$0007

*---------ROL register rotate masks----------------
mask_ROL_reg_rot_EA			EQU		$0FE7
mask_ROL_reg_rot_count		EQU		$0E00
mask_ROL_reg_rot_direct		EQU		$0100
mask_ROL_reg_rot_size		EQU		$0C00
mask_ROL_reg_rot_ir		    EQU		$0020
mask_ROL_reg_rot_reg		EQU		$0007

*-------------------Bcc masks------------------------
mask_Bcc_EA					EQU		$0FFF
mask_Bcc_cond				EQU		$0E00
mask_Bcc_displace			EQU		$00FF

*-------------------BLE masks------------------------
mask_BLE_EA					EQU		$0F00		;code for LE condition is 1111
mask_BLE_displace			EQU		$00FF

*-------------------BGT masks------------------------
mask_BGT_EA					EQU		$0F00		;code for GT condition is 1110
mask_BGT_displace			EQU		$00FF

*------------------JSR masks------------------------
mask_JSR_EA					EQU		$003F
mask_JSR_ea_mode			EQU		$0038
mask_JSR_ea_reg				EQU		$0007

*-------------------BRA masks------------------------
mask_BRA_EA					EQU		$00FF


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
