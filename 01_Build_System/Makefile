###############################################
# Build System entry Makefile
###############################################

# Path to the real Makefile
MAKEFILE_CORE := ../02_ToolChain/MakeFiles/MakeFile.mk

.PHONY: all clean rebuild

all:
	$(MAKE) -f $(MAKEFILE_CORE) BUILD_ROOT=$(CURDIR)

clean:
	$(MAKE) -f $(MAKEFILE_CORE) BUILD_ROOT=$(CURDIR) clean

rebuild:
	$(MAKE) -f $(MAKEFILE_CORE) BUILD_ROOT=$(CURDIR) clean all
