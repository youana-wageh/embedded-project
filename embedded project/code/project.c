#define LSD porte.b0
#define MSD porte.b1
#define MANUAL portb.b0
#define SWITCH portb.b1
signed char count;
  unsigned char i;
void counter(signed char count){
    char left=count/10;
    char right=count%10;
    MSD=0; //npn transistor2 off
    LSD=1;// npn transistor1 on
    portc=right;
    delay_ms(10);
    LSD=0; //npn transistor1 off
    MSD=1;  //npn transistor2 on
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
      portd=0b00010001;
    }
  if(j==2){
       for(count=3;count>=0;count--){
       if(SWITCH==1) break;
        portd=0b00100001;
        for(i=0;i<50;i++){
         char left=count/10;
         char right=count%10;
         MSD=0;
         LSD=1;
         portc=right;
         delay_ms(10);
         LSD=0;
         MSD=1;
         portc=left;
         delay_ms(10);
    }
    }
    j=3;
  }
  if(j==3){
     portd=0b00001010;

  }if(j==4){
     for(count=3;count>=0;count--){
       if(SWITCH==1)break;
       portd=0b00001100;

      for(i=0;i<50;i++){
         char left=count/10;
         char right=count%10;
         MSD=0;
         LSD=1;
         portc=right;
         delay_ms(10);
         LSD=0;
         MSD=1;
         portc=left;
         delay_ms(10);
    }
    }
    j=1;
    portd=0b00010001;
  }
  
  



}

void main() {
  adcon1=7;
  trise=0;//transistors
  porte=0;
  trisd=0;// 7seg decoders
  portd=0;
  trisc=0;//traffic lights
  portc=0;
  trisb.b0=1;//SWITCH Button
  trisb.b1=1;//MANUAL Button
  gie_bit=1;
  inte_bit=1;
  intedg_bit=1;
  for(;;){
   if(SWITCH==1){
    for(count=15;count>=0;count--){
    if(SWITCH==0){
      portd=0b00000000;
      break;
     }
       if(count<=3){
         portd=0b00100001;//W.red & S.yellow
       }else{
         portd=0b00010001;//w.red & S.green
       }
       for(i=0;i<50;i++){
         counter(count);
       }

    }
    for(count=23;count>=0;count--){
    if(SWITCH==0){
     portd=0b00000000;
      break;
    }
       if(count<=3){
         portd=0b00001100;//S.red & W.yellow
       }else{
         portd=0b00001010;//S.red & W.green
       }
       for(i=0;i<50;i++){
         counter(count);
       }
    }
   }
  }
}