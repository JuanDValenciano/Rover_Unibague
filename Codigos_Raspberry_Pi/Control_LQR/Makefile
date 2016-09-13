CC = g++
CFLAGS=-c -Wall
NAVIO = ../../Navio
INCLUDES = -I ../..

all:
	sudo  $(CC) Control_Kalman_Yaw.cpp library/rs232.c library/MPU9250.cpp library/an_packet_protocol.c library/orientus_packets.c library/PCA9685.cpp library/I2Cdev.cpp library/gpio.cpp -fpermissive -Wall -Wextra -o2 -o Rover -lrt -lpthread
clean:
	rm Rover
