/* archivo de cabecera.
libreria con filtro disenado en matlab por Harold Murcia
y Juan D Valenciano.

agosto 13 2015

este codigo es de dominio publico.
*/

#ifndef Filtro_Rover_h
#define Filtro_Rover_h


struct S_Filtro{
	float filt_A[3]={1.0000,-1.2247,0.4504};
        float filt_B[3]={0.0564,0.1129,0.0564};
	float S;
	float S_1;
	float S_2;
	float E_1;
	float E_2;
};

void filtro_reset(struct S_Filtro *Filtro_Rover);

float filtro_update(struct S_Filtro *Filtro_Rover, float E);

#endif
