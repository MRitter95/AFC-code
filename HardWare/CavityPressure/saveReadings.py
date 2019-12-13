# this program plots the outputs of 4 Arduino sensors in real time,
# while listening for keyboard input (stop program, clear plots).
# I don't understand how it works.
# see here for the code I copied:
# https://stackoverflow.com/questions/49550355/how-to-stop-a-program-when-a-key-is-pressed-in-python

from pynput import keyboard
import time
from datetime import datetime
import serial
import os
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

##################################################

# I think the initial ser.close() is unnecessary, but just copied from online 
ser = serial.Serial('COM6',9600,timeout=0)
ser.close()
ser.open()

os.chdir("C:/Users/labadmin/Desktop/Data/CavityPressure/")
filename= str(datetime.now())[0:10]
file= open(filename+".txt","a")

with keyboard.Listener(on_press=on_press) as listener:
    while break_program == False:
        time.sleep(1)
        numBytes= ser.inWaiting()
#        print(numBytes,'bytes buffered')
        
        if numBytes>0:
            buffer= ser.read(numBytes)
            buffer= buffer.split()
            
            numLines= len(buffer)

            if numLines>=1:
                line= str(buffer[-1])
                line= line[2:len(line)-1]

                print(datetime.now(), 10**(2*float(line)-5))
                file.write(str(datetime.now())+"\t"+str(10**(2*float(line)-5))+"\n")
                print ('press Esc to exit,')
                
            # checks to see if plots should be cleared
            
    listener.join()

file.close()
ser.close()