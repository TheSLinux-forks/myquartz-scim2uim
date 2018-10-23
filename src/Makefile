# Purpose: Sample Makefile used by developers
# Author : Anh K. Huynh
# Date   : 2013 April 24th
# License: GPL v2

BIN_DIR = ../bin/

default:
	@echo "Sample Makefile used by developer. Don't use this file"
	@echo "  install : install files to /usr/share/uim/"
	@echo "  build   : build xtelex.scm and xvni.scm"
	@echo
	@echo "Requirements: ruby, gawk, sort"

xgerm.scm: German.txt.in
	@echo "Find missing entries in '$<' you may want to add them manually"
	@GERMAN=true < $< $(BIN_DIR)/find_missing.rb
	@echo "Generating $(@)"
	@< $< \
		$(BIN_DIR)/upcase.awk \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --german > $(@)

xtelex.scm: Telex.txt.in
	@echo "Find missing entries in 'Telext.txt.in' you may want to add them manually"
	@cat Telex.txt.in | $(BIN_DIR)/find_missing.rb
	@echo "Generating $(@)"
	@cat Telex.txt.in \
		| $(BIN_DIR)/upcase.awk \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --telex > $(@)

xtelex-ipa.scm:
	@echo "Generating $(@)"
	@cat Telex.txt.in \
		| $(BIN_DIR)/upcase.awk \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --telex --ipa > $(@)

xvni.scm: Telex.txt.in
	@echo "Generating $(@)"
	@cat Telex.txt.in \
		| $(BIN_DIR)/telex2vni.rb \
		| $(BIN_DIR)/upcase.awk \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --vni > $(@)

xvni-ipa.scm: Telex.txt.in
	@echo "Generating $(@)"
	@cat Telex.txt.in \
		| $(BIN_DIR)/telex2vni.rb \
		| $(BIN_DIR)/upcase.awk \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --vni --ipa > $(@)

build: xtelex.scm xvni.scm xtelex-ipa.scm xvni-ipa.scm

install: build
	@install -v -m644 \
		xtelex.scm xvni.scm \
		xtelex-ipa.scm xvni-ipa.scm \
		/usr/share/uim/

clean:
	@rm -fv xtelex.scm xvni.scm xtelex-ipa.scm xvni-ipa.scm xgerm.scm

all: clean build install
