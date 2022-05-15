/* This file is copyleft 2004 by Corvus Corax
   Version 0.1
   distributed under GPL V2
   usage at own risk
   NO WARRANTY
*/

#include <stdio.h>

void error() {
   fprintf(stderr,"\nSYNTAX ERROR IN TEXT-FILE!\n");
   exit(1);
}

unsigned char rd(FILE * file) {
   int bla;

   bla=fgetc(file);
   if (bla==EOF) return 0;
   return (unsigned char)bla;

}


int main(int argc,char**argv) {

FILE * fontfile,*txtfile;
unsigned char zeichen,zeichen2,zeichen3;
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
   fprintf(stdout,"Usage: %s <fontfile.txt> <outfile.psf>\n",argv[0]);
   exit(1);
}


txtfile=fopen(argv[1],"r");
fontfile=fopen(argv[2],"wb");

zeichen=rd(txtfile);
if (zeichen!='+') error();
while (zeichen!='\n') zeichen=rd(txtfile);
//++font-text-file
zeichen=rd(txtfile);
if (zeichen!='+') error();
while (zeichen!='\n') zeichen=rd(txtfile);
//++chars
fscanf(txtfile,"%i",&anzahl);
zeichen=rd(txtfile);
zeichen=rd(txtfile);
if (zeichen!='+') error();
while (zeichen!='\n') zeichen=rd(txtfile);
//++width
fscanf(txtfile,"%i",&breite);
zeichen=rd(txtfile);
zeichen=rd(txtfile);
if (zeichen!='+') error();
while (zeichen!='\n') zeichen=rd(txtfile);
//++height
fscanf(txtfile,"%i",&hoehe);
zeichen=rd(txtfile);

if (breite==8 && (anzahl==256 || anzahl==512 )) {
   mode=1;
   bytebreite=1;
} else {
   mode=2;
   bytebreite=(breite+7)/8;
}
if (mode==1) {
   fputc(0x36,fontfile);
   fputc(0x04,fontfile);
   //magic
   if (anzahl==256) {
      fputc(0,fontfile);
   } else {
      fputc(1,fontfile);
   }
   //mode
   zeichen=hoehe;
   fputc(zeichen,fontfile);
   //height
} else {
   fputc(0x72,fontfile);
   fputc(0xb5,fontfile);
   fputc(0x4a,fontfile);
   fputc(0x86,fontfile);
   //magic
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //version
   fputc(0x20,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //headersize
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //flags
   zeichen=(anzahl%256);
   fputc(zeichen,fontfile);
   zeichen=(anzahl/256);
   fputc(zeichen,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //length
   zeichen=(bytebreite*hoehe);
   fputc(zeichen,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //charsize
   zeichen=hoehe;
   fputc(zeichen,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //height
   zeichen=breite;
   fputc(zeichen,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   fputc(0,fontfile);
   //width
}

fprintf(stdout,"reading %i characters with %i x %i\n",anzahl,breite,hoehe);
fprintf(stdout,"writing psf mode %i font file\n",mode);
zeichen3=' ';
for (z=0;z<anzahl;z++) {
   fprintf(stdout,"%3i",z);
   if (zeichen3==0) error();
   zeichen=rd(txtfile);
   while (zeichen!='+') {
      // the next char is not found yet
      if (zeichen==0) error();
      zeichen=rd(txtfile);
   }
   while (zeichen!='\n' && zeichen!=0) {
      zeichen=rd(txtfile);
      fputc(zeichen,stdout);
   }
   //++---char id ...
   zeichen3=' ';
   for (h=0;h<hoehe;h++) {
      if (zeichen3!='+') zeichen3=' ';
      for (t=0;t<bytebreite;t++) {
         zeichen2=0;
         for(x=0;x<8;x++) {
            if (zeichen3!='\n' && zeichen3!='+' && zeichen3!=0)
	       zeichen3=rd(txtfile);
	    if (zeichen3=='\n' || zeichen3=='+'|| zeichen3==0) {
	       zeichen=' ';
	    } else {
	       zeichen=zeichen3;
	    }
	    if ((t*8+x)>=breite) zeichen=' ';
	    zeichen2*=2;
	    if (zeichen!=' ') zeichen2++;
         }
	 fputc(zeichen2,fontfile);
      }
      if (zeichen3!='\n' && zeichen3!='+' && zeichen3!=0) {
         while (zeichen3!='\n' && zeichen3!=0) zeichen3=rd(txtfile);
      }
      //we are not yet on end of line, so read some dummy chars
   }
}
fprintf(stdout,"\nsuccess :-)\n");
fclose(fontfile);
fclose(txtfile);
}
