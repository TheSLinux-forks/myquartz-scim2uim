#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Read entries from STDIN (assumed to be in lowercase)
#          and convert them to `Uppercase` and `UPPERCASE`. Within the help
#          of this script we only need to handle `lowercase` entries
# Author : Anh K. Huynh
# Date   : 2013 April 25th
# Usage  :
#   $0 < input > output

require "unicode_utils/upcase"

STDIN \
  .readlines \
  .select do |line|
    line.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)(\p{Space}+0)?$})
  end \
  .map do |line|
    line.split.slice(0,2)
  end \
  .each do |foo,bar|
    ai, bi = UnicodeUtils.upcase(foo), UnicodeUtils.upcase(bar)
    puts "#{ai}\t#{bi}"
    ai = "#{UnicodeUtils.upcase(foo.slice(0,1))}#{foo.slice(1,foo.size)}"
    if ai.size > 1
      bi = "#{UnicodeUtils.upcase(bar.slice(0,1))}#{bar.slice(1,foo.size)}"
      puts "#{ai}\t#{bi}"
    end
  end
