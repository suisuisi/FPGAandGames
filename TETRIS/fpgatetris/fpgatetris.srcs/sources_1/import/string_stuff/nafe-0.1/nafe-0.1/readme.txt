NAFE -- not another font editor

well nafe is no consolefont editor, but a toolset to translate
psf format consolefonts into text files
and text files into psf files

the advantage is that you can edit the font in the text file easily with any
text editor (not provided by nafe)

so you are independent from your actual terminal hardware and dont need stuff
like svgalib

nafe understands and creates psf mode 1 and mode 2 files

files in this directory:
txt2psf.c		source of txt2psf
psf2txt.c		source of psf2txt
Makefile		gnu makefile, run "make all" to compile
COPYING			the GPL
ChangeLog		a ChangeLog
readme.txt		Documantation (the stuff you are reading right now)
demofont.txt		6x6 pixel demo font text file
demofont.map		unicode map for lat01 mapping for this font
demo6x6.psfu		compiled demofont with 6x6 size
demo8x6.psfu		same font but as 8x6 psf mode 1 file


nafes its functionality can easily described with an example

first you might want to have a template for font editing so
we create a font txt file

usually the consolke font files sit gzipped in /usr/share/consolefonts
so we extract one of those

> cat /usr/share/consolefonts/default8x9.psfu.gz |gunzip >default8x9.psfu

then we save the unicode map stored in the .psfu file

> psfgettable default8x9.psfu unicode.map

then we extract the font data into a text file

> psf2txt default8x9.psfu fontfile.txt
>NAFE v 0.1 -- not another font editor!
>Copyleft 2004 by Corvus Corax
>Distributed under GPL -- NO WARRANTY!
>parsing psf mode 1 font file
>writing 256 characters with 8 x 9
>....................................................................
>....................................................................
>....................................................................
>....................................................
>success :-)

after editing the font you can safe it under newfont.psf

> txt2psf fontfile.txt newfont.psf
>NAFE v 0.1 -- not another font editor!
>Copyleft 2004 by Corvus Corax
>Distributed under GPL -- NO WARRANTY!
>reading 256 characters with 8 x 9
>writing psf mode 1 font file
>  0+---000-0x00-''-
>  1+---001-0x01-''-
>  2+---002-0x02-''-
...
...
>253+---253-0xfd-'ý'-
>254+---254-0xfe-'þ'-
>255+---255-0xff-'ÿ'-
>
>success :-)

and add an optional unicode mapping table to it if you want

> psfaddtable newfont.psf unicode.map newfont.psfu

you can load and display that newly created font with "setfont"

> setfont newfont.psfu

so to edit the font lets have a look at those text files

fontfile.txt:

line				 content
001 identification string	|++font-text-file
002 ID (required)	 	|++chars
003 characters in fontfile	|256
004 ID (required)		|++width
005 width of 1 char in pixel	|8
006 ID (required)		|++height
007 height of 1 char in pixels	|9
008 character separator		|++---000-0x00-''-
009 character data		|
...
...
668 character separator		|++---066-0x42-'B'-
669 character data		|XXXXXX  
670 	each non-blank		| XX  XX 
671	indicates		| XX  XX 
672	a pixel which is set	| XXXXX  
673				| XX  XX 
674	valid chars are		| XX  XX 
675	everything except '+'	|XXXXXX  
676	which indicates		|        
677	the			|        
678 character separator		|++---067-0x43-'C'-
679	of the next character	|  XXXX  
680				| XX  XX 
681				|XX      
682				|XX      
683				|XX      
684				| XX  XX 
685				|  XXXX  
686				|        
687				|        
688			 	|++---068-0x44-'D'-
...


to make creation of new fonts easier and alterations in character height and
width less problematic, the parser fills missing colums and rows with
blanks and ignores extra characters or lines within a char

every line starting with "++" is a separator and starts the next char

you need as many of those separator lines as the character count value
in the "header" specifies -- otherwise txt2psf will create an error


the following expressions are treated the same

> "++---000-0x00-''-"
> "        "        
> "        "
> "        "
> "        "
> "        "
> "        "
> "        "
> "        "
> "        "
> "++---001-0x01-''-"

is equivalent to

> "++char0"
> ""
> ""
> ""
> ""
> ""
> ""
> ""
> ""
> ""
> "++char1"

or even

"++"
"++"

and instead of

> "++---039-0x27-'''-"
> " XX     "
> " XX     "
> "XX      "
> "        "
> "        "
> "        "
> "        "
> "        "
> "        "
> "++---040-0x28-'('-"

you can have

> "++---high-commata"
> " XX"
> " XX"
> "XX"
> "++---openbracket"

or even

> "++             "
> " XX                                      "
> " XX                  "
> "XX                       "
> ""
> ""
> ""
> ""
> ""
> ""
> "   "
> ""
> "     "
> ""
> ""
> ""
> ""
> ""
> "++"

(as long as you use only blanks for blanks and not tabs,
 a tab would be considered as a single SET pixel, not as
 8 (or whatever) UNSET pixels as you might expect)


this behaviour can be used to skip unused chars fast in your own file
or to alter the height and width of a font without changing the characters

for example changing only

> ++font-text-file
> ++chars
> 256
> ++width
> 8
> ++height
> 9
> ++---000-0x00-''-
 
into

> ++font-text-file
> ++chars
> 256
> ++width
> 8
> ++height
> 12
> ++---000-0x00-''-
 
would produce a font with relatively big spacers between lines ;)

ok while at this point even the slowest DAU might have checked how it works
while the more intelligent readers got confused by to much irrelevant
information, let me add a note about psf font files:

there are 2 types of psf files, which each can have an optional
unicode mapping table at their end (which is ignored by nafe)

mode 1 has always 8 pixel character width and either 256 or 512 characters
in total
its the "standard" since these font files can be loaded into the ordinary VGA
graphic adaptor text mode

mode 2 can have any character width and count, and may or may not be able to
load depending on graphic hardware and driver.

under linux you need the framebuffer device to load any font with anything
else than 8 pixel character width, but depending on the used video modes
still not all combination might work

see the manpages of

setfont
psfgettable
psfaddtable
and the kernel documantation on framebufer devices for details

psf2txt can read both mode 1 and mode 2 font files
txt2psf will create a mode 1 font if the width is 8 and the font has
	256 or 512 characters in total and a mode 2 font if not.



Have fun creating some fonts


Corvus Corax



