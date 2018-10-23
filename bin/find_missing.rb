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
# NOTE: Bc this script doesn't run recursively, you may need to
# NOTE: run this script at least twice to ensure there is no missing entry
# NOTE: in your table

if not ENV["GERMAN"].to_s.empty?
  modifiers = %w{e s E S}
else
  modifiers = %w{s f w x j r S F W X J R 1 2 3 4 5 6 7 8}
end

# `entries` is list of the first item (colum) of the definition
# Example:
#   Input:  as á -  | oets oét -
#   Output: as      | oets
entries = STDIN \
  .readlines \
  .select {|l| l.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)\p{Space}+([^\p{Space}]+)$}) } \
  .map {|l| l.split.first }

missings = {}

entries.each do |item|
  size = item.size
  next if size < 2

  # Add the `shorten form `****X` => {`****` => `****`}
  # Here `X` is any modifier.
  last_char = item.slice(size - 1, 1)
  next unless modifiers.include?(last_char)

  needed = item.slice(0, size - 1)
  missings[needed] = needed \
    unless missings.keys.include?(needed) \
      or entries.include?(needed)

  next unless size > 2

  # Add the simple `cancel form `***YX` => {`***YXX` => `***YX`}
  # Here `X` is any modifier, and `Y` is not `X` (otherwise, the current
  # entry is also a `cancel form). To make sure `***` does not have
  # any Vietnamese words, we must use [1]
  llast_char = item.slice(size - 2, 1)
  next if llast_char.eql?(last_char)
  next if item.match(/([aeo])\1/) or item.match(/w/)               # [1]
  needed = "#{item}#{last_char}"
  missings[needed] = "#{item}" \
    unless missings.keys.include?(needed) \
      or entries.include?(needed)
end

puts missings.map {|u,v| "#{u}\t#{v}\t-" }.join("\n") \
  unless missings.empty?
