from sha256 import sha256 as my_sha
from hashlib import sha256 as real_sha


from sha256 import xor_two_strings, right_rotate

inputs = [
        "hello",
        "slightly longer string",
        "an even slightly longer string still",
        "well this is quite a long string now isn't it, not quite, but now!",
        """
            Long multiline string that has alot of newlines.  Just want it to
            be long enough such that we will have multiple blocks and can
            validate that portion of the algorithm.  Blocks are 512 bits, so
            this should suffice
        """
        ]

for inp in inputs:
    mine = hex(int(my_sha(inp), 2))[2:]
    if isinstance(inp, int):
        real = hex(int(real_sha(inp), 2))[2:]
    else:
        real = real_sha(inp.encode('utf-8')).hexdigest()

    if mine != real:
        print("SHA implementation is incorrect for input {}".format(inp))


