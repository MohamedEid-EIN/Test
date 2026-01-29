###############################################
# Project configuration
###############################################
TARGET = Project_BuildFile

###############################################
# directories
###############################################
PROJECT_ROOT = .
MAKEFILE_DIR
MCAL_ROOT = $(PROJECT_ROOT)/06_Software/07_MCAL/
SRC_DIRS = $(MCAL_ROOT)/GPIO/Source
SRC_DIRS = $(MCAL_ROOT)/UART/Source
SRC_DIRS = $(MCAL_ROOT)/SPI/Source


###############################################
# Include directories
###############################################
INC_DIRS = .

###############################################
# Build output directories
###############################################
TEMP_DIR     = Temp
OBJ_DIR      = $(TEMP_DIR)/Obj
PRE_DIR      = $(TEMP_DIR)/Pre
ELF_DIR      = $(TEMP_DIR)/Elf
MAP_DIR      = $(TEMP_DIR)/Map
BIN_DIR      = $(TEMP_DIR)/Bin
DUMP_DIR     = $(TEMP_DIR)/Dump
SYM_DIR      = $(TEMP_DIR)/Sym
LST_DIR      = $(TEMP_DIR)/lst
SIZE_DIR     = $(TEMP_DIR)/Size