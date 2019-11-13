# this program plots the outputs of 4 Arduino sensors in real time,
# while listening for keyboard input (stop program, clear plots).
# I don't understand how it works.
# see here for the code I copied:
# https://stackoverflow.com/questions/49550355/how-to-stop-a-program-when-a-key-is-pressed-in-python

from pynput import keyboard
import time
import serial
import matplotlib.pyplot as plt
import numpy as np
##################################################
# global vars & function for listening to keyboard
break_program= False
clear_plot= False

def on_press(key):
    global break_program
    global clear_plot
        
    # listen for Esc, exit if it's pressed.
    if key == keyboard.Key.esc:
        print ('esc pressed. exiting...')
        break_program = True
        return False
    
    # listen for Home, clear plots if it's pressed
    if key == keyboard.Key.ctrl_r:
        print('home pressed. clearing plot...')
        clear_plot= True
##################################################

# arrays for all the data       
# time array (horizontal axis)
t=list()

# B field arrays for each component, for each sensor
B1_x= list()
B1_y= list()
B1_z= list()

B2_x= list()
B2_y= list()
B2_z= list()

B3_x= list()
B3_y= list()
B3_z= list()

B4_x= list()
B4_y= list()
B4_z= list()

# I think the initial ser.close() is unnecessary, but just copied from online 
ser = serial.Serial('COM3',9600,timeout=0)
ser.close()
ser.open()

# index of the current point in the plot
i=0

with keyboard.Listener(on_press=on_press) as listener:
    while break_program == False:
        time.sleep(0.3)
        numBytes= ser.inWaiting()
#        print(numBytes,'bytes buffered')
        
        if numBytes>0:
            buffer= ser.read(numBytes)
            buffer= buffer.split()
            
            numLines= len(buffer)

            toPlot= np.zeros(12)
            
            if numLines>=3:
                buffer= buffer[1:-1]
                numLines= len(buffer)

                for j in range(numLines):
                    line= str(buffer[j])
#                    print(line)
                    line= line[2:len(line)-1]
                    line= line.split(",")
#                    print(line)
                    
                    for k in range(12):
                        toPlot[k]= toPlot[k]+float(line[k])/numLines

#                print(toPlot)
#            
##            buffer= buffer[2:len(buffer)-1]
##            buffer= buffer.split(",")
#            print(buffer)
            
            # append current measurement to history for plot
                t.append(i)
                B1_x.append(toPlot[0])
                B1_y.append(toPlot[1])
                B1_z.append(toPlot[2])
            
                B2_x.append(toPlot[3])
                B2_y.append(toPlot[4])
                B2_z.append(toPlot[5])
            
                B3_x.append(toPlot[6])
                B3_y.append(toPlot[7])
                B3_z.append(toPlot[8])
            
                B4_x.append(toPlot[9])
                B4_y.append(toPlot[10])
                B4_z.append(toPlot[11])      
        
            # set plot size
                fig=plt.figure(figsize=(20,13))
            
            # subplot(4,3,1) means:
            # subplot array is 4x3 for 4 sensors, 3 B components;
            # currently dealing with subplot #1.
            
            # zomg so many plots!
            #sensor 1
                plt.subplot(4,3,1)
                plt.plot(t,B1_x,'r')
                plt.subplot(4,3,2)
                plt.plot(t,B1_y,'g')
                plt.subplot(4,3,3)
                plt.plot(t,B1_z,'b')
            
            #sensor 2
                plt.subplot(4,3,4)
                plt.plot(t,B2_x,'r')
                plt.subplot(4,3,5)
                plt.plot(t,B2_y,'g')
                plt.subplot(4,3,6)
                plt.plot(t,B2_z,'b')
                
            #sensor 3
                plt.subplot(4,3,7)        
                plt.plot(t,B3_x,'r')
                plt.subplot(4,3,8)
                plt.plot(t,B3_y,'g')
                plt.subplot(4,3,9)
                plt.plot(t,B3_z,'b')
            
            #sensor 4
                plt.subplot(4,3,10)
                plt.plot(t,B4_x,'r')
                plt.subplot(4,3,11)
                plt.plot(t,B4_y,'g')
                plt.subplot(4,3,12)
                plt.plot(t,B4_z,'b')
            
                i += 1
            
                plt.show()
                print('now displaying ',i,' points.')
                print('last point averaged ',numLines,' lines.')
                print ('press Esc to exit,')
                print('right Ctrl to clear plots.')
            
            # checks to see if plots should be cleared
        if clear_plot == True:
            t= list()
            B1_x= list()
            B1_y= list()
            B1_z= list()
            
            B2_x= list()
            B2_y= list()
            B2_z= list()
            
            B3_x= list()
            B3_y= list()
            B3_z= list()
            
            B4_x= list()
            B4_y= list()
            B4_z= list()
            
            clear_plot= False
            i= 0
            
    listener.join()

ser.close()