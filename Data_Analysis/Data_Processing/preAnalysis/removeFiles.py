import os
import sys

# Sometimes mistakes are made. Files are incorrectly moved to folders, and
# manually undoing it would be too tedious. This program removes all files
# whose names start with a certain character and deletes them. If there are
# files in this directory that you don't want to delete, but whose names start
# with the same character, you can modify the program to look for a match in
# the first N characters of the filename instead...

loc= input('Which directory are you trying to clean up?')
startCharacter= input('What is the first character of the names of the files you wish to delete?')
print('Deleting all files starting with ',startCharacter,' in ',loc,': ')
sure= input('Are you sure? (Y/N)')

if sure!='Y':
    print('Aborted')
    sys.exit(0)
else:
    print('Confirmed.')

n=0
for root,dirs,files in os.walk(loc):
    for f in files:
        if f.startswith(startCharacter):
            print(os.path.join(root,f))
            os.remove(os.path.join(root,f))
            n=n+1
            
print(n,' files have been deleted.')
###############################################################################
# THE END











#folders= filter(os.path.isdir,os.listdir(target))
#folders= [f for f in folders]
##folderList= [os.path.join(target,f) for f in folders]
#
#print("these are the folders",folders)
#
#n=0
#allDirs= []
#for f in folders:
#    os.chdir(os.path.join(target,f))
#    subFolders= filter(os.path.isdir,os.listdir())
##    subFolders= [sf for sf in subFolders]
##    print("these are the subfolders",subFolders)
#    
#    allDirs= allDirs+[os.path.join(os.getcwd(),sf) for sf in subFolders]
#    n+=1
#    print(n)
#
#allDirs.sort(key=os.path.getmtime)
#
#print(len(allDirs),allDirs)




#folders= os.listdir()
#folders.sort(key=os.path.getmtime)

#print(folders)
#print(len(folders))

#print([x[0] for x in os.walk(target)])
#print(next(os.walk(target))[1][0])
#
#print(next(os.walk(target))[1][1])
#
#print(next(os.walk(target))[1][2])
#
#os.chdir(os.path.join(target,next(os.walk(target))[1][0]))
#
#print(next(os.walk(os.getcwd()))[1])
#
#os.chdir(os.path.join(target,next(os.walk(target))[1][1]))
#
#print(next(os.walk(os.getcwd()))[1])
#
#os.chdir(os.path.join(target,next(os.walk(target))[1][2]))
#
#print(next(os.walk(os.getcwd()))[1])

