#!/usr/bin/awk -f

# Purpose: This script is an alternative of the Ruby version
# Author : Anh K. Huynh
# Date   : 2013 April 27th
# Usage  :
#   $0 < input > output


BEGIN {}

{
  if ($0 !~ /^[[:alnum:]]+[[:blank:]][^[:blank:]]+[[:blank:]][^[:blank:]]+$/) {
    next
  }
  printf("%s\t%s\t%s\n", $1, $2, $3)
  printf("%s\t%s\t%s\n", toupper($1), toupper($2), toupper($3))

  if (length($1) > 1) {
    printf("%s%s\t%s%s\t%s%s\n",
      toupper(substr($1, 1, 1)), substr($1, 2, length($1)),
      toupper(substr($2, 1, 1)), substr($2, 2, length($2)),
      toupper(substr($3, 1, 1)), substr($3, 2, length($3)))
  }
}

END {}
