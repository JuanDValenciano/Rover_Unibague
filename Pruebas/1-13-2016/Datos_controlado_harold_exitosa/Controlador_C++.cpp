float Kc1=19.1305,Kc2=0.7503;
float Ki=-3.9074;

float Wt_Der=entrada deseada derecho,Wt_Iz=entrada deseada izquierdo;
float w_der,w_iz;

float Ui_der,Ui_iz;

float Ui_1_der,Ui_1_iz;

float error_der,error_iz;
float error_1_iz=0.0,error_1_der=0.0;

float Ut_der,Ut_iz;
float I_Der,I_Iz;

w_der=valor de velocidad derecho;
w_iz=Valor de velocidad izquierdo;

error_der=Wt_Der-w_der;
error_iz=Wt_Iz-w_iz;

Ui_der=(error_1_der*Ki+Ui_1_der);
Ui_iz=(error_1_iz*Ki+Ui_1_iz);

Ut_der=-Ui_der-Kc1*w_der-Kc2*I_Der;
Ut_iz=-Ui_iz-Kc1*w_iz-Kc2*I_Iz;


if(Ut_der>100)
	Ut_der=100;
if(Ut_der<-100)
	Ut_der=-100;

if(Ut_iz>100)
	Ut_iz=100;
if(Ut_iz<-100)
	Ut_iz=-100;

error_1_der=error_der;
error_1_iz=error_iz;
Ui_1_der=Ui_der;
Ui_1_iz=Ui_iz;