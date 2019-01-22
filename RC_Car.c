
#define _XTAL_FREQ 16000000
#define Baud_rate 9600

#define TX 6
#define RX 7
#define In1 0
#define In2 2
#define In3 1
#define In4 3

char readBluetooth;

void UART_INIT(){

    SPBRG = ((_XTAL_FREQ / 16) / Baud_rate) - 1;
    
    TXSTA = 0b00100100;    //Set TXEN bit to 1, TX9 bit to 0, SYNC bit to 0 & BRGH bit to 1
    RCSTA = 0b10010010;    //Set CERN bit to 1, RX9 bit to 0 & SPEN bit to 0
}

char UART_GET_CHARACTER(){

    while(!RCIF);
    return RCREG;
}

void Forward(){

    PORTD |= (1<<In1) | (1<<In3);
    PORTD &= ~((1<<In2) | (1<<In4));
}

void Backward(){

    PORTD &= ~((1<<In1) | (1<<In3));
    PORTD |= (1<<In2) | (1<<In4);
}

void Left(){
    PORTD &= ~((1<<In3) | (1<<In2) | (1<<In4));
    PORTD |= (1<<In1);
}

void Right(){

    PORTD &= ~((1<<In1) | (1<<In2) | (1<<In4));
    PORTD |= (1<<In3);
}

void Stop(){

    PORTD &= ~((1<<In1) | (1<<In3) | (1<<In2) | (1<<In4));
}


void main() {
    
    TRISC &= ~(1<<TX);
    TRISC |= (1<<RX);
    TRISD = 0x00;
    
    PORTD = 0x00;
    
    UART_INIT();

    while(1){
    
        readBluetooth = UART_GET_CHARACTER();
        switch (readBluetooth){

            //Condition for Forward
            case 'F':
                Forward();
                delay_ms(10);
                break;

            //Cndition for Backward
            case 'B':
                Backward();
                delay_ms(10);
                break;

            //Condition for Left
            case 'R':
                Left();
                delay_ms(10);
                break;

            //Condition for Right
            case 'L':
                Right();
                delay_ms(10);
                break;

            //Condition for Stop
            case 'S':
                Stop();
                delay_ms(10);
                break;
        }
    }
}