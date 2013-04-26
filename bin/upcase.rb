#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Read entries from STDIN (assumed to be in lowercase)
#          and convert them to `Uppercase` and `UPPERCASE`. Within the help
#          of this script we only need to handle `lowercase` entries.
#          This script will print all three forms for each line
#             * lowercase
#             * Uppercase
#             * UPPERCASE
# Author : Anh K. Huynh
# Date   : 2013 April 25th
# Usage  :
#   $0 < input > output

begin
  require "unicode_utils/upcase"
rescue LoadError
  STDERR.puts ":: Error: You need Ruby >= 1.9 and the gem 'unicode_utils'"
  exit 1
end

STDIN \
  .readlines \
  .select do |line|
    line.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)(\p{Space}+0)?$})
  end \
  .map do |line|
    line.split.slice(0,2)
  end \
  .each do |foo,bar|
    ai, bi = foo, bar
    puts "#{ai}\t#{bi}"
    ai, bi = UnicodeUtils.upcase(foo), UnicodeUtils.upcase(bar)
    puts "#{ai}\t#{bi}"
    ai = "#{UnicodeUtils.upcase(foo.slice(0,1))}#{foo.slice(1,foo.size)}"
    if ai.size > 1
      bi = "#{UnicodeUtils.upcase(bar.slice(0,1))}#{bar.slice(1,bar.size)}"
      puts "#{ai}\t#{bi}"
    end
  end
