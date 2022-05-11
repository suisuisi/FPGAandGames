#!/usr/bin/python

import sys

def print_usage( argv ):
  print "Creates mif file for ROM for strings.\n  Input:  raw file with zeros and ones.\n  Output: MIF file \nUsage: %s STRING_FILE_NAME MIF_FILE_NAME" % ( sys.argv[0] )

if __name__ == "__main__":
  
  if len( sys.argv ) < 3:
    print_usage( sys.argv )
    exit( -1 )

  if sys.argv[1] == "--help" or sys.argv[1] == "-h":
    print_usage( sys.argv )
    exit( 0 )
  
  f1 = open( sys.argv[1], "r" )

  line_num = 0
  
  lines = []

  for line in f1:
    print line
    lines.append( line[:-1] ) # minus /n
  
  orig_x = len( lines[0] )
  orig_y = len( lines    )
  
  print "MSG_X = %d" % ( orig_x )
  print "MSG_Y = %d" % ( orig_y )

  rev_lines = []

  for x in xrange( orig_x ):
    l = ""

    for y in xrange( orig_y ):
      l = lines[y][x] + l

    rev_lines.append( l )
  
  rom_width  = orig_y
  rom_depth  = orig_x

  f2 = open( sys.argv[2], "w" )
  f2.write("WIDTH=%d;\n" % rom_width )
  f2.write("DEPTH=%d;\n" % rom_depth )
  f2.write("ADDRESS_RADIX=HEX;\nDATA_RADIX=BIN;\nCONTENT BEGIN\n" )

  for (i, l) in enumerate( rev_lines ):
    f2.write( "%s : %s;\n" % ( "{:04x}".format(i), l ) )

  f2.write("END;")
