// SimpSamp.cpp : Defines the entry point for the console application.
//
#include "stdio.h"
#include "stdlib.h"

#include "stdafx.h"
#include "cldevdll.h"

#define COMM_PORT 3
int DevHandle = NULL;

int main(int argc, char* argv[])
{
	double Wavelen;
	float Power;
	int CommPort = 0;

	if(argc >= 2)
		sscanf(argv[1], "%d", &CommPort);
	
	if(!CommPort)
		CommPort = COMM_PORT;

	DevHandle = CLOpenUSBSerialDevice(CommPort);

	if(DevHandle != -1)
	{
		Wavelen = CLGetLambdaReading(DevHandle);
		Power = CLGetPowerReading(DevHandle);
		printf("Wavelength : %lf, power : %f\n",Wavelen, Power);
		CLCloseDevice(DevHandle);
	}
	else
		printf("Error opening port %d", CommPort);

	return 0;
}

