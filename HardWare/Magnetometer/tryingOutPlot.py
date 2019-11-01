import serial
import matplotlib.pyplot as plt
import threading

def input_thread(a_list):
    input()
    a_list.append(True)


plt.ion()
fig=plt.figure()

x=list()
y=list()

ser = serial.Serial('COM10',9600)
ser.close()
ser.open()

a_list = []
threading.start_new_thread(input_thread, (a_list,))    

i= 0
while not a_list:
    data = ser.readline()
    print(data.decode())
    x.append(i)
    y.append(data.decode())

    plt.scatter(x,y)
    i += 1
    plt.show()
    plt.pause(0.0001)  # Note this correction