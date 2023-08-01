#line 1 "C:/Users/20120/OneDrive/Desktop/embedded project/code/project.c"




signed char count;
 unsigned char i;
void counter(signed char count){
 char left=count/10;
 char right=count%10;
  porte.b1 =0;
  porte.b0 =1;
 portc=right;
 delay_ms(10);
  porte.b0 =0;
  porte.b1 =1;
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
 if( portb.b1 ==1) break;
 portd=0b00100001;
 for(i=0;i<50;i++){
 char left=count/10;
 char right=count%10;
  porte.b1 =0;
  porte.b0 =1;
 portc=right;
 delay_ms(10);
  porte.b0 =0;
  porte.b1 =1;
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
 if( portb.b1 ==1)break;
 portd=0b00001100;

 for(i=0;i<50;i++){
 char left=count/10;
 char right=count%10;
  porte.b1 =0;
  porte.b0 =1;
 portc=right;
 delay_ms(10);
  porte.b0 =0;
  porte.b1 =1;
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
 if( portb.b1 ==1){
 for(count=15;count>=0;count--){
 if( portb.b1 ==0){
 portd=0b00000000;
 break;
 }
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
 if( portb.b1 ==0){
 portd=0b00000000;
 break;
 }
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
 }
}
