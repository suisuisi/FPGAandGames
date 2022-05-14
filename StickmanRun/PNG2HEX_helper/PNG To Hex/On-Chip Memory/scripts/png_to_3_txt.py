from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
filename = str(input("What's the image name? "))

im = Image.open("./sprite_originals/" + filename + ".png") #Can be many different formats.
im = im.convert("RGBA")

outImgR = Image.new('RGB', im.size, color='white')
outFileR = open("./sprite_bytes/" + filename + 'R.txt', 'w')
outImgG = Image.new('RGB', im.size, color='white')
outFileG = open("./sprite_bytes/" + filename + 'G.txt', 'w')
outImgB = Image.new('RGB', im.size, color='white')
outFileB = open("./sprite_bytes/" + filename + 'B.txt', 'w')

for y in range(im.size[1]):
    for x in range(im.size[0]):
        pixel = im.getpixel((x,y))
        print(pixel)
        r, g, b, a = im.getpixel((x,y))
        pixelR  = (r, 0, 0, 255)
        pixelG = (0, g, 0, 255)
        pixelB = (0, 0, b, 255)
        outImgR.putpixel((x,y), pixelR)
        outImgG.putpixel((x,y), pixelG)
        outImgB.putpixel((x,y), pixelB)
        outFileR.write("%x\n" %(r))
        outFileG.write("%x\n" %(g))
        outFileB.write("%x\n" %(b))
outFileR.close()
outFileB.close()
outFileG.close()
outImgR.save("./sprite_converted/" + filename + 'R.png')
outImgG.save("./sprite_converted/" + filename + 'G.png')
outImgB.save("./sprite_converted/" + filename + 'B.png')
