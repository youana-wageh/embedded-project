
#define MSD porte.b0
#define LSD porte.b1
#define MANUAL portb.b0
#define SWITCH portb.b1
signed char count;
  unsigned char i;
void counter(signed char count){
    char left=count/10;
    char right=count%10;
    MSD=1;
    LSD=0;
    portc=right;
    delay_ms(10);
    LSD=1;
    MSD=0;
    portc=left;
    delay_ms(10);
}
int j=0;
void interrupt(){
  if(intf_bit==1){
    intf_bit=0;
    j++;
  }
  if(j==1){

    for(count=3;count>=0;count--){
        portd=0b00100001;
        for(i=0;i<50;i++){
         char left=count/10;
         char right=count%10;
         MSD=1;
         LSD=0;
         portc=right;
         delay_ms(10);
         LSD=1;
         MSD=0;
         portc=left;
         delay_ms(10);

    }
    }
    j=2;
  }else if(j==2){
    portd=0b00001010;
    delay_ms(1000);
  }else if(j==3){
    for(count=3;count>=0;count--){
        portd=0b00001100;

    for(i=0;i<50;i++){
         char left=count/10;
         char right=count%10;
         MSD=1;
         LSD=0;
         portc=right;
         delay_ms(10);
         LSD=1;
         MSD=0;
         portc=left;
         delay_ms(10);
    }
    }
    j=0;
  }
  
  



}

void main() {
  adcon1=7;
  trise=0;
  porte=0;
  trisd=0;
  portd=0;
  trisc=0;
  portc=0;
  trisb.b0=1;
  trisb.b1=1;
  gie_bit=1;
  inte_bit=1;
  intedg_bit=1;
  for(;;){
   if(SWITCH==1){
    for(count=15;count>=0;count--){
    if(SWITCH==0) break;
       if(count<=3){
         portd=0b00100001;
       }else{
         portd=0b00010001;
       }
       for(i=0;i<50;i++){
         counter(count);
       }

    }
    for(count=23;count>=0;count--){
    if(SWITCH==0)break;
       if(count<=3){
         portd=0b00001100;
       }else{
         portd=0b00001010;
       }
       for(i=0;i<50;i++){
         counter(count);
       }
    }
   }
   if(SWITCH==0){
      portd=0b00010001;
   }
  }
}