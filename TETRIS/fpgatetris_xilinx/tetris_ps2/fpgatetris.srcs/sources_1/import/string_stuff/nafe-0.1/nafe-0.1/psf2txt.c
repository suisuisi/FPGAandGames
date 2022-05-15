/* This file is copyleft 2004 by Corvus Corax
   Version 0.1
   distributed under GPL V2
   usage at own risk
   NO WARRANTY
*/
	 
#include <stdio.h>

void error() {
   fprintf(stderr,"\nERROR READING FONT-FILE!\n");
   exit(1);
}

unsigned char rd(FILE * file) {
   int bla;

   bla=fgetc(file);
   if (bla==EOF) error();
   return (unsigned char)bla;

}



int main(int argc,char**argv) {

FILE * fontfile,*txtfile;
unsigned char zeichen,zeichen2;
int mode;
int hoehe;
int breite;
int bytebreite;
int anzahl;
int z,h,x,t;

fprintf(stdout,"NAFE v 0.1 -- not another font editor!\n");
fprintf(stdout,"Copyleft 2004 by Corvus Corax\n");
fprintf(stdout,"Distributed under GPL -- NO WARRANTY!\n");

if (argc!=3) {
   fprintf(stdout,"Usage: %s <fontfile.psf> <outfile.txt>\n",argv[0]);
   exit(1);
}


//fontfile=fopen("myfont.psf","rb");
fontfile=fopen(argv[1],"rb");

//determine file format
zeichen=rd(fontfile);
if (zeichen==0x36) {
	mode=1;
} else if (zeichen==0x72) {
	mode=2;
} else error();
if (mode==1) {
	zeichen=rd(fontfile);
	if (zeichen!=0x04) error();
	//magic
	zeichen=rd(fontfile);
	if (zeichen==0) anzahl=256;
	if (zeichen==1) anzahl=512;
	if (zeichen==2) anzahl=256;
	if (zeichen==3) anzahl=512;
	if (zeichen>3) error();
	//mode
	zeichen=rd(fontfile);
	hoehe=zeichen;
	breite=8;
	bytebreite=1;
	//height
} else {
	zeichen=rd(fontfile);
	if (zeichen!=0xb5) error();
	zeichen=rd(fontfile);
	if (zeichen!=0x4a) error();
	zeichen=rd(fontfile);
	if (zeichen!=0x86) error();
	//magic
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	//version
	zeichen=rd(fontfile);
	if (zeichen!=0x20) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	//offset (should be 0x20 always)
	zeichen=rd(fontfile);
	zeichen=rd(fontfile);
	zeichen=rd(fontfile);
	zeichen=rd(fontfile);
	//flags (unicode or not -- ignored)
	zeichen=rd(fontfile);
	anzahl=zeichen;
	zeichen=rd(fontfile);
	anzahl+=zeichen*256;
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	//characters in font (more than 65535 are refused ;)
	zeichen=rd(fontfile);
	zeichen=rd(fontfile);
	zeichen=rd(fontfile);
	zeichen=rd(fontfile);
	//size of 1 character in byte -- ignored
	zeichen=rd(fontfile);
	hoehe=zeichen;
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	//height of 1 character in lines
	zeichen=rd(fontfile);
	breite=zeichen;
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	zeichen=rd(fontfile);
	if (zeichen!=0) error();
	bytebreite=(breite+7)/8;
}
fprintf(stdout,"parsing psf mode %i font file\n",mode);
fprintf(stdout,"writing %i characters with %i x %i\n",anzahl,breite,hoehe);
txtfile=fopen(argv[2],"w");
fprintf(txtfile,"++font-text-file\n++chars\n%i\n++width\n%i\n++height\n%i\n",anzahl,breite,hoehe);
for (z=0;z<anzahl;z++) {
   fprintf(stdout,".");
   fprintf(txtfile,"++---%03i-0x%02x-'",z,z);
   if (z>31) fprintf(txtfile,"%c",z);
   fprintf(txtfile,"'-\n");

   for (h=0;h<hoehe;h++) {
      for (t=0;t<bytebreite;t++) {
         zeichen=rd(fontfile);
         for(x=0;x<8;x++) {
            if (zeichen>127){
	       fprintf(txtfile,"X");
	    }else{
	       fprintf(txtfile," ");
	    };
	    zeichen*=2;
         }
      }
      fprintf(txtfile,"\n");
   }
}
fprintf(stdout,"\nsuccess :-)\n");
fclose(fontfile);
fclose(txtfile);
}
