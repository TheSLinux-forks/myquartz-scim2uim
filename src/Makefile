# Purpose: Sample Makefile used by developers
# Author : Anh K. Huynh
# Date   : 2013 April 24th
# License: GPL v2

BIN_DIR = ../bin/

default:
	@echo "Sample Makefile used by developer. Don't use this file"
	@echo "  install : install files to /usr/share/uim/"

xtelex.scm: Telex.txt.in
	@echo "Find missing entries you may want to add them manually"
	@cat Telex.txt.in | $(BIN_DIR)/find_missing.rb
	@echo "Generating $(@)"
	@cat Telex.txt.in \
		| $(BIN_DIR)/upcase.rb \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --telex > $(@)

xvni.scm: VNI.txt.in
	@echo "Find missing entries you may want to add them manually"
	@cat VNI.txt.in | $(BIN_DIR)/find_missing.rb
	@echo "Generating $(@)"
	@cat VNI.txt.in \
		| $(BIN_DIR)/upcase.rb \
		| sort -u \
		| $(BIN_DIR)/sort.rb \
		| $(BIN_DIR)/scim2uim.rb --vni > $(@)

install: xtelex.scm xvni.scm
	@install -v -m644 xtelex.scm xvni.scm /usr/share/uim/

clean:
	@rm -fv xtelex.scm xvni.scm

build-telex:
	@echo ">> WARNING: Because will will not modify the file 'Telex.txt.in'"
	@echo ">> WARNING: automatically this section '$(@)' will do nothing."
	@echo ">> WARNING: Please run 'find_missing' manually."

all: clean build-telex install
