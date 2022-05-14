## This code generate a txt version file for a wav music file
## Which can be used for the FPGA audio module
## Author: Ge Yuhao

import numpy as np
import wave

music = wave.open("C:/Users/Howar/Desktop/mj.wav", 'r')
signal = music.readframes(-1)

soundwave = np.frombuffer(signal, dtype="uint16")

with open("C:/Users/Howar/Desktop/mj.txt","w") as f:
    for i in soundwave:
        f.write('{:04X}'.format(i))
        f.write("\n")