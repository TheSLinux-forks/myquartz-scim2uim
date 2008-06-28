SCIM_TABLES_DIR=/usr/share/scim/tables
SCIM_ICONS_DIR=/usr/share/scim/icons

SRC_DIR=./src
BIN_DIR=./bin
ICON_DIR=./icons

SCIM_MAKE_TABLE=scim-make-table

compile: compile-telex compile-vni 

compile-telex: $(BIN_DIR)/Telex.bin
compile-vni: $(BIN_DIR)/VNI.bin

install: install-telex install-vni
uninstall: uninstall-telex uninstall-vni

install-telex: compile-telex
	cp $(BIN_DIR)/Telex.bin $(SCIM_TABLES_DIR)
	cp $(ICON_DIR)/vikb.png $(SCIM_ICONS_DIR)

uninstall-telex: uninstall-vni
	rm $(SCIM_TABLES_DIR)/Telex.bin
	rm $(SCIM_ICONS_DIR)/vikb.png

install-vni: compile-vni install-telex
	cp $(BIN_DIR)/VNI.bin $(SCIM_TABLES_DIR)
#	cp $(ICON_DIR)/vikb.png $(SCIM_ICONS_DIR)

uninstall-vni:
	rm $(SCIM_TABLES_DIR)/vni.bin
#	rm $(SCIM_ICONS_DIR)/vikb.png

clean:
	rm -f $(BIN_DIR)/*

$(BIN_DIR)/Telex.bin: $(SRC_DIR)/Telex.txt.in
	sed -e 's,@SCIM_ICONDIR@,$(SCIM_ICONS_DIR),g' $(SRC_DIR)/Telex.txt.in > $(BIN_DIR)/Telex.txt
	$(SCIM_MAKE_TABLE) $(BIN_DIR)/Telex.txt -b -o $(BIN_DIR)/Telex.bin
	rm $(BIN_DIR)/Telex.txt

$(BIN_DIR)/VNI.bin: $(SRC_DIR)/VNI.txt.in
	sed -e 's,@SCIM_ICONDIR@,$(SCIM_ICONS_DIR),g' $(SRC_DIR)/VNI.txt.in > $(BIN_DIR)/VNI.txt
	$(SCIM_MAKE_TABLE) $(BIN_DIR)/VNI.txt -b -o $(BIN_DIR)/VNI.bin
	rm $(BIN_DIR)/VNI.txt

