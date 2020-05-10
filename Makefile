CC=clang++.exe
CFLAGS=-std=c++17 -m32
VER=shimexe-2.1

ODIR = obj
BDIR = bin
ADIR = archive

TARGET = $(BDIR)/shim.exe
OBJ = shim.o
OBJS = $(patsubst %,$(ODIR)/%,$(OBJ))

$(TARGET): $(OBJS) | $(BDIR)
	$(CC) -o $(TARGET) $^ $(CFLAGS) -O -static
	sha256sum $(TARGET) > $(BDIR)/checksum.sha256
	sha512sum $(TARGET) > $(BDIR)/checksum.sha512

$(ODIR)/%.o: %.cpp | $(ODIR)
	$(CC) -c -o $@ $< $(CFLAGS) -g

$(ODIR):
	mkdir -p $(ODIR)

$(BDIR):
	mkdir -p $(BDIR)

.PHONY: clean debug zip

clean:
	rm -f $(ODIR)/*.*

debug: $(OBJS) | $(BDIR)
	$(CC) -o $(BDIR)/shim.exe $^ $(CFLAGS) -g

$(ADIR):
	mkdir -p $(ADIR)

$(ADIR)/$(VER).zip: $(TARGET) | $(ADIR)
	cd $(ADIR) && zip -j -9 $(VER).zip ../$(BDIR)/*.*

zip: $(ADIR)/$(VER).zip
