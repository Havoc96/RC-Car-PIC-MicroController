#line 1 "D:/I__Projects/RC_Car_PIC/RC_Car.c"




char readBluetooth;

void TEST(){
 PORTD |= (1<<6);
 delay_ms(1000);
 PORTD &= ~(1<<6);
 delay_ms(1000);
}

void UART_INIT(){

 SPBRG = (( 16000000  / 16) /  9600 ) - 1;

 TXSTA = 0b00100100;
 RCSTA = 0b10010010;
}

char UART_GET_CHARACTER(){

 while(!RCIF);
 return RCREG;
}

void Forward(){

 PORTD |= (1<<0) | (1<<1);
 PORTD &= ~((1<<2) | (1<<3));
}

void Backward(){

 PORTD &= ~((1<<0) | (1<<1));
 PORTD |= (1<<2) | (1<<3);
}

void Left(){
 PORTD &= ~((1<<1) | (1<<2) | (1<<3));
 PORTD |= (1<<0);
}

void Right(){

 PORTD &= ~((1<<0) | (1<<2) | (1<<3));
 PORTD |= (1<<1);
}

void Stop(){

 PORTD &= ~((1<<0) | (1<<1) | (1<<2) | (1<<3));
}


void main() {

 TRISC &= ~(1<<6);
 TRISC |= (1<<7);
 TRISD = 0x00;

 PORTD = 0x00;

 UART_INIT();

 while(1){

 readBluetooth = UART_GET_CHARACTER();
 switch (readBluetooth){


 case 'F':
 Forward();
 delay_ms(10);
 break;


 case 'B':
 Backward();
 delay_ms(10);
 break;


 case 'R':
 Left();
 delay_ms(10);
 break;


 case 'L':
 Right();
 delay_ms(10);
 break;


 case 'S':
 Stop();
 delay_ms(10);
 break;
 }
 }
}
