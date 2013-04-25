#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Sort the original tables on the branch `scim`
#          and prepare new tables for UIM.
# Author : Anh K. Huynh
# Date   : 2013 April 17th
# Usage  : This script should be used **ONCE**
#
#   $0 --telex < src/Telex.txt.in > Telex.txt.in.new
#   $0 --vni   < src/VNI.txt.in   > VNI.txt.in.new
#   $mv Telex.txt.in.new Telex.txt.in
#   $mv VNI.txt.in.new   VNI.txt.in
#
#   # add new entries to the table
#   # repeat the first step
#
# Note 1:
# Please note that each meanful line in the old table is ended by `0`,
# while any meanful line in the new table doesn't have that number.
#
# Note 2:
# We may have duplicated entries!! We can use sort to eliminate them.
#   $ sort -u Telex.txt.in | sort.rb > Telex.txt.in.new
#

output = STDIN \
  .readlines \
  .select do |line|
    line.match(%r{^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)(\p{Space}+0)?$})
  end \
  .map do |line|
    line.split.slice(0,2)
  end \
  .sort do |foo, bar|
    ai, bi = foo[0], bar[0]
    ai.size == bi.size \
      ? ai <=> bi \
      : ai.size <=> bi.size
  end

puts(<<-EOF) unless output.empty?
;;
;; Table of predefined combinations for Vietnamese Telex/VNI users.
;;
;; This table is generated from the original table from the branch `scim`.
;; Once this table is manually edit, the generator must be disabled and
;; any further udpate must be done carefully.
;;
;; This work is distributed under the terms of the license GPL (v2).
;; To use this work you must read and accept the license that's found at
;;   http://www.gnu.org/licenses/gpl-2.0.html
;;
EOF

puts output.map{|u,v| "#{u}\t#{v}"}.join("\n")
