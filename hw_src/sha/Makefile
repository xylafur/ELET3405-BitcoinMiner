SHA_DIR=./
OBJECT_OUT=sha256
TEST_BENCH_NAME=sha256
TEST_BENCH_NAME=sha256
WORK_OBJ=work-obj93.cf

run: make
	./$(TEST_BENCH_NAME)

make: analyze
	ghdl -m --workdir=./ $(TEST_BENCH_NAME)


analyze:
	ghdl -i --workdir=./ $(SHA_DIR)/*.vhd ./*.vhd

clean:
	rm $(OBJECT_OUT)
	rm *.o
	rm $(WORK_OBJ)

