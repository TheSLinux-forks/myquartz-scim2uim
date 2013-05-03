#!/usr/bin/env ruby
# encoding=utf-8

# Purpose: Convert the Scim table to Uim table
# Author : Anh K. Huynh
# Date   : 2013 Mar 7th
# License: GPL v2 (http://www.gnu.org/licenses/gpl-2.0.html)
# Usage  :
#   $0 --telex < src/Telex.txt.in > xteltex.scm
#   $0 --vni   < src/VNI.txt.in   > xvni.scm

mode = true
ARGV.each do |p|
  mode = case p
  when "--telex" then true
  when "--vni"   then false
  end
end

name = {true => "Telex", false => "VNI"} [mode]
xname = {true => "xtelex", false => "xvni"} [mode]

reg  = {true => /^(\p{Alpha}+)\p{Space}+([^\p{Space}]+)\p{Space}+([^\p{Space}]+)$/,
        false => /^(\p{Alnum}+)\p{Space}+([^\p{Space}]+)\p{Space}+([^\p{Space}]+)$/ } [mode]

has_uppercase_combination = false

puts <<-EOF
;;
;; This file is a generated file. Don't edit this file.
;;
;; For more details please visit the project home page
;;   https://github.com/icy/myquartz-scim2uim
;;   https://github.com/TheSLinux-forks/myquartz-scim2uim
;;
;; This work is distributed under the license GPL (v2).
;; You must read and accept the license if you want to
;; use, distribute, modify this work, and/or to create
;; any derivative work. The license can be found at
;;   http://www.gnu.org/licenses/gpl-2.0.html
;;
(require "generic.scm")
(define #{xname}-rule
  '(
EOF

STDIN.readlines.each do |line|
  line.strip!
  if gs = line.match(reg)
    input, output = gs[1,2]
    input = input.split(//).map{|c| "\"#{c}\""}.join(" ")
    puts sprintf("(((%s ))(\"%s\"))", input, output)
    has_uppercase_combination ||= input.match(/[A-Z]/)
  end
end

puts <<-EOF
  ))
(define #{xname}-init-handler
  (lambda (id im arg)
    (generic-context-new id im #{xname}-rule #f)))

(generic-register-im
  '#{xname}
  "vi"
  "UTF-8"
  (N_ "X#{name}")
  (N_ "Big table of predefined words for Vietnamese #{name} users")
  #{xname}-init-handler)
EOF

unless has_uppercase_combination
  STDERR.puts <<-EOF
::
:: WARNING
::
:: There is no uppercase letter in your input. It seems that you are using
:: the raw input "Telex.txt.in" or "VNI.txt.in". Since the version 'v1.0.0'
:: these files only contain the lowercase combinations. To get the full
:: list of combinations you need to use the script "upcase.rb". Fore more
:: details please check out the latest documentation at
::
::    https://github.com/TheSLinux-forks/myquartz-scim2uim
::
EOF
end
