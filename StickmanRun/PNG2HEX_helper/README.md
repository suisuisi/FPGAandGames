<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org77f3d70">1. Introduction</a></li>
<li><a href="#org514dda5">2. Documentation Format</a></li>
<li><a href="#org104f575">3. PNG To Hex Converter</a>
<ul>
<li><a href="#orgce49921">3.1. Motivation</a></li>
<li><a href="#org8d20aef">3.2. Contents</a></li>
<li><a href="#org63f0eac">3.3. Video Tutorial</a></li>
<li><a href="#orgb9e055e">3.4. How To Use: Step-by-Step Instructions</a>
<ul>
<li><a href="#org030e53d">3.4.1. On-Chip Memory Python Scripts</a></li>
<li><a href="#org4d8d395">3.4.2. SRAM: SpriteBinaryGenerator.c</a></li>
</ul>
</li>
<li><a href="#org51f18d3">3.5. Customizations</a>
<ul>
<li><a href="#org8f46168">3.5.1. Palette Based Approach</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#org2aeba17">4. FAQ</a></li>
</ul>
</div>
</div>


<a id="org77f3d70"></a>

# Introduction

-   The purpose of ECE 385 is to give you as sense of modular design and how to apply it to real systems to create complex structures in hardware.
-   This document will walk you through a toolkit developed to help you throughout your final project.
-   We want you to develop complex and interesting hardware and so we believe that it is more productive for you if some of the pure software components of the project are provided to you.
-   Currently, we only have PNG to Hex convert tool for you guys to use. In the future, we hope to develop more tools that will help you create increasing complex projects and show us what you can really do.


<a id="org514dda5"></a>

# Documentation Format

-   Documentation will be provided in subsection
-   You can see below the order in which a given tool will be described:
    1.  Motivation: tells you in what type of projects will this toolkit be useful
    2.  Contents: tells you the contents of a given toolkit
    3.  How To Use: will walk you through a step by step tutorial on how to use the toolkit
    4.  Customizations: this will cover changes to code and other customizations you can do


<a id="org104f575"></a>

# PNG To Hex Converter


<a id="orgce49921"></a>

## Motivation

-   This toolkit is mainly useful for those of you who are making a game or something that is graphically intensive.
-   **It allows you to be able to convert an image into a file format that can be used by on-chip memory, SRAM, and SDRAM**
    -   This way you can just focus on designing the hardware and not be worried about how to get an image into memory
-   Some of the python scripts within the toolkit allow you to also compress the size of an image through the use of KDTrees
    -   Since there is a limited amount of memory, this is useful when you have a lot of images or very large images.


<a id="org8d20aef"></a>

## Contents

-   On-Chip: if you want to develop on chip memory, the scripts in this folder will be useful.
    -   Folders:
        1.  sprite-originals(input) - You will put your original `*.png` images in this folder
        2.  sprite-converted(output) - This is where the output `*.png` samples will be stored once you have run the scripts.
        3.  sprite-bytes(output) - This is where the output `*.txt` files will be stored that can be used by the on-chip memory
    -   Files:
        1.  png-to-3-txt.py - this script will generate **three different outputs** within our output folders for the three different RGB channels
        2.  png-to-txt.py - this script will generate a **single output** within our output folders
        3.  png-to-palette-resizer.py - this script uses a **palette based** approach to compress the image so that you can efficiently use memory. It also provides the option to "resize" by placing the image on a white layer of the new size type. This can be useful when you want to increase the size a little without introducing pixelation.
        4.  png-to-palette-relative-resizer.py - this script uses a **palette based** approach to compress the image so that you can efficiently use memory. It also provides you the option to resize the image. This is a true resize where the final image might have a lot of pixelation.
        5.  ram.sv - the `*.txt` outputs from the python scripts need to be used in conjunction with this `*.sv` file to be able to use on-chip memory correctly.
-   SRAM: if you want to develop using SRAM, the files in this folder will be useful
    1.  SpriteBinaryGenerator.c
        -   This C file generates a `*.ram` file.
        -   This .ram file can then be used by the control panel used in lab 6 to load the SRAM


<a id="org63f0eac"></a>

## Video Tutorial

**<https://www.youtube.com/watch?v=rZiNyB5WFko&list=PL83rW1A3yldZ22Jsv_g5KU7vwXiIwbsxw>**


<a id="orgb9e055e"></a>

## How To Use: Step-by-Step Instructions


<a id="org030e53d"></a>

### On-Chip Memory Python Scripts

-   Prepping the Scripts:
    -   You only need to do this if you want a customized palette. This is explained below in the [Palette Based Approach](#org8f46168) section.
-   Running the Scripts:
    1.  Place the image that you want to convert into the sprite-originals folder
    2.  Open up cmd or a terminal and then navigate to the directory that contains the python script that you are trying to use
    3.  Execute the python script by typing: `python <SCRIPT NAME>`
    4.  Once the script is running it will prompt you for some options. Decide the values for these options based on what you want the output to be.
    5.  Let the script run - might take some time for very large images
    6.  Once the script has finished, go to the output folders and check if the output images match what you are hoping for.
    7.  If they are correct, then take the `*.txt` output and place it in a location that the `ram.sv` file will have access to it.
    8.  Change the path in the `ram.sv` file to match the path of the `*.txt` file.

**IMPORTANT NOTE: You will need separate `ram.sv` files for each of the separate images you have. This is because of the fact that you are initializing a given block on on-chip memory with an images data. The only time you can combine the outputs is if your images are off the same size. This is the only time indexing will be remotely easy.**


<a id="org4d8d395"></a>

### SRAM: SpriteBinaryGenerator.c

1.  Change the input and output paths within the C files
2.  Compile the C file
3.  Run the executable
4.  The generated `*.ram` can then be used to work with control panel
5.  If needed, look at lab 6 for details on how to use control panel
6.  Use `*.ram` file in your awesome project


<a id="org51f18d3"></a>

## Customizations


<a id="org8f46168"></a>

### Palette Based Approach

-   A palette based approach is very useful when you have large images and want to develop a palette specifically for your images so that you can save some memory.
-   We will make small edits to the png-to-palette-resizer/png-to-palette-relative-resizer to allow us to make a custom palette
-   Steps for edits:
    1.  Gather all the images that you plan on using
    2.  Go to <http://www.piskelapp.com> and click on create a sprite
    3.  Import an image and look at the bottom right corner of the screen. There you will see a list of colors that appear in your image.
    4.  Make a list (record RGB values) of important colors that appear in the image.
        -   The more accuracy you want, the more colors you should include.
        -   In my opinion, you should try to gather the RBG values of the colors that look visually unique to you.
    5.  Repeat this steps 3 and 4 for all of your images.
    6.  At this point, delete any repetitions in your list. The result of this will be your palette.
    7.  Take this list and place it within `palette_hex` as hex values in the format of 0xRGB
        -   Example `palette_hex = ['0xFF0000' , '0x047cc0', '0x14b8eb', '0x42fdff', '0x37dcff']`
    8.  No you are ready to run the script and generate the hex and ram files that can be used in memory.


<a id="org2aeba17"></a>

# FAQ

1.  What is PIL and why is it missing?
    -   PIL is the Python Imaging Library and it is missing because you haven't downloaded it.
    -   I recommend downloading [Anaconda][AnacondaDownload] and using Spyder to edit and run the python code.
    -   "Anaconda is a program that installs Spyder and all the other necessary libraries. You download anaconda, then run spyder. Through spyder you can open the python files and it has an execute button and it's own terminal." - Drew Beeman

[AnacondaDownload]: <https://www.continuum.io/downloads>

