macosx := false
use_devil := false

OPT += -O2 -IDependencies/GLUES -IDependencies/OpenAL/include/AL

BINDIR := bin
RUNDIR := .
SRCDIR := Source
SDLDIR := Dependencies/SDL12
LIBPNGDIR := Dependencies/libpng
JPEGLIBDIR := Dependencies/libjpeg
ZLIBDIR := Dependencies/zlib
OPENALDIR := Dependencies/OpenAL
GLUDIR := Dependencies/GLUES
LIBOGGDIR := Dependencies/libogg
LIBVORBISDIR := Dependencies/libvorbis

CXX := g++
CC := gcc
LD := g++

CFLAGS += -DPLATFORM_LINUX=1 -D_PC -DUSE_GLES
LDFLAGS += `pkg-config --libs sdl` -lGLESv1_CM -lEGL
INCLUDES += `pkg-config --cflags sdl`
# Don't use bundled headers
SDLDIR := /dummy

ifeq ($(strip $(use_devil)),true)
   LDFLAGS += ./libIL.so.1 ./libILU.so.1 ./libILUT.so.1
endif

LDFLAGS += -lopenal
INCLUDES += `pkg-config --cflags openal`
# Don't use bundled headers
OPENALDIR := /dummy


DEFINES += \
	-DPLATFORM_UNIX=1 \
	-DUSE_SDL=1 \
	-DTRUE=1 \
	-DFALSE=0 \
	-Dstricmp=strcasecmp \
	-DBinIO_STDINT_HEADER="<stdint.h>" \

INCLUDES += \
			-I$(SRCDIR) \
			-I$(SDLDIR)/include \

ifeq ($(strip $(use_devil)),true)
    DEFINES += -DUSE_DEVIL=1
    INCLUDES += -I$(SRCDIR)/devil/include
else
    DEFINES += -DZ_PREFIX=1
    INCLUDES += -I$(ZLIBDIR) -I$(LIBPNGDIR) -I$(JPEGLIBDIR)
endif

DEFINES += -DUSE_OPENAL=1
INCLUDES += -I$(OPENALDIR)/include -I$(LIBOGGDIR)/include -I$(LIBVORBISDIR)/include

CFLAGS += -g -c $(OPT) $(INCLUDES) $(DEFINES) -fsigned-char -pipe -w


ifeq ($(strip $(EXEEXT)),)
   	EXEEXT := bin
endif
EXE := $(RUNDIR)/lugaru-$(EXEEXT)

CXXFLAGS := $(CFLAGS)

SRCS := \
	Frustum.cpp \
	GameDraw.cpp \
	GameInitDispose.cpp \
	GameTick.cpp \
	Globals.cpp \
	Lights.cpp \
	Models.cpp \
	Objects.cpp \
	pack.c \
	pack_private.c \
	Person.cpp \
	private.c \
	Quaternions.cpp \
	Random.c \
	Skeleton.cpp \
	Skybox.cpp \
	Sprites.cpp \
	Terrain.cpp \
	Text.cpp \
	TGALoader.cpp \
	unpack.c \
	unpack_private.c \
	Weapons.cpp \
	MacCompatibility.cpp \
	WinInput.cpp \
	OpenGL_Windows.cpp \
	openal_wrapper.cpp \
	eglport.c

SRCS := $(foreach f,$(SRCS),$(SRCDIR)/$(f))


UNUSED_SRCS := \
	DRIVER.CC \
	MD5.CC \

#    pnggccrd.c \
#    pngvcrd.c \

PNGSRCS := \
    png.c \
    pngerror.c \
    pngget.c \
    pngmem.c \
    pngpread.c \
    pngread.c \
    pngrio.c \
    pngrtran.c \
    pngrutil.c \
    pngset.c \
    pngtrans.c \
    pngwio.c \
    pngwrite.c \
    pngwtran.c \
    pngwutil.c \

PNGSRCS := $(foreach f,$(PNGSRCS),$(LIBPNGDIR)/$(f))

#    jdphuff.c \
#    jidctred.c \
#    jcphuff.c \

JPEGSRCS := \
	jdapistd.c \
    jdmaster.c \
    jdapimin.c \
    jcapimin.c \
    jdmerge.c \
    jdatasrc.c \
    jdatadst.c \
    jdcoefct.c \
    jdcolor.c \
    jddctmgr.c \
    jdhuff.c \
    jdinput.c \
    jdmainct.c \
    jdmarker.c \
    jdpostct.c \
    jdsample.c \
    jdtrans.c \
    jerror.c \
    jidctflt.c \
    jidctfst.c \
    jidctint.c \
    jmemmgr.c \
    jutils.c \
    jmemnobs.c \
    jquant1.c \
    jquant2.c \
    jcomapi.c \
    jcmarker.c \
    jcapistd.c \
    jcparam.c \
    jcinit.c \
    jcdctmgr.c \
    jccoefct.c \
    jcmainct.c \
    jfdctflt.c \
    jfdctint.c \
    jfdctfst.c \
    jchuff.c \
    jcsample.c \
    jcmaster.c \
    jccolor.c \
    jcprepct.c \
    jcarith.c \
    jdarith.c \
    jaricom.c \

JPEGSRCS := $(foreach f,$(JPEGSRCS),$(JPEGLIBDIR)/$(f))

#	gzio.c \

ZLIBSRCS = \
	adler32.c \
	compress.c \
	crc32.c \
	deflate.c \
	infback.c \
	inffast.c \
	inflate.c \
	inftrees.c \
	trees.c \
	uncompr.c \
	zutil.c \

ZLIBSRCS := $(foreach f,$(ZLIBSRCS),$(ZLIBDIR)/$(f))


GLUSRCS := \
glues_error.c \
glues_mipmap.c \
glues_project.c \
glues_quad.c \
glues_registry.c


GLUSRCS := $(foreach f,$(GLUSRCS),$(GLUDIR)/$(f))


OGGSRCS := \
	bitwise.o \
	framing.o

OGGSRCS := $(foreach f,$(OGGSRCS),$(LIBOGGDIR)/src/$(f))

VORBISSRCS := \
	analysis.o \
    bitrate.o \
    block.o \
    codebook.o \
    envelope.o \
    floor0.o \
    floor1.o \
    info.o \
    lpc.o \
    lsp.o \
    mapping0.o \
    mdct.o \
    psy.o \
    registry.o \
    res0.o \
    sharedbook.o \
    smallft.o \
    synthesis.o \
    vorbisfile.o \
    window.o

VORBISSRCS := $(foreach f,$(VORBISSRCS),$(LIBVORBISDIR)/lib/$(f))

ifeq ($(strip $(macosx)),false)
	SRCS += $(GLUSRCS)
endif

ifeq ($(strip $(use_devil)),false)
    SRCS += $(PNGSRCS) $(JPEGSRCS) $(ZLIBSRCS)
endif

 SRCS += $(OGGSRCS) $(VORBISSRCS)

OBJS := $(SRCS:.CC=.o)
OBJS := $(OBJS:.cc=.o)
OBJS := $(OBJS:.cpp=.o)
OBJS := $(OBJS:.c=.o)
OBJS := $(OBJS:.m=.o)
OBJS := $(foreach f,$(OBJS),$(BINDIR)/$(f))


.PHONY: clean all

all : $(EXE)

$(BINDIR)/%.o : %.cpp
	@mkdir -p $(dir $@)
	$(CXX) -o $@ $(CXXFLAGS) $<

$(BINDIR)/%.o : %.CC
	@mkdir -p $(dir $@)
	$(CXX) -x c++ -o $@ $(CXXFLAGS) $<

$(BINDIR)/%.o : %.cc
	@mkdir -p $(dir $@)
	$(CXX) -o $@ $(CXXFLAGS) $<

$(BINDIR)/%.o : %.m
	@mkdir -p $(dir $@)
	$(CC) -o $@ $(CFLAGS) $<

$(BINDIR)/%.o : %.c
	@mkdir -p $(dir $@)
	$(CC) -o $@ $(CFLAGS) $<

$(EXE) : $(OBJS) $(APPOBJS)
	@mkdir -p $(dir $@)
	$(LD) -o $@ $(OBJS) $(APPOBJS) $(LDFLAGS)  $(POSTLDFLAGS)

clean:
	rm -f $(BINDIR)/*.o
	rm -f $(BINDIR)/$(SRCDIR)/*.o
	rm -f $(BINDIR)/$(GLUDIR)/*.o
	rm -f $(BINDIR)/$(LIBPNGDIR)/*.o
	rm -f $(BINDIR)/$(JPEGLIBDIR)/*.o
	rm -f $(BINDIR)/$(ZLIBDIR)/*.o
	rm -f $(BINDIR)/$(LIBOGGDIR)/src/*.o
	rm -f $(BINDIR)/$(LIBVORBISDIR)/lib/*.o
	rm -f $(EXE)

# end of makefile ...
 
