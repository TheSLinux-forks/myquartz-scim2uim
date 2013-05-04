#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Find missing entries in the Telex/VNI table
# Author : Anh K. Huynh
# Date   : 2013 April 17th
# License: GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)
# Usage  :
#   $0 < Telex.txt.in > missings
#   $cat missings >> Telex.txt.in
#   $sort.rb < Telex.txt.in > Telex.txt.in.new
#   $mv Telex.txt.in.new Telex.txt.in
#
# NOTE: Bc this script doesn't run recursively, you may need to
# run this script at least twice to ensure there is no missing entry
# in your table

modifiers = %w{s f w x j r S F W X J R 1 2 3 4 5 6 7 8}

entries = STDIN \
  .readlines \
  .select {|l| l.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)\p{Space}+([^\p{Space}]+)$}) } \
  .map {|l| l.split.first }

missings = {}

entries.each do |item|
  size = item.size
  next if size < 2
  last_char = item.slice(size - 1, 1)
  if modifiers.include?(last_char)
    needed = item.slice(0, size - 1)
    missings[needed] = needed \
      unless missings.keys.include?(needed) \
        or entries.include?(needed)

    if size > 2
      llast_char = item.slice(size - 2, 1)
      next if llast_char.eql?(last_char)
      next if item.match(/([aeo])\1/) or item.match(/w/)
      needed = "#{item}#{last_char}"
      missings[needed] = "#{item}" \
        unless missings.keys.include?(needed) \
          or entries.include?(needed)
    end
  end
end

puts missings.map {|u,v| "#{u}\t#{v}\t-" }.join("\n") \
  unless missings.empty?
