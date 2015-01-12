#!/usr/bin/perl
 
# Parse command line arguments
$input_string = $ARGV[0];
$input_regexp = $ARGV[1];
print "Input string: \"$input_string\"\n";
print "Input regexp: \"$input_regexp\"\n";
 
# Search for the regexp. The parenthesis makes perl put the
# matched pattern (if any) into the special variable $1
$input_string =~ m/($input_regexp)/;
print "Result: \"$1\"\n";
