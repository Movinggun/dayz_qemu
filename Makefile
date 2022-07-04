CXX=g++
CXXFLAGS=-I./memflow_lib/memflow-win32-ffi/ -I./memflow_lib/memflow-ffi/ -L./memflow_lib/target/release -Wno-multichar
LIBS=-lm -Wl,--no-as-needed -ldl -lpthread -l:libmemflow_win32_ffi.a

OUTDIR=./build
OBJDIR=$(OUTDIR)/obj

$(shell mkdir -p $(OBJDIR))
$(shell cp memflow_lib/memflow-qemu-procfs/target/release/libmemflow_qemu_procfs.so $(OUTDIR))

%.o: %.cpp
	$(CXX) -c -o $(OBJDIR)/$@ $< $(CXXFLAGS)

dayz_dma: dayz_dma.o
	$(CXX) -o $(OUTDIR)/$@ $(OBJDIR)/dayz_dma.o$(CXXFLAGS) $(LIBS)

.PHONY: all
all: dayz_dma

.DEFAULT_GOAL := all

clean:
	rm -rf $(OUTDIR)