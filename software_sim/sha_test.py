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
        """,
        "1234567890afskdfjhasdvz asdflakjsdfasdf\f \a\b\assdfoasidr\4\1",
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"


        ]

for inp in inputs:
    mine = hex(int(my_sha(inp), 2))[2:]
    if isinstance(inp, int):
        real = hex(int(real_sha(inp), 2))[2:]
    else:
        real = real_sha(inp.encode('utf-8')).hexdigest()

    if mine != real:
        print("SHA implementation is incorrect for input {}".format(inp))

import random
import string
num_tests = 5000
cor = 0
for i in range(num_tests):
    num_characters = random.randint(5, 9000)
    my_string = ''
    for _ in range(num_characters):
        my_string+= random.choice(string.printable)

    mine = hex(int(my_sha(my_string), 2))[2:].rjust(64, '0')
    real = real_sha(my_string.encode('utf-8')).hexdigest()

    if mine != real:
        print("SHA implementation is incorrect for input '{}'".format(my_string))
        print("Is   : {}".format(mine))
        print("Shdb : {}".format(real))
    else:
        cor += 1
print("{} out of {} correct".format(cor, num_tests))


