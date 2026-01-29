include Cfg/MakeFile_Cfg.mk
###############################################
# Create output folders
###############################################
$(shell mkdir -p $(OBJ_DIR) $(PRE_DIR) $(ELF_DIR) $(MAP_DIR) $(BIN_DIR) $(DUMP_DIR) $(SYM_DIR) $(SIZE_DIR))

###############################################
# Allow make to find source files in SRC_DIRS
###############################################
VPATH = $(SRC_DIRS)

###############################################
# Auto-detect all C and ASM sources
###############################################
C_SOURCES  = $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.c))
S_SOURCES  = $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.s))

###############################################
# Convert sources to object names
###############################################
OBJS = \
    $(addprefix $(OBJ_DIR)/, $(notdir $(C_SOURCES:.c=.o))) \
    $(addprefix $(OBJ_DIR)/, $(notdir $(S_SOURCES:.s=.o)))

###############################################
# Tools  (UNCHANGED)
###############################################
CC      = arm-none-eabi-gcc
AS      = arm-none-eabi-gcc
LD      = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump
NM      = arm-none-eabi-nm
SIZE    = arm-none-eabi-size

CPU = -mcpu=cortex-m4 -mthumb

###############################################
# FLAGS (UNCHANGED)
###############################################
CFLAGS  = $(CPU) -O0 -ffreestanding -nostdlib -nostartfiles -g -fno-builtin-memset
ASFLAGS = $(CPU) -x assembler-with-cpp -g

###############################################
# Include paths
###############################################
CFLAGS += $(foreach inc,$(INC_DIRS),-I$(inc))

###############################################
# Linker (PATH ONLY CHANGED)
###############################################
LINKER_SCRIPT = Linker.ld
LDFLAGS = -T $(LINKER_SCRIPT) -Map=$(MAP_DIR)/$(TARGET).map

###############################################
# Default rule
###############################################
all: $(ELF_DIR)/$(TARGET).elf diagnostics

###############################################
# Generic compilation rules
###############################################
$(OBJ_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
	$(CC) -E $< -o $(PRE_DIR)/$(notdir $*).i
	$(CC) -S $< -o $(PRE_DIR)/$(notdir $*).s

$(OBJ_DIR)/%.o: %.s
	$(AS) $(ASFLAGS) -c $< -o $@

###############################################
# Linking
###############################################
$(ELF_DIR)/$(TARGET).elf: $(OBJS)
	$(LD) $(LDFLAGS) $(OBJS) -o $@

###############################################
# Firmware formats
###############################################
$(BIN_DIR)/%.bin: $(ELF_DIR)/%.elf
	$(OBJCOPY) -O binary $< $@

$(BIN_DIR)/%.hex: $(ELF_DIR)/%.elf
	$(OBJCOPY) -O ihex $< $@

$(BIN_DIR)/%.srec: $(ELF_DIR)/%.elf
	$(OBJCOPY) -O srec $< $@

###############################################
# Debug / inspection outputs
###############################################
$(DUMP_DIR)/%.lst: $(ELF_DIR)/%.elf
	$(OBJDUMP) -d -S -x $< > $@

$(SYM_DIR)/%.sym: $(ELF_DIR)/%.elf
	$(NM) -n $< > $@

$(SIZE_DIR)/%.size: $(ELF_DIR)/%.elf
	$(SIZE) -A $< > $@

$(DUMP_DIR)/%.dump: $(ELF_DIR)/%.elf
	$(OBJDUMP) -x $< > $@

$(ELF_DIR)/%.dbg: $(ELF_DIR)/%.elf
	$(OBJCOPY) --only-keep-debug $< $@

$(ELF_DIR)/%.stripped.elf: $(ELF_DIR)/%.elf
	$(OBJCOPY) --strip-debug $< $@

###############################################
# Diagnostics group
###############################################
diagnostics: \
	$(DUMP_DIR)/$(TARGET).lst \
	$(SYM_DIR)/$(TARGET).sym \
	$(SIZE_DIR)/$(TARGET).size \
	$(DUMP_DIR)/$(TARGET).dump \
	$(ELF_DIR)/$(TARGET).dbg \
	$(ELF_DIR)/$(TARGET).stripped.elf \
	$(BIN_DIR)/$(TARGET).bin \
	$(BIN_DIR)/$(TARGET).hex \
	$(BIN_DIR)/$(TARGET).srec

###############################################
# Cleaning
###############################################
clean:
	rm -rf $(TEMP_DIR)/*