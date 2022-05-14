#
# ECE385-HelperTools/PNG-To-Txt
# Author: Rishi Thakkar
#
# NOTE: Please do not change the folder structure that has been provided or the tool will not work as intended.
#

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

import os

welcomeString = "Welcome to PNG to Txt Convertor\nAuthor: Rishi Thakkar\n\nThis tool is developed as a collaborative effort by the ECE 385 staff.\nDon't forget to cite any tools that you use in your final project.\n" +  bcolors.WARNING + "IMPORTANT NOTE: This script has been optimized to work on windows ews computers. You will need to make minor changes to get it to work elsewhere.\n" + bcolors.ENDC
print(welcomeString)

print(bcolors.HEADER + bcolors.BOLD + bcolors.UNDERLINE + "Modes:" + bcolors.ENDC)
print(bcolors.OKGREEN + "PNG to Txt(Normal) - " + bcolors.ENDC + bcolors.WARNING + "Mode 0" + bcolors.ENDC)
print(bcolors.OKGREEN + "PNG to 3 Txt(Channel Separation) - " + bcolors.ENDC + bcolors.WARNING + "Mode 1" + bcolors.ENDC)
print(bcolors.OKGREEN + "PNG to Palette with resizing - " + bcolors.ENDC + bcolors.WARNING + "Mode 2" + bcolors.ENDC)
print(bcolors.OKGREEN + "PNG to Palette with relative resizing - " + bcolors.ENDC + bcolors.WARNING + "Mode 3\n" + bcolors.ENDC)

print("The best way to figure out which mode to use is to look at the detailed notes at https://github.com/Atrifex/ECE385-HelperTools.")
print("Good luck and have fun with your projets!\n")

while(1):
    mode = int(input("Which mode of PNG to Txt would you like to use? Enter number between 0-3: "))
    if mode == 0:
        os.system("python ./scripts/png_to_txt.py")
        break
    elif mode == 1:
        os.system("python ./scripts/png_to_3_txt.py")
        break
    elif mode == 2:
        os.system("python ./scripts/png_to_palette_resizer.py")
        break
    elif mode == 3:
        os.system("python ./scripts/png_to_palette_relative_resizer.py")
        break
    else:
        print("Please enter a valid number.")
