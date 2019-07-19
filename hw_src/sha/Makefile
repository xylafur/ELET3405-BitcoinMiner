SHA_DIR=./
PROJECT=sha256
WORK_OBJ=work-obj93.cf

make: analyze
	ghdl -m --workdir=./ $(PROJECT)

analyze:
	ghdl -i --workdir=./ $(SHA_DIR)/*.vhd ./*.vhd

clean:
	rm $(PROJECT)
	rm *.o
	rm $(WORK_OBJ)

