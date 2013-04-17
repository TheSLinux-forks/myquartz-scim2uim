#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Find missing entries in the Telex table
# Author : Anh K. Huynh
# Date   : 2013 April 17th
# Usage  :
#   $0 < Telex.txt.in > missings
#   $cat missings >> Telex.txt.in
#   $sort.rb < Telex.txt.in > Telex.txt.in.new
#   $mv Telex.txt.in.new Telex.txt.in

modifiers = %w{s f w x j r}

entries = STDIN \
  .readlines \
  .select {|l| l.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)$}) } \
  .map {|l| l.split.first }

missings = []

entries.each do |item|
  size = item.size
  next if size < 2
  last_char = item.slice(size - 1, 1)
  if modifiers.include?(last_char)
    needed = item.slice(0, size - 1)
    missings << needed \
      unless missings.include?(needed) \
        or entries.include?(needed)
  end
end

puts missings.map{|p| "#{p}\t#{p}"}.join("\n")
