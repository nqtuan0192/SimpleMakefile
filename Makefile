program_NAME := myprogram

program_C_SRCS   := $(wildcard *.c)
program_CXX_SRCS := $(wildcard *.cpp)
program_C_OBJS   := ${program_C_SRCS:.c=.o}
program_CXX_OBJS := ${program_CXX_SRCS:.cpp=.o}
program_OBJS     := $(program_C_OBJS) $(program_CXX_OBJS)

program_INCLUDE_DIRS :=
program_LIBRARY_DIRS :=
program_LIBRARIES    :=

CPPFLAGS	+= $(foreach includedir,$(program_INCLUDE_DIRS),-I$(includedir))
LDFLAGS		+= $(foreach librarydir,$(program_LIBRARY_DIRS),-L$(librarydir))
LDFLAGS		+= $(foreach library,$(program_LIBRARIES),-l$(library))

CCFLAGS  =
CXXFLAGS =	-m64	-msse	-O3	-march=native	-pipe	-fomit-frame-pointer	-std=gnu++11	-Wall

CC     =	g++
CXX    =	g++

.PHONY: all clean distclean

all: $(program_NAME)

debug: CXXFLAGS = -DDEBUG	-g	-std=gnu++11	-Wall
debug: $(program_NAME)

$(program_NAME): $(program_OBJS)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(program_OBJS) -o $(program_NAME)

clean:
	@- $(RM) $(program_NAME)
	@- $(RM) $(program_OBJS)

distclean: clean
