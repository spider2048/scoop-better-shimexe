ODIR = obj
BDIR = bin
ADIR = archive
MESON = meson
BUILD_DIR = builddir

TARGET = $(BDIR)/shim.exe
SOURCE = shim.cpp

$(TARGET): $(SOURCE) | $(BDIR)
	$(MESON) setup $(BUILD_DIR) --buildtype=release
	$(MESON) compile -C $(BUILD_DIR)
	mv $(BUILD_DIR)/shim.exe $(TARGET)

	sha256sum $(TARGET) > $(BDIR)/checksum.sha256
	sha512sum $(TARGET) > $(BDIR)/checksum.sha512

$(BDIR):
	mkdir -p $(BDIR)

.PHONY: clean debug zip

clean:
	rm -f $(ODIR)/*.*
	rm -f $(BDIR)/*.*
	rm -fr $(BUILD_DIR)

debug: $(SOURCE) | $(BDIR)
	$(MESON) setup $(BUILD_DIR)

$(ADIR):
	mkdir -p $(ADIR)

$(ADIR)/shimexe.zip: $(TARGET) | $(ADIR)
	cd $(ADIR) && zip -j -9 shimexe.zip ../$(BDIR)/*.*

zip: $(ADIR)/shimexe.zip
