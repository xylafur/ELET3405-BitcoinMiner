SHA_DIR=$(shell pwd)/../../../sha
OBJECT_OUT=sha_manager_tb
TEST_BENCH_NAME=sha_manager_tb
TEST_BENCH_NAME=sha_manager_tb
WORK_OBJ=work-obj93.cf

run: make
	./$(TEST_BENCH_NAME)

analyze:
	ghdl -i --workdir=./ $(SHA_DIR)/*.vhd ./*.vhd

make: analyze
	ghdl -m --workdir=./ $(TEST_BENCH_NAME)

clean:
	rm $(OBJECT_OUT)
	rm *.o
	rm $(WORK_OBJ)
