OPT += -O2 -IDependencies/GLUES -IDependencies/OpenAL/include/AL

BINDIR := bin
RUNDIR := .
SRCDIR := Source
SDLDIR := Dependencies/SDL12
OPENALDIR := Dependencies/OpenAL
GLUDIR := Dependencies/GLUES

CXX = g++
CC = gcc
LD = g++

CFLAGS += -DPLATFORM_LINUX=1 -DUSE_GLES
LDFLAGS += -Wl,--start-group -lSDL -lGLESv1_CM -lEGL -lopenal -ljpeg -lpng -logg -lvorbis -lvorbisfile -lz -lm 
INCLUDES += `pkg-config --cflags sdl`
# Don't use bundled headers
SDLDIR := /dummy

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

CFLAGS += $(OPT) $(INCLUDES) $(DEFINES) -c -fsigned-char -pipe -w


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


GLUSRCS := \
glues_error.c \
glues_mipmap.c \
glues_project.c \
glues_quad.c \
glues_registry.c


GLUSRCS := $(foreach f,$(GLUSRCS),$(GLUDIR)/$(f))


SRCS += $(GLUSRCS)

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
	$(LD) -o $@ $(OBJS) $(APPOBJS) $(LDFLAGS)

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
