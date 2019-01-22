
_TEST:

;RC_Car.c,7 :: 		void TEST(){
;RC_Car.c,8 :: 		PORTD |= (1<<6);
	BSF         PORTD+0, 6 
;RC_Car.c,9 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_TEST0:
	DECFSZ      R13, 1, 1
	BRA         L_TEST0
	DECFSZ      R12, 1, 1
	BRA         L_TEST0
	DECFSZ      R11, 1, 1
	BRA         L_TEST0
	NOP
;RC_Car.c,10 :: 		PORTD &= ~(1<<6);
	BCF         PORTD+0, 6 
;RC_Car.c,11 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_TEST1:
	DECFSZ      R13, 1, 1
	BRA         L_TEST1
	DECFSZ      R12, 1, 1
	BRA         L_TEST1
	DECFSZ      R11, 1, 1
	BRA         L_TEST1
	NOP
;RC_Car.c,12 :: 		}
L_end_TEST:
	RETURN      0
; end of _TEST

_UART_INIT:

;RC_Car.c,14 :: 		void UART_INIT(){
;RC_Car.c,16 :: 		SPBRG = ((_XTAL_FREQ / 16) / Baud_rate) - 1;
	MOVLW       103
	MOVWF       SPBRG+0 
;RC_Car.c,18 :: 		TXSTA = 0b00100100;    //Set TXEN bit to 1, TX9 bit to 0, SYNC bit to 0 & BRGH bit to 1
	MOVLW       36
	MOVWF       TXSTA+0 
;RC_Car.c,19 :: 		RCSTA = 0b10010010;    //Set CERN bit to 1, RX9 bit to 0 & SPEN bit to 0
	MOVLW       146
	MOVWF       RCSTA+0 
;RC_Car.c,20 :: 		}
L_end_UART_INIT:
	RETURN      0
; end of _UART_INIT

_UART_GET_CHARACTER:

;RC_Car.c,22 :: 		char UART_GET_CHARACTER(){
;RC_Car.c,24 :: 		while(!RCIF);
L_UART_GET_CHARACTER3:
;RC_Car.c,25 :: 		return RCREG;
	MOVF        RCREG+0, 0 
	MOVWF       R0 
;RC_Car.c,26 :: 		}
L_end_UART_GET_CHARACTER:
	RETURN      0
; end of _UART_GET_CHARACTER

_Forward:

;RC_Car.c,28 :: 		void Forward(){
;RC_Car.c,30 :: 		PORTD |= (1<<0) | (1<<1);
	MOVLW       3
	IORWF       PORTD+0, 1 
;RC_Car.c,31 :: 		PORTD &= ~((1<<2) | (1<<3));
	MOVLW       243
	ANDWF       PORTD+0, 1 
;RC_Car.c,32 :: 		}
L_end_Forward:
	RETURN      0
; end of _Forward

_Backward:

;RC_Car.c,34 :: 		void Backward(){
;RC_Car.c,36 :: 		PORTD &= ~((1<<0) | (1<<1));
	MOVLW       252
	ANDWF       PORTD+0, 1 
;RC_Car.c,37 :: 		PORTD |= (1<<2) | (1<<3);
	MOVLW       12
	IORWF       PORTD+0, 1 
;RC_Car.c,38 :: 		}
L_end_Backward:
	RETURN      0
; end of _Backward

_Left:

;RC_Car.c,40 :: 		void Left(){
;RC_Car.c,41 :: 		PORTD &= ~((1<<1) | (1<<2) | (1<<3));
	MOVLW       241
	ANDWF       PORTD+0, 1 
;RC_Car.c,42 :: 		PORTD |= (1<<0);
	BSF         PORTD+0, 0 
;RC_Car.c,43 :: 		}
L_end_Left:
	RETURN      0
; end of _Left

_Right:

;RC_Car.c,45 :: 		void Right(){
;RC_Car.c,47 :: 		PORTD &= ~((1<<0) | (1<<2) | (1<<3));
	MOVLW       242
	ANDWF       PORTD+0, 1 
;RC_Car.c,48 :: 		PORTD |= (1<<1);
	BSF         PORTD+0, 1 
;RC_Car.c,49 :: 		}
L_end_Right:
	RETURN      0
; end of _Right

_Stop:

;RC_Car.c,51 :: 		void Stop(){
;RC_Car.c,53 :: 		PORTD &= ~((1<<0) | (1<<1) | (1<<2) | (1<<3));
	MOVLW       240
	ANDWF       PORTD+0, 1 
;RC_Car.c,54 :: 		}
L_end_Stop:
	RETURN      0
; end of _Stop

_main:

;RC_Car.c,57 :: 		void main() {
;RC_Car.c,59 :: 		TRISC &= ~(1<<6);
	BCF         TRISC+0, 6 
;RC_Car.c,60 :: 		TRISC |= (1<<7);
	BSF         TRISC+0, 7 
;RC_Car.c,61 :: 		TRISD = 0x00;
	CLRF        TRISD+0 
;RC_Car.c,63 :: 		PORTD = 0x00;
	CLRF        PORTD+0 
;RC_Car.c,65 :: 		UART_INIT();
	CALL        _UART_INIT+0, 0
;RC_Car.c,67 :: 		while(1){
L_main4:
;RC_Car.c,69 :: 		readBluetooth = UART_GET_CHARACTER();
	CALL        _UART_GET_CHARACTER+0, 0
	MOVF        R0, 0 
	MOVWF       _readBluetooth+0 
;RC_Car.c,70 :: 		switch (readBluetooth){
	GOTO        L_main6
;RC_Car.c,73 :: 		case 'F':
L_main8:
;RC_Car.c,74 :: 		Forward();
	CALL        _Forward+0, 0
;RC_Car.c,75 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main9:
	DECFSZ      R13, 1, 1
	BRA         L_main9
	DECFSZ      R12, 1, 1
	BRA         L_main9
	NOP
	NOP
;RC_Car.c,76 :: 		break;
	GOTO        L_main7
;RC_Car.c,79 :: 		case 'B':
L_main10:
;RC_Car.c,80 :: 		Backward();
	CALL        _Backward+0, 0
;RC_Car.c,81 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main11:
	DECFSZ      R13, 1, 1
	BRA         L_main11
	DECFSZ      R12, 1, 1
	BRA         L_main11
	NOP
	NOP
;RC_Car.c,82 :: 		break;
	GOTO        L_main7
;RC_Car.c,85 :: 		case 'R':
L_main12:
;RC_Car.c,86 :: 		Left();
	CALL        _Left+0, 0
;RC_Car.c,87 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main13:
	DECFSZ      R13, 1, 1
	BRA         L_main13
	DECFSZ      R12, 1, 1
	BRA         L_main13
	NOP
	NOP
;RC_Car.c,88 :: 		break;
	GOTO        L_main7
;RC_Car.c,91 :: 		case 'L':
L_main14:
;RC_Car.c,92 :: 		Right();
	CALL        _Right+0, 0
;RC_Car.c,93 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main15:
	DECFSZ      R13, 1, 1
	BRA         L_main15
	DECFSZ      R12, 1, 1
	BRA         L_main15
	NOP
	NOP
;RC_Car.c,94 :: 		break;
	GOTO        L_main7
;RC_Car.c,97 :: 		case 'S':
L_main16:
;RC_Car.c,98 :: 		Stop();
	CALL        _Stop+0, 0
;RC_Car.c,99 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	NOP
	NOP
;RC_Car.c,100 :: 		break;
	GOTO        L_main7
;RC_Car.c,101 :: 		}
L_main6:
	MOVF        _readBluetooth+0, 0 
	XORLW       70
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	MOVF        _readBluetooth+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVF        _readBluetooth+0, 0 
	XORLW       82
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        _readBluetooth+0, 0 
	XORLW       76
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVF        _readBluetooth+0, 0 
	XORLW       83
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
L_main7:
;RC_Car.c,102 :: 		}
	GOTO        L_main4
;RC_Car.c,103 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
