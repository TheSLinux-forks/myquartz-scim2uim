#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Convert the Scim table to Uim table
# Author : Anh K. Huynh
# Date   : 2013 Mar 7th
# FIXME  : This only works with the Telex table

puts <<-EOF
(require "generic.scm")
(define xtelex-rule
  '(
EOF

STDIN.readlines.each do |line|
  line.strip!
  if gs = line.match(/^(\p{Alpha}+)\p{Space}+([^\p{Space}]+)\p{Space}+0$/)
    input, output = gs[1,2]
    input = input.split(//).map{|c| "\"#{c}\""}.join(" ")
    puts sprintf("(((%s ))(\"%s\"))", input, output)
  end
end

puts <<-EOF
  ))
(define xtelex-init-handler
  (lambda (id im arg)
    (generic-context-new id im xtelex-rule #f)))

(generic-register-im
 'xtelex
 "vi"
 "UTF-8"
 (N_ "XTelex")
 (N_ "XTelex table")
 xtelex-init-handler)
EOF
