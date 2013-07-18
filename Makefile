###############################################################################
# Copyright (c) 2013 Potential Ventures Ltd
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Potential Ventures Ltd nor the
#       names of its contributors may be used to endorse or promote products
#       derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL POTENTIAL VENTURES LTD BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
###############################################################################

INSTALL_DIR?=/usr/local
FULL_INSTALL_DIR=$(INSTALL_DIR)/cocotb-$(VERSION)

all: test

include makefiles/Makefile.inc
include version

clean:
	-@rm -rf $(BUILD_DIR)
	-@find . -name "obj" | xargs rm -rf
	-@find . -name "*.pyc" | xargs rm -rf
	-@find . -name "results.xml" | xargs rm -rf

test: 
	$(MAKE) -C examples

pycode:
	@cp -R $(SIM_ROOT)/cocotb $(FULL_INSTALL_DIR)/

src_install:
	@mkdir -p $(FULL_INSTALL_DIR)/lib
	@mkdir -p $(FULL_INSTALL_DIR)/bin
	@cp -R lib/* $(FULL_INSTALL_DIR)/lib/

common_install:
	@cp -R bin/cocotbenv.py $(FULL_INSTALL_DIR)/bin/
	@cp -R bin/create_project.py $(FULL_INSTALL_DIR)/bin/
	@cp -R makefiles $(FULL_INSTALL_DIR)/
	@rm -rf $(FULL_INSTALL_DIR)/makefiles/Makefile.inc

create_files:
	bin/create_files.py $(FULL_INSTALL_DIR)

install: src_install common_install pycode create_files
	@echo -e "\nInstalled to $(FULL_INSTALL_DIR)"
	@echo -e "To uninstall run $(FULL_INSTALL_DIR)/bin/cocotb_uninstall\n"

help:
	@echo -e "\nCoCoTB make help\n\nall\t- Build libaries for native"
	@echo -e "libs\t- Build libs for possible ARCHs"
	@echo -e "install\t- Build and install libaries to FULL_INSTALL_DIR (default=$(FULL_INSTALL_DIR))"
	@echo -e "clean\t- Clean the build dir\n\n"