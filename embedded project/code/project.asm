
_counter:

;project.c,7 :: 		void counter(signed char count){
;project.c,8 :: 		char left=count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_counter_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      counter_left_L0+0
;project.c,9 :: 		char right=count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_counter_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
;project.c,10 :: 		MSD=0; //npn transistor2 off
	BCF        PORTE+0, 1
;project.c,11 :: 		LSD=1;// npn transistor1 on
	BSF        PORTE+0, 0
;project.c,12 :: 		portc=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;project.c,13 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_counter0:
	DECFSZ     R13+0, 1
	GOTO       L_counter0
	DECFSZ     R12+0, 1
	GOTO       L_counter0
	NOP
;project.c,14 :: 		LSD=0; //npn transistor1 off
	BCF        PORTE+0, 0
;project.c,15 :: 		MSD=1;  //npn transistor2 on
	BSF        PORTE+0, 1
;project.c,16 :: 		portc=left;
	MOVF       counter_left_L0+0, 0
	MOVWF      PORTC+0
;project.c,17 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_counter1:
	DECFSZ     R13+0, 1
	GOTO       L_counter1
	DECFSZ     R12+0, 1
	GOTO       L_counter1
	NOP
;project.c,18 :: 		}
L_end_counter:
	RETURN
; end of _counter

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;project.c,20 :: 		void interrupt(){
;project.c,21 :: 		if(intf_bit==1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt2
;project.c,22 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;project.c,23 :: 		j++;
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;project.c,24 :: 		}
L_interrupt2:
;project.c,25 :: 		if(j==1){
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt50
	MOVLW      1
	XORWF      _j+0, 0
L__interrupt50:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;project.c,26 :: 		portd=0b00010001;
	MOVLW      17
	MOVWF      PORTD+0
;project.c,27 :: 		}
L_interrupt3:
;project.c,28 :: 		if(j==2){
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt51
	MOVLW      2
	XORWF      _j+0, 0
L__interrupt51:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt4
;project.c,29 :: 		for(count=3;count>=0;count--){
	MOVLW      3
	MOVWF      _count+0
L_interrupt5:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt6
;project.c,30 :: 		if(SWITCH==1) break;
	BTFSS      PORTB+0, 1
	GOTO       L_interrupt8
	GOTO       L_interrupt6
L_interrupt8:
;project.c,31 :: 		portd=0b00100001;
	MOVLW      33
	MOVWF      PORTD+0
;project.c,32 :: 		for(i=0;i<50;i++){
	CLRF       _i+0
L_interrupt9:
	MOVLW      50
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt10
;project.c,33 :: 		char left=count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      interrupt_left_L3+0
;project.c,34 :: 		char right=count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
;project.c,35 :: 		MSD=0;
	BCF        PORTE+0, 1
;project.c,36 :: 		LSD=1;
	BSF        PORTE+0, 0
;project.c,37 :: 		portc=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;project.c,38 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_interrupt12:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt12
	DECFSZ     R12+0, 1
	GOTO       L_interrupt12
	NOP
;project.c,39 :: 		LSD=0;
	BCF        PORTE+0, 0
;project.c,40 :: 		MSD=1;
	BSF        PORTE+0, 1
;project.c,41 :: 		portc=left;
	MOVF       interrupt_left_L3+0, 0
	MOVWF      PORTC+0
;project.c,42 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_interrupt13:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt13
	DECFSZ     R12+0, 1
	GOTO       L_interrupt13
	NOP
;project.c,32 :: 		for(i=0;i<50;i++){
	INCF       _i+0, 1
;project.c,43 :: 		}
	GOTO       L_interrupt9
L_interrupt10:
;project.c,29 :: 		for(count=3;count>=0;count--){
	DECF       _count+0, 1
;project.c,44 :: 		}
	GOTO       L_interrupt5
L_interrupt6:
;project.c,45 :: 		j=3;
	MOVLW      3
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
;project.c,46 :: 		}
L_interrupt4:
;project.c,47 :: 		if(j==3){
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt52
	MOVLW      3
	XORWF      _j+0, 0
L__interrupt52:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt14
;project.c,48 :: 		portd=0b00001010;
	MOVLW      10
	MOVWF      PORTD+0
;project.c,50 :: 		}if(j==4){
L_interrupt14:
	MOVLW      0
	XORWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt53
	MOVLW      4
	XORWF      _j+0, 0
L__interrupt53:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt15
;project.c,51 :: 		for(count=3;count>=0;count--){
	MOVLW      3
	MOVWF      _count+0
L_interrupt16:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt17
;project.c,52 :: 		if(SWITCH==1)break;
	BTFSS      PORTB+0, 1
	GOTO       L_interrupt19
	GOTO       L_interrupt17
L_interrupt19:
;project.c,53 :: 		portd=0b00001100;
	MOVLW      12
	MOVWF      PORTD+0
;project.c,55 :: 		for(i=0;i<50;i++){
	CLRF       _i+0
L_interrupt20:
	MOVLW      50
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt21
;project.c,56 :: 		char left=count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      interrupt_left_L3_L3+0
;project.c,57 :: 		char right=count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       _count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
;project.c,58 :: 		MSD=0;
	BCF        PORTE+0, 1
;project.c,59 :: 		LSD=1;
	BSF        PORTE+0, 0
;project.c,60 :: 		portc=right;
	MOVF       R0+0, 0
	MOVWF      PORTC+0
;project.c,61 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_interrupt23:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt23
	DECFSZ     R12+0, 1
	GOTO       L_interrupt23
	NOP
;project.c,62 :: 		LSD=0;
	BCF        PORTE+0, 0
;project.c,63 :: 		MSD=1;
	BSF        PORTE+0, 1
;project.c,64 :: 		portc=left;
	MOVF       interrupt_left_L3_L3+0, 0
	MOVWF      PORTC+0
;project.c,65 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_interrupt24:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt24
	DECFSZ     R12+0, 1
	GOTO       L_interrupt24
	NOP
;project.c,55 :: 		for(i=0;i<50;i++){
	INCF       _i+0, 1
;project.c,66 :: 		}
	GOTO       L_interrupt20
L_interrupt21:
;project.c,51 :: 		for(count=3;count>=0;count--){
	DECF       _count+0, 1
;project.c,67 :: 		}
	GOTO       L_interrupt16
L_interrupt17:
;project.c,68 :: 		j=1;
	MOVLW      1
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
;project.c,69 :: 		portd=0b00010001;
	MOVLW      17
	MOVWF      PORTD+0
;project.c,70 :: 		}
L_interrupt15:
;project.c,76 :: 		}
L_end_interrupt:
L__interrupt49:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;project.c,78 :: 		void main() {
;project.c,79 :: 		adcon1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;project.c,80 :: 		trise=0;//transistors
	CLRF       TRISE+0
;project.c,81 :: 		porte=0;
	CLRF       PORTE+0
;project.c,82 :: 		trisd=0;// 7seg decoders
	CLRF       TRISD+0
;project.c,83 :: 		portd=0;
	CLRF       PORTD+0
;project.c,84 :: 		trisc=0;//traffic lights
	CLRF       TRISC+0
;project.c,85 :: 		portc=0;
	CLRF       PORTC+0
;project.c,86 :: 		trisb.b0=1;//SWITCH Button
	BSF        TRISB+0, 0
;project.c,87 :: 		trisb.b1=1;//MANUAL Button
	BSF        TRISB+0, 1
;project.c,88 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;project.c,89 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;project.c,90 :: 		intedg_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;project.c,91 :: 		for(;;){
L_main25:
;project.c,92 :: 		if(SWITCH==1){
	BTFSS      PORTB+0, 1
	GOTO       L_main28
;project.c,93 :: 		for(count=15;count>=0;count--){
	MOVLW      15
	MOVWF      _count+0
L_main29:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main30
;project.c,94 :: 		if(SWITCH==0){
	BTFSC      PORTB+0, 1
	GOTO       L_main32
;project.c,95 :: 		portd=0b00000000;
	CLRF       PORTD+0
;project.c,96 :: 		break;
	GOTO       L_main30
;project.c,97 :: 		}
L_main32:
;project.c,98 :: 		if(count<=3){
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main33
;project.c,99 :: 		portd=0b00100001;//W.red & S.yellow
	MOVLW      33
	MOVWF      PORTD+0
;project.c,100 :: 		}else{
	GOTO       L_main34
L_main33:
;project.c,101 :: 		portd=0b00010001;//w.red & S.green
	MOVLW      17
	MOVWF      PORTD+0
;project.c,102 :: 		}
L_main34:
;project.c,103 :: 		for(i=0;i<50;i++){
	CLRF       _i+0
L_main35:
	MOVLW      50
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main36
;project.c,104 :: 		counter(count);
	MOVF       _count+0, 0
	MOVWF      FARG_counter_count+0
	CALL       _counter+0
;project.c,103 :: 		for(i=0;i<50;i++){
	INCF       _i+0, 1
;project.c,105 :: 		}
	GOTO       L_main35
L_main36:
;project.c,93 :: 		for(count=15;count>=0;count--){
	DECF       _count+0, 1
;project.c,107 :: 		}
	GOTO       L_main29
L_main30:
;project.c,108 :: 		for(count=23;count>=0;count--){
	MOVLW      23
	MOVWF      _count+0
L_main38:
	MOVLW      128
	XORWF      _count+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main39
;project.c,109 :: 		if(SWITCH==0){
	BTFSC      PORTB+0, 1
	GOTO       L_main41
;project.c,110 :: 		portd=0b00000000;
	CLRF       PORTD+0
;project.c,111 :: 		break;
	GOTO       L_main39
;project.c,112 :: 		}
L_main41:
;project.c,113 :: 		if(count<=3){
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+0, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main42
;project.c,114 :: 		portd=0b00001100;//S.red & W.yellow
	MOVLW      12
	MOVWF      PORTD+0
;project.c,115 :: 		}else{
	GOTO       L_main43
L_main42:
;project.c,116 :: 		portd=0b00001010;//S.red & W.green
	MOVLW      10
	MOVWF      PORTD+0
;project.c,117 :: 		}
L_main43:
;project.c,118 :: 		for(i=0;i<50;i++){
	CLRF       _i+0
L_main44:
	MOVLW      50
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main45
;project.c,119 :: 		counter(count);
	MOVF       _count+0, 0
	MOVWF      FARG_counter_count+0
	CALL       _counter+0
;project.c,118 :: 		for(i=0;i<50;i++){
	INCF       _i+0, 1
;project.c,120 :: 		}
	GOTO       L_main44
L_main45:
;project.c,108 :: 		for(count=23;count>=0;count--){
	DECF       _count+0, 1
;project.c,121 :: 		}
	GOTO       L_main38
L_main39:
;project.c,122 :: 		}
L_main28:
;project.c,123 :: 		}
	GOTO       L_main25
;project.c,124 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
