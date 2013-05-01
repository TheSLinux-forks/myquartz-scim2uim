#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Convert Telex table to VNI table
# Author : Anh K. Huynh
# Date   : 2013 May 1st

Accents = {
  :telex  => 'sfrxjw',
  :vni    => '123457'}

combinations = [
  ["aw", "aa", "dd", "ee", "oo", "ow", "uw"],
  ["a8", "a6", "d9", "e6", "o6", "o7", "u7"]]

combinations = Hash[*combinations.transpose.flatten]

entries = STDIN \
  .readlines \
  .select {|l| l.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)\p{Space}+([^\p{Space}]+)$}) } \
  .map {|l| l.split.slice(0,3) }

entries.each do |source, output1, output2|
  # The cancel form
  source = source.gsub(/([adoe])(\1\1)/) do |m|
    tmp = combinations[$2]       # return "[adoe]6"
    "#{$1}#{tmp.slice(1,1) * 2}" # return "[adoe]66"
  end

  # Another cancel form
  source = source.gsub(/([aou]w)w/) do |m|
    tmp = combinations[$1]        # return "a8"  or "[ou]7"
    "#{$1}#{tmp.slice(1,1) * 2}"  # return "a88" or "[ou]77"
  end

  combinations.keys.each do |key|
    source = source.gsub(key, combinations[key])
    output1 = output1.gsub(key, combinations[key])
    output2 = output2.gsub(key, combinations[key])
  end

  source = source.tr(Accents[:telex], Accents[:vni])
  output1 = output1.tr(Accents[:telex], Accents[:vni])
  output2 = output2.tr(Accents[:telex], Accents[:vni])

  puts sprintf("%s\t%s\t\%s\n", source, output1, output2)
end
