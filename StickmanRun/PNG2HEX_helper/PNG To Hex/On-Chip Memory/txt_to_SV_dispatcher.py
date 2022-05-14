#
# ECE385-HelperTools/PNG-To-Txt
# Author: Rishi Thakkar
#
# NOTE: Please do not change the folder structure that has been provided or the tool will not work as intended.
#

import os

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

welcomeString = "Welcome to Txt to SV Convertor\nAuthor: Rishi Thakkar\n\nThis tool is developed as a collaborative effort by the ECE 385 staff.\n" +  bcolors.WARNING + "Don't forget to cite any tools that you use in your final project.\n" + bcolors.ENDC
print(welcomeString)

print(bcolors.HEADER + bcolors.BOLD + bcolors.UNDERLINE + "Modes:" + bcolors.ENDC)
print(bcolors.OKGREEN + "Txt to SV(Normal) - " + bcolors.ENDC + bcolors.WARNING + "Mode 0" + bcolors.ENDC)
print(bcolors.OKGREEN + "Txt to SV 3 Channel(Channel Separated) - " + bcolors.ENDC + bcolors.WARNING + "Mode 1\n" + bcolors.ENDC)

print("The best way to figure out which mode to use is to look at the detailed notes at https://github.com/Atrifex/ECE385-HelperTools.")
print("Good luck and have fun with your projets!\n")

while(1):
    mode = int(input("Which mode of PNG to Txt would you like to use? Enter number 0 or 1: "))
    if mode == 0:
        #os.system("python3 ./scripts/png_to_txt.py")
        print("Mode still under development. Try again soon.")
        quit()
    elif mode == 1:
        os.system("python ./scripts/conv_to_sv.py")
        quit()
    else:
        print("Please enter a valid number.")

