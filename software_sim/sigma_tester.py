import random
from bitstring import *

little_sigma0 = lambda x: right_rotate_shift_xor_3(x, 7, x, 18, x, 3)
little_sigma1 = lambda x: right_rotate_shift_xor_3(x, 17, x, 19, x, 10)
add_words     = lambda a, b : add_n_32_bit_strings_modo(a, b)

s1 = "00111101110111011101110111011101"
s2 = "10001000100010001000100010001000"

res = mod32_add_str(s1, s2)
shdb = "11000110011001100110011001100101"
print(res)
print(len(res))
print(len(shdb))
assert res == shdb



#for i in range(0, 1):
#    inp = 0x77777777 #random.randint(0, 4294967295)
#    inp_bin = bin(inp)[2:].rjust(32, '0')
#    outp = little_sigma0(inp_bin)
#
#    formatted_inp = hex(inp)[2:].rjust(8, '0')
#    formatted_outp = hex(int(outp, 2))[2:].rjust(8, '0')
#
#    print("assert words_equal(little_sigma0(X\"{}\"), X\"{}\")".format(
#        formatted_inp, formatted_outp))
#    print("    report \"Python generated sigma0 is incorrect!\" &")
#    print("           \"is  : \" & word_to_string(little_sigma0(X\"{}\")) &".format(
#        formatted_inp))
#    print("           \"shdb: \" & word_to_string(X\"{}\");".format(formatted_outp))


