/* archivo fuente.
libreria con filtro disenado en matlab por Harold Murcia
y Juan D Valenciano.

agosto 13 2015

este codigo es de dominio publico.
*/
#include "Filtro_Rover.h"


void filtro_reset(struct S_Filtro *Filtro_Rover) {
    Filtro_Rover->S = 0.0;	
    Filtro_Rover->S_1 = 0.0;
    Filtro_Rover->S_2 = 0.0;
}

float filtro_update(struct S_Filtro *Filtro_Rover, float E){

  Filtro_Rover->S = -(Filtro_Rover->S_1*Filtro_Rover->filt_A[1])-(Filtro_Rover->S_2*Filtro_Rover->filt_A[2])+(E*Filtro_Rover->filt_B[0])+(Filtro_Rover->E_1*Filtro_Rover->filt_B[1])+(Filtro_Rover->E_2*Filtro_Rover->filt_B[2]);
  
  Filtro_Rover->S_2=Filtro_Rover->S_1;
  Filtro_Rover->S_1=Filtro_Rover->S;
  
  Filtro_Rover->E_2=Filtro_Rover->E_1;
  Filtro_Rover->E_1=E;

  return Filtro_Rover->S;

}