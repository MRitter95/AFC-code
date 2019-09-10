#import os
#import sys

import shutil

#os.chdir('C:/Users')
#print(os.getcwd())
#file_list= os.listdir(path='C:/Users/Lab')
#print(file_list)

#os.rename("F:\\blahblah","F:\\sothisworks.txt")
shutil.copy2('F:\\sothisworks.txt', 'C:\\Users\\Lab\\Desktop\\yayy.txt')  

#source= input("Where are the files now? Use forward slashes: ")
#target= input("Where are they going? Subfolders (and *only* subfolders) must already exist at target. NOTE: targets distinguished by date modified -- be sure that folders have not been edited since running of LabVIEW code: ")

#os.chdir(target)
#folders= os.listdir()
#folders.sort(key=os.path.getmtime)
#
#os.chdir(source)
#files= os.listdir()
#files.sort(key=os.path.getmtime)
#
#ends=[]
#for j in range(len(files)-1):
#    if abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1])))>30:
#       ends.append(j)
#ends.append(len(files)-1)
#print(ends)
#
#if len(folders)!= len(ends):
#    print("ERROR! NO FILES MOVED: NUMBER OF FOLDERS",len(folders),"DOES NOT MATCH NUMBER OF DATA SETS",len(ends),"!")
#    sys.exit(0)
#    
#for j in range(len(ends)):
#    subTarget= target+"/"+folders[j]
#    #os.mkdir(subTarget)
#    if j==0:
#        start= 0
#    else:
#        start= ends[j-1]+1
#    for k in range(start,ends[j]+1):
#        os.rename(os.path.join(os.getcwd(),files[k]),os.path.join(subTarget,files[k]))
#
##for j in range(len(files)-1):
##    if abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1])))<30:
##       os.rename(os.path.join(os.getcwd(),files[j]),os.path.join(os.getcwd(),'1000khz\\'+files[j]))
##    else:
##       print(j+1,abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1]))))
##       