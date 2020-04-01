CC=clang++.exe
CFLAGS=-std=c++17

ODIR=obj
BDIR=bin

OBJ = shim.o
OBJS = $(patsubst %,$(ODIR)/%,$(OBJ))

all: $(OBJS) | $(BDIR)
	$(CC) -o $(BDIR)/shim.exe $^ $(CFLAGS) -O -static
	sha256sum $(BDIR)/shim.exe > $(BDIR)/checksum.sha256
	sha512sum $(BDIR)/shim.exe > $(BDIR)/checksum.sha512

$(ODIR)/%.o: %.cpp | $(ODIR)
	$(CC) -c -o $@ $< $(CFLAGS)

$(ODIR):
	mkdir -p $(ODIR)

$(BDIR):
	mkdir -p $(BDIR)

.PHONY: clean debug

clean:
	rm -f $(ODIR)/*.*

debug: $(OBJS) | $(BDIR)
	$(CC) -o $(BDIR)/shim.exe $^ $(CFLAGS) -g
