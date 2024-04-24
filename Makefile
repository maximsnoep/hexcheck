HEXALAB_DIR = ./HexaLab/src
OBJ_DIR = ./obj

CC = g++
CXXFLAGS = -I $(HEXALAB_DIR) -I $(HEXALAB_DIR)/eigen -std=c++11 -Wall -O2

OBJ = $(OBJ_DIR)/main.o \
      $(OBJ_DIR)/app.o \
      $(OBJ_DIR)/builder.o \
      $(OBJ_DIR)/color_map.o \
      $(OBJ_DIR)/loader.o \
      $(OBJ_DIR)/mesh.o

DEPS = $(HEXALAB_DIR)/app.h \
       $(HEXALAB_DIR)/builder.h \
       $(HEXALAB_DIR)/color_map.h \
       $(HEXALAB_DIR)/common.h \
       $(HEXALAB_DIR)/hex_quality.h \
       $(HEXALAB_DIR)/hex_quality_color_maps.h \
       $(HEXALAB_DIR)/ifilter.h \
       $(HEXALAB_DIR)/loader.h \
       $(HEXALAB_DIR)/mesh.h \
       $(HEXALAB_DIR)/model.h

# Explicitly create the object directory before compiling anything
$(shell mkdir -p $(OBJ_DIR))

# Pattern rule for object files, ensure OBJ_DIR exists
$(OBJ_DIR)/%.o: $(HEXALAB_DIR)/%.cpp $(DEPS)
	$(CC) $(CXXFLAGS) -c -o $@ $<

# Specific rule for main.o if main.cpp is in the root directory
$(OBJ_DIR)/main.o: main.cpp $(DEPS)
	$(CC) $(CXXFLAGS) -c -o $@ $<

# Link the program
hexchex: $(OBJ)
	$(CC) -o $@ $^

# Clean rule for cleaning up the project
clean:
	rm -rf $(OBJ_DIR) hexchex

# Default rule
all: hexchex

# Setting the default goal explicitly to 'all'
.DEFAULT_GOAL := all
