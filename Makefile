PROJDIR := $(realpath $(CURDIR))
SRCDIR := $(PROJDIR)/src
BUILDDIR := $(PROJDIR)/build

TARGET_NAME = mikiApp
TARGET = $(BUILDDIR)/$(TARGET_NAME)
VPATH = $(SRCDIR)

SOURCES = $(wildcard $(SRCDIR)/*.c)

OBJS := $(subst $(SRCDIR),$(BUILDDIR),$(SOURCES:.c=.o))

CC = gcc
RM = rm -rf 
RMDIR = rm -rf 
MKDIR = mkdir -p

.PHONY: all miki clean

all: $(TARGET)

directory:
	@$(MKDIR) $(BUILDDIR)

$(BUILDDIR)/%.o: %.c
	@echo Building $<
	$(CC) -c $< -o $@

$(TARGET): directory $(OBJS)
	@echo Linking target $@
	$(CC) $(OBJS) -o $@

clean:
	@$(RMDIR) $(BUILDDIR)
	@echo Cleaning done!
