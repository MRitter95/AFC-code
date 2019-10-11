import os
import sys
import shutil

#os.chdir('C:/Users')
#print(os.getcwd())
#file_list= os.listdir(path='C:/Users/Lab')
#print(file_list)

#os.rename("C:/Users/Lab/Desktop/blah/blah20.txt","C:/Users/Lab/Desktop/blah/blahblah/blah20.txt")

source= input("Where are the files now? ")
target= input("Where are they going? Target folders will be identified by date modified. If these have been scrambled, then first run RESETDATEMODIFIED.PY. ")

###############################################################################
# find the already-created folders in the target location. Each of these


# subfolders corresponds to a modulation freq. and we'll send each AFC file
# to its respective subfolder.
#os.chdir(target)
#folders= os.listdir()
#folders.sort(key=os.path.getmtime)

# our latest improvements to the data acquisition allow us to do multiple runs,
# which might include repeats of the same modulation frequency -- so we now
# have to deal with one more layer of folders. It shouldn't ever be necessary,
# but if you want to add yet another layer of folders, it should be possible
# by adding another loop here:

os.chdir(target)
# modified next line by removing os.listdir argument. this line only works if
# current directory is TARGET. if it's not, including the os.listdir() argument
# will not save you. the program will run, but it will be looking in the 
# current directory, not TARGET. the commented-out line works, but only because
# of the previous line, where we changed working directory.
#dirs= filter(os.path.isdir,os.listdir(target))

dirs= filter(os.path.isdir,os.listdir())
dirs= [f for f in dirs]

folders= []
for f in dirs:
    os.chdir(os.path.join(target,f))
    subFolders= filter(os.path.isdir,os.listdir())
   
    folders= folders+[os.path.join(os.getcwd(),sf) for sf in subFolders]

folders.sort(key=os.path.getmtime)
###############################################################################

# A safety measure. Outputs the folder ordering that will be used to sort the
# files. Useful when the folders have been tampered with and dates modified
# potentially scrambled. 
print(*folders,sep='\n')
proceed= input('This is the folder ordering that will be used. OK? (Y/N)')
if(proceed=='Y'):
    print('OK. Checking folder count...')
else:
    print('Transfer aborted. See RESETDATEMODIFIED.PY to reorder folders.')
    sys.exit(0)

##############################################################################

# find the scope traces, which must be moved to the folders we just identified.


os.chdir(source)
files= os.listdir()
files.sort(key=os.path.getmtime)

# we distinguish blocks of files corresponding to a single mod. freq. by the
# date modified. when we come to a time interval larger than the threshold, 
# we assume this corresponds to the next mod. freq.

# 30 seconds is a safe threshold: the time interval between consecutive scope
# traces for the same setting is about 1 second.
threshold= 30
ends=[]
for j in range(len(files)-1):
    if abs(os.path.getmtime(os.path.join(os.getcwd(),files[j]))-os.path.getmtime(os.path.join(os.getcwd(),files[j+1])))>threshold:
       ends.append(j)
ends.append(len(files)-1)
print(ends)

###############################################################################

# a little safety measure: if the number of blocks of saved scope traces is not
# equal to the number of folders, there's a problem...
if len(folders)!= len(ends):
    print('\nERROR! Number of folders',len(folders),'does not match number of data sets',len(ends),'!')
    print('1. If they are slightly off, check that extra traces were not inexplicably saved at start of measurement. This has happened before...')
    print('2. If they are totally off, check the threshold for distinguishing between consecutive data sets.')
    print('   The program is currently using a',threshold,'-second threshold.')
    print('   Setting it to equal the number of saved OFC traces per setting should work well.')
    print('\nNo changes made, no sweat.\n')
    sys.exit(0)
else:
    print(len(ends),'data sets found for',len(folders),'folders. Proceeding with transfer:')
    
###############################################################################
# transfer blocks of files saved at the same time, ordered by date modified,
# into folders, also ordered by date modified.

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
        
        shutil.copy2(os.path.join(os.getcwd(),files[k]),os.path.join(folders[j],files[k]))

###############################################################################
# we often want to delete the files after the transfer, so change directories
# before exiting to make life easier.
os.chdir('C:/')
###############################################################################
# THE END