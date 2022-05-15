#!/usr/bin/python
import sys

def print_usage( argv ):
  print "Creates mif file for font ROM."
  print "  Input:  output file from nafe util"
  print "  Output: MIF file"
  print "Usage: %s FONT_NAME_OUT_FILE_NAME MIF_FILE_NAME" % ( sys.argv[0] )

if __name__ == "__main__":
  
  if len( sys.argv ) < 3:
    print_usage( sys.argv )
    exit( -1 )

  if sys.argv[1] == "--help" or sys.argv[1] == "-h":
    print_usage( sys.argv )
    exit( 0 )
  
  mif_header = "WIDTH=16;\nDEPTH=8192;\nADDRESS_RADIX=HEX;\nDATA_RADIX=BIN;\nCONTENT BEGIN\n"
  
  f2 = open( sys.argv[2], "w" )
  f2.write("%s" % mif_header )
  
  f1 = open( sys.argv[1], "r" )

  line_num = 0

  for line in f1:
    hex_string_flag = True

    for c in line[:-1]:
      if c in ["0", "1"]:
        pass
      else:
        hex_string_flag = False

    if hex_string_flag:
      f2.write( "%s : %s;\n" % ( "{:04x}".format(line_num), line[:-1] ) )
      line_num += 1

  f2.write("END;")
