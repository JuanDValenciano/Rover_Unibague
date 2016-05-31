#include <Encoder.h>
#include "Filtro_Rover.h"
#include <TinyGPS++.h>
//--- Derecho ------------------------------------------------
#define Enc_A1  2 // Enable driver
#define Enc_A2  3 // Enable driver
//--- Izquierdo ----------------------------------------------
#define Enc_B1  20 // Enable driver
#define Enc_B2  21 // Enable driver

Encoder myEncA(Enc_A1, Enc_A2); //motor izquierdo.
Encoder myEncB(Enc_B1, Enc_B2); // motor derecho.

/////////////////// DECLARACION DE ESTRUCTURAS

struct S_Filtro Filtro_IZ;
struct S_Filtro Filtro_IDER;

struct S_Filtro Filtro_THRO;
struct S_Filtro Filtro_ELEV;

struct S_Filtro Filtro_WA;
struct S_Filtro Filtro_WB;

///////////////////////////////////////////////

// para el control DX8
const int THRO = 12;
const int ELEV = 11;
const int GEAR = 10;
const int AUX1 = 9;
const int AUX2 = 8;
const int AUX3 = 7;

float THRO_T;
float ELEV_T;
//float GEAR_T;
float AUX1_T;
//float AUX2_T;
//float AUX3_T;

//------------------------------------------------------------------
// variables de programa
const float Ts_slave=61000;
float tic,toc,t_elapsed;

// variables del encoder - velocidad
float t_startA,t_wA;
float t_startB,t_wB;
float angleA,wA;
float angleB,wB;
long  oldPositionA = 0.0;
long  newPositionA = 0.0;
long  oldPositionB  = 0.0;
long  newPositionB=0.0;
const float Resolution = (2.0*3.141516)/1440.0; //360 pasos por revolucion

// para mover los motores
float Motor_Vel_IZ,Motor_Vel_Der;

// lectura de sensores de Voltaje/Corriente
float Bateria,Motor_IZ,Motor_IZ_VRES,Motor_Der,Motor_Der_VRES;

const int Bateria_Pin   =  A0; 
const int Motor_IZ_Pin  =  A2;
const int Motor_Der_Pin =  A1;

//------------- para seguridad del programa
int salida=0;
int analizar=0;
int A;

float J=0;
// The TinyGPS++ ob	ect
TinyGPSPlus gps;
void setup() {
  Serial.begin(115200); // Raspberry
  Serial2.begin(9600);  //GPS
  
  // se define como entradas desde el puerto A0-A4
  pinMode(Bateria_Pin, INPUT);
  pinMode(Motor_IZ_Pin, INPUT);
  pinMode(Motor_Der_Pin, INPUT);
  
  // para el control DX8
  pinMode(THRO, INPUT);
  pinMode(ELEV, INPUT);
  pinMode(GEAR, INPUT);
  pinMode(AUX1, INPUT);
  pinMode(AUX2, INPUT);
  pinMode(AUX3, INPUT);

  filtro_reset(&Filtro_IZ);
  filtro_reset(&Filtro_IDER);
  
  filtro_reset(&Filtro_THRO);
  filtro_reset(&Filtro_ELEV);
  
  filtro_reset(&Filtro_WA);
  filtro_reset(&Filtro_WB);

}

void loop() {
  //tic=micros();
  
  
  if(Serial.available())
    A=Serial.read();
  
  
  if(A==77)
  {
//----- incio del control para enia   
  AUX1_T = pulseIn(AUX1, HIGH);
  
  
  if(AUX1_T<1000)  //para parada de emergencia
  {
    Serial.print("A");Serial.print(0.0);Serial.print("B");Serial.print(0.0);
    Serial.print("C");Serial.print(0.0);Serial.print("D");Serial.print(0.0);
    Serial.print("E");Serial.print(0.0);Serial.print("F");Serial.print(0.0);
    Serial.print("G");Serial.print(0.0);
    smartDelay(1);
    if (gps.location.isValid())
    {
    Serial.print("H");
    Serial.print(gps.location.lat(), 5);
    Serial.print("I");
    Serial.print(gps.location.lng(), 5);
    }
  else
    {
    Serial.print("H");
    Serial.print(0.0);
    Serial.print("I");
    Serial.print(0.0);
    }
    J = 0.00;
    Serial.print("J");Serial.print(J);
    Serial.print("Z");
    
  }
  else if(AUX1_T>1001 && AUX1_T<1900)
  {
    THRO_T = pulseIn(THRO, HIGH);
    ELEV_T = pulseIn(ELEV, HIGH);
    
    THRO_T = map(THRO_T,1525,1900,90,10);
    ELEV_T = map(ELEV_T,1525,1900,90,10);
  
    Motor_Vel_Der = map(ELEV_T,90,9,0,100);
    Motor_Vel_IZ = map(THRO_T,90,9,0,100);
  
    ELEV_T  = filtro_update(&Filtro_ELEV,ELEV_T);
    THRO_T  = filtro_update(&Filtro_THRO,THRO_T);
  
    velocidad();
    //-------------------- se usa y prcesa el puerto analogo --------------  
    entradas_analogas();
    //---------------------------------------------------------------------  
    // p es un valor entre 0 y 100% donde 0 es detenido y 100 es la maxima velocidad hacia adelante, para atras son los valores negativos.
    //po = map(p,0,100,90,9);
    //po1 = map(p1,0,100,90,9);
    //--------------------- GPS -------------------------------------------
    //---------------------------------------------------------------------
    //--------------------- leer encoder con filtro pasa_bajos ------------
    WA_read(); //motor izquierdo.
    WB_read(); // motor derecho.
    //---------------------------------------------------------------------  
    
    //Serial.println(" ");
    Serial.print("A");Serial.print(Motor_Vel_Der);Serial.print("B");Serial.print(Motor_Vel_IZ);
    Serial.print("C");Serial.print(Bateria);Serial.print("D");Serial.print(Motor_Der);
    Serial.print("E");Serial.print(Motor_IZ);Serial.print("F");Serial.print(wA);
    Serial.print("G");Serial.print(wB);//Serial.print("H");Serial.print(1.0);Serial.print("Z");//00.0B00.0C00.0D00.0E00.0F00.0G00.0H00.0I1.0Z");  
    smartDelay(1);
    if (gps.location.isValid())
    {
    Serial.print("H");
    Serial.print(gps.location.lat(), 5);
    Serial.print("I");
    Serial.print(gps.location.lng(), 5);
    }
  else
    {
    Serial.print("H");
    Serial.print(0.0);
    Serial.print("I");
    Serial.print(0.0);
    }
    J=1.00;
    Serial.print("J");Serial.print(J);
    Serial.print("Z");
    
  }
  else if(AUX1_T>1901)
  {
	THRO_T = pulseIn(THRO, HIGH);
    ELEV_T = pulseIn(ELEV, HIGH);
    
    THRO_T = map(THRO_T,1525,1900,90,10);
    ELEV_T = map(ELEV_T,1525,1900,90,10);
  
    Motor_Vel_Der = map(ELEV_T,90,9,0,100);
    Motor_Vel_IZ = map(THRO_T,90,9,0,100);
  
    ELEV_T  = filtro_update(&Filtro_ELEV,ELEV_T);
    THRO_T  = filtro_update(&Filtro_THRO,THRO_T);
    //-------------------- se usa y prcesa el puerto analogo --------------  
    entradas_analogas();
    //---------------------------------------------------------------------  
    // p es un valor entre 0 y 100% donde 0 es detenido y 100 es la maxima velocidad hacia adelante, para atras son los valores negativos.
    //po = map(p,0,100,90,9);
    //po1 = map(p1,0,100,90,9);
    //--------------------- GPS -------------------------------------------
    //---------------------------------------------------------------------
    //--------------------- leer encoder con filtro pasa_bajos ------------
    WA_read(); //motor izquierdo.
    WB_read(); // motor derecho.
    //---------------------------------------------------------------------  
    Serial.print("A");Serial.print(Motor_Vel_Der);Serial.print("B");Serial.print(Motor_Vel_IZ);
    Serial.print("C");Serial.print(Bateria);Serial.print("D");Serial.print(Motor_Der);
    Serial.print("E");Serial.print(Motor_IZ);Serial.print("F");Serial.print(wA);
    Serial.print("G");Serial.print(wB);//Serial.print("H");Serial.print(1.0);Serial.print("Z");//00.0B00.0C00.0D00.0E00.0F00.0G00.0H00.0I1.0Z"); 
    smartDelay(1);
    if (gps.location.isValid())
    {
    Serial.print("H");
    Serial.print(gps.location.lat(), 5);
    Serial.print("I");
    Serial.print(gps.location.lng(), 5);
    }
  else
    {
    Serial.print("H");
    Serial.print(0.0);
    Serial.print("I");
    Serial.print(0.0);
    }
    J = 2.0;
    Serial.print("J");Serial.print(J);
    Serial.print("Z");
  }  
  
  A = 0;
  }
  
}

void WA_read(){
    newPositionA = myEncA.read();
    
  if (newPositionA != oldPositionA){
    t_wA=(micros()-t_startA)/1E6;
    t_startA=micros();
    angleA=(newPositionA-oldPositionA)*Resolution;
    oldPositionA = newPositionA;
    
    // FILTRO
    wA=angleA/t_wA;    // rads/sec
	
    wA = filtro_update(&Filtro_WA,wA);
	
//    WA_[0]=WA_[1];
//    WA_[1]=WA_[2];
//    WA_[2]=wA;
//    wA=filt_B[0]*WA_[1]+filt_B[1]*WA_[0]-filt_A[0]*WA_filt[1];
//    
//    WA_filt[0]=WA_filt[1];
//    WA_filt[1]=WA_filt[2];
//    WA_filt[2]=wA;
//    
    }
  else{
  t_wA=(micros()-t_startA)/1E6;
  //t_wA=Ts_slave;
  wA=(angleA/t_wA)*3;   
  } 
}

void WB_read(){
  newPositionB = myEncB.read();
  
  if (newPositionB != oldPositionB) {
    t_wB=(micros()-t_startB)/1E6;
    t_startB=micros();
    angleB=(newPositionB-oldPositionB)*Resolution;
    oldPositionB = newPositionB;
    
    wB=angleB/t_wB;    //rads/sec
    
    wB = filtro_update(&Filtro_WB,wB);
    
//    //FILTRO
//    WB_[0]=WB_[1];
//    WB_[1]=WB_[2];
//    WB_[2]=wB;
//    wB=filt_B[0]*WB_[1]+filt_B[1]*WB_[0]-filt_A[0]*WB_filt[1];
//    
//    WB_filt[0]=WB_filt[1];
//    WB_filt[1]=WB_filt[2];
//    WB_filt[2]=wB;
    
  } else{
    t_wB=(micros()-t_startB)/1E6;
    wB=(angleB/t_wB)*3;
  }
}

void velocidad()
{
 if(Motor_Vel_IZ > 100)
     Motor_Vel_IZ = 100;
 if(Motor_Vel_IZ < -100)
     Motor_Vel_IZ = -100;
 if(Motor_Vel_Der > 100)
     Motor_Vel_Der = 100;
 if(Motor_Vel_Der < -100)
     Motor_Vel_Der = -100;
}

void entradas_analogas()
{
  //--------------------------------------------------------------------- 
// Se calcula el valor de voltaje de bateria y corrientes--------------
  Bateria = analogRead(Bateria_Pin);
  Bateria=Bateria*(5.0/1023.0);
  Bateria = Bateria/(5490.0/(5490.0+10090.0));
  
  Motor_IZ = analogRead(Motor_IZ_Pin);
  
  Motor_IZ = Motor_IZ *(5.0/1024.0);
  Motor_IZ = (Motor_IZ - 2.5)/0.028;// lienas de prueba
  
  Motor_Der = analogRead(Motor_Der_Pin);
  
  Motor_Der = Motor_Der *(5.0/1024.0);
  Motor_Der = (Motor_Der - 2.5)/0.028;
  
  Motor_IZ  = filtro_update(&Filtro_IZ,Motor_IZ);
  Motor_Der = filtro_update(&Filtro_IDER,Motor_Der);
}
static void smartDelay(unsigned long ms)
{
  unsigned long start = millis();
  do 
  {
    while (Serial2.available())
      gps.encode(Serial2.read());
  } while (millis() - start < ms);
}

