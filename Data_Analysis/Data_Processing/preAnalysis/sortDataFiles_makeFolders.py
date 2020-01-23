import os
import shutil

#os.chdir('C:/Users')
#print(os.getcwd())
#file_list= os.listdir(path='C:/Users/Lab')
#print(file_list)

#os.rename("C:/Users/Lab/Desktop/blah/blah20.txt","C:/Users/Lab/Desktop/blah/blahblah/blah20.txt")

os.chdir(input("Specify directory with files, using forward slashes: "))
target= input("Specify destination directory (subfolders will be generated automatically): ")
#os.chdir("C:/Users/Lab/Desktop/scopeTraces/")
files= os.listdir()
files.sort(key=os.path.getmtime)

#for j in files:
#    print(j,os.path.getmtime(os.path.join(os.getcwd(),j)))

ends=[]
for j in range(len(files)-1):
    if abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1])))>60:
       ends.append(j)
ends.append(len(files)-1)
print(ends)

for j in range(len(ends)):
#    subTarget= target+"/"+folders[j]
    #os.mkdir(subTarget)
    print('Now transferring set ',j+1,' of ',len(ends))
    if j==0:
        start= 0
    else:
        start= ends[j-1]+1
    for k in range(start,ends[j]+1):
#        os.rename(os.path.join(os.getcwd(),files[k]),os.path.join(subTarget,files[k]))
        
        shutil.copy2(os.path.join(os.getcwd(),files[k]),os.path.join(target+"/"+str(10000+j),files[k]))





#for j in range(len(files)-1):
#    if abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1])))<30:
#       os.rename(os.path.join(os.getcwd(),files[j]),os.path.join(os.getcwd(),'1000khz\\'+files[j]))
#    else:
#       print(j+1,abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1]))))
#       