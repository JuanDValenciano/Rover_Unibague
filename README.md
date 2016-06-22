# Rover_Unibague

En estos repositorios se encuentra todo lo necesario para colocar en marcha el Robot de la universidad de Ibagué(Rover),  



# Raspberry Pi - Arduino

El robot cuenta con una Raspberry Pi 2 con un escudo Navio+, la cual dota al embebido con una serie de sensores como accelerometro(x,y,z), giroscopio(x,y,z) y magnetómetro(x,y,z) además de algunas características fanáticas, para conocer un poco más dejo el link de la tarjeta: www.emlid.com
Además se usa un Arduino el cual lo único que se encarga de hacer es recolectar información de los encoder, sensores de corriente, y señales del control Spektrum x8.

# Librerías externas.

Claramente se deben de usar las librerías para la Navio+ https://docs.emlid.com/navio/Navio-dev/navio-repository-cloning/  ,además las librerías para usar los puertos Rs-232, esta librería me parece muy buena y fácil de usar: http://www.teuniz.net/RS-232/index.html , para el cálculo de matrices del controladores se usa una librería externa para las operaciones matemáticas con matrices http://eigen.tuxfamily.org/ , estan son las librerias bases para que el robot este operativo

# Calibración Magnética.


 

