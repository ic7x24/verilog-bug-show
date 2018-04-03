#
## ================================================================ 
## Verilog Mini Demo Project 
##  
## Licensed under the MIT License.
## 
## github  : https://github.com/ic7x24/verilog-mini-demo 
## ================================================================
#
# Centos-7 X64, Questasim 10.4C, Verdi2016

PROJ_PATH = ../..


RTL_PATH  = $(PROJ_PATH)/rtl
TB_PATH   = $(PROJ_PATH)/sim/tb

FILE_LIST = rtl.f
DOFILE    = sim.do

TB_TOP    = tb

help:
	@echo "  :( Ooops!"
	@echo " the code database is broken"
	@echo " you need to fix all the bugs in rtl and test-bench before run it."
	@echo " contact me when you're done or stucked."
	@echo " Good Luck. :) "
	@echo " "
	@echo " if you are ready, type :"
	@echo "    make sim"



sim: 
	@rm -rf work
	vsim -c -do $(DOFILE) 

verdi: 
	@verdi -nologo -f $(FILE_LIST) -top $(TB_TOP) &

clean:
	@rm -rf *.txt *.ini *.fsdb *.log verdiLog transcript work  novas.*

veryclean: clean

listfile:
	@ls $(RTL_PATH)/*.v   > $(FILE_LIST)
	@ls $(TB_PATH)/*.v   >> $(FILE_LIST)

