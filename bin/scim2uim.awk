#!/usr/bin/awk -f
# encoding=utf-8

# Purpose: Convert the Scim table to Uim table
#          This is a GAWK verion of the Ruby version
# Author : Anh K. Huynh
# Date   : 2013 April 28th
# Usage  :
#   $0 -vim=telex < src/Telex.txt.in > xteltex.scm
#   $0 -vim=vni   < src/VNI.txt.in   > xvni.scm

BEGIN {
  # mode = from command line
  if (im == "telex") {
    name = "Telex"
    xname = "xtelex"
    reg = "^([[:alpha:]]+)[[:blank:]]([^[:blank:]]+)[[:blank:]]*0?$"
  } else if (im == "vni") {
    name = "VNI"
    xname = "xvni"
    reg = "^([[:alnum:]]+)[[:blank:]]([^[:blank:]]+)[[:blank:]]*0?$"
  } else {
    printf(":: Error: Unknown input method '%s'\n", im) > "/dev/stderr"
    exit 1
  }
  has_uppercase_combination = 0

  printf("\
;;\n\
;; This file is a generated file. Don't edit this file.\n\
;;\n\
;; For more details please visit the project home page\n\
;;   https://github.com/icy/myquartz-scim2uim\n\
;;   https://github.com/TheSLinux-forks/myquartz-scim2uim\n\
;;\n\
;; This work is distributed under the license GPL (v2).\n\
;; You must read and accept the license if you want to\n\
;; use, distribute, modify this work, and/or to create\n\
;; any derivative work. The license can be found at\n\
;;   http://www.gnu.org/licenses/gpl-2.0.html\n\
;;\n\
(require \"generic.scm\")\n\
(define %s-rule\n\
  '(\n", xname)
}

{
  if (! match($0, reg, gs) ) {
    next
  }

  split(gs[1], chars, "")
  out = sprintf("\"%s\"", chars[1])
  for (i = 2; i <= length(chars); i ++) {
    out = out " " sprintf("\"%s\"", chars[i])
  }
  printf("(((%s ))(\"%s\"))\n", out, gs[2])

  has_uppercase_combination += match(gs[1], /[A-Z]/)
}

END {

  if (im != "telex" && im != "vni") {
    exit 1
  }

  printf("\
  ))\n\
(define %s-init-handler\n\
  (lambda (id im arg)\n\
    (generic-context-new id im %s-rule #f)))\n\
\n\
(generic-register-im\n\
  '%s\n\
  \"vi\"\n\
  \"UTF-8\"\n\
  (N_ \"X%s\")\n\
  (N_ \"Big table of predefined words for Vietnamese %s users\")\n\
  %s-init-handler)\n", xname, xname, xname, name, name, xname)

  if (has_uppercase_combination == 0) {
    printf("\
::\n\
:: WARNING\n\
::\n\
:: There is no uppercase letter in your input. It seems that you are using\n\
:: the raw input \"Telex.txt.in\" or \"VNI.txt.in\". Since the version 'v1.0.0'\n\
:: these files only contain the lowercase combinations. To get the full\n\
:: list of combinations you need to use the script \"upcase.awk\". Fore more\n\
:: details please check out the latest documentation at\n\
::\n\
::    https://github.com/TheSLinux-forks/myquartz-scim2uim\n\
::\n") \
    > "/dev/stderr"
  }
}
