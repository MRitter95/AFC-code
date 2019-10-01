import os
import sys
import time

# We take advantage of the "Date modified" labels on our data files and folders
# to organize things; specifically, we use them to sort the scope traces into 
# the appropriate folders.

# Sometimes mistakes are made, and the dates modified change in such a way that
# the folders are no longer correctly ordered by that label. This program adds
# and removes a dummy file to each subfolder in such a way that they are once 
# again correctly ordered by their dates modified.

# Here, I have taken advantage of prior knowledge that we took two data sets,
# the first (second) in order of ascending (descending) frequency. In general,
# the order may not be so obvious. If that's the case, the most recent (for
# example) date modified of a file inside each folder could be used to
# determine the correct order.

loc= input('Which directory are you trying to reorder?')
os.chdir(loc)
order= input('Order files by ascending or descending frequency?(A/D)')
if order!='A' and order!='D':
    print('Choose one of the two options. For other sorting orders, you\'ll have to modify the program.')
    sys.exit(0)

allFolders= []
for root,dirs,files in os.walk(loc):
#    print(desiredOrder)
    for folder in dirs:
        allFolders.append(folder)
print('as randomly found (probably alphabetically): ',allFolders)

allFolders.sort(key=os.path.getmtime)
originalOrder= allFolders.copy()
print('sorted by date modified: ',originalOrder)

if order=='A':
    allFolders.sort(key=int)
else:
    allFolders.sort(reverse=True,key=int)
desiredOrder= allFolders.copy()
print('as desired: ',desiredOrder)

if originalOrder==desiredOrder:
    print('Nothing to do here.')
    sys.exit(0)
else:
    print('We\'ll have to reorder things.')

for j in range(len(allFolders)):
    os.chdir(os.path.join(loc,allFolders[j]))
    print(os.getcwd())
    f= open('dummy.txt','w')
    f.close()
    os.remove('dummy.txt')
#    note that this happens so fast that Windows Explorer apparently can't tell
#    that the folders are ordered at all: switching to ascending vs. descending
#    order of "date modified" has no effect, and it just orders the folders
#    numerically. This is why we do extra tests within this program to make sure
#    that Python can distinguish the dates modified (if it doesn't, the program
#    will say so at the end). If there are problems, include commented-out time
#    delay below, and be prepared to wait a while.
    time.sleep(0.1)
#    NOTE: there *were* problems. at the last step, the program finds the files
#    ordered correctly by date modified and claims success; but if the program
#    is run again, the the files are initially ordered wrong. adding the small 
#    delay above fixed the problem.
    
os.chdir(loc)
allFolders.sort(key=os.path.getmtime)
print('sorted by date modified: ',allFolders)

if allFolders==desiredOrder:
    print('Success!')
else:
    print('Reordering failed. Consider adding a time delay.')

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

