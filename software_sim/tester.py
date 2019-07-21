
from bitstring import *

def sha_shifter(k, w, dm_in):
    a = dm_in[0*32: 0 * 32 + 32]
    b = dm_in[1*32: 1 * 32 + 32]
    c = dm_in[2*32: 2 * 32 + 32]
    d = dm_in[3*32: 3 * 32 + 32]
    e = dm_in[4*32: 4 * 32 + 32]
    f = dm_in[5*32: 5 * 32 + 32]
    g = dm_in[6*32: 6 * 32 + 32]
    h = dm_in[7*32: 7 * 32 + 32]

    assert(len(dm_in)) == 256
    assert(len(a) == 32)
    assert(len(h) == len(a))

    s1 = right_rotate_xor_3(e, 6, e, 11, e, 25)

    # (e and f) xor ((not e) and g)
    ch = xor_two_strings(and_two_strings(e, f),
                         and_two_strings(not_string(e), g))

    temp1 = add_n_32_bit_strings_modo([h, s1, ch, k, w])
    s0 = right_rotate_xor_3(a, 2, a, 13, a, 22)
    # (a and b) xor (a and c) xor (b and c)
    maj = xor_two_strings(xor_two_strings(and_two_strings(a, b),
                                          and_two_strings(a, c)),
                          and_two_strings(b, c))

    temp2 = mod32_add_str(s0, maj)


    h = g
    g = f
    f = e
    e = mod32_add_str(d, temp1)
    d = c
    c = b
    b = a
    a = mod32_add_str(temp1, temp2)

    return a + b + c + d + e + f + g + h



w = [

        bin(int("ffffffff", 16))[2:], bin(int("eeeeeeee", 16))[2:],
        bin(int("dddddddd", 16))[2:], bin(int("cccccccc", 16))[2:],
        bin(int("bbbbbbbb", 16))[2:], bin(int("aaaaaaaa", 16))[2:],
        bin(int("99999999", 16))[2:], bin(int("88888888", 16))[2:],

        bin(int("77777777", 16))[2:], bin(int("66666666", 16))[2:],
        bin(int("55555555", 16))[2:], bin(int("44444444", 16))[2:],
        bin(int("33333333", 16))[2:], bin(int("22222222", 16))[2:],
        bin(int("ffffffff", 16))[2:], bin(int("ffffffff", 16))[2:],

        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:],
        bin(int("00000000", 16))[2:], bin(int("00000000", 16))[2:]
    ];

for i in range(0, 16):
    print(hex(int(w[i], 2))[2:].rjust(8, '0'))

for i in range(16, 64):
    w[i - 2] = w[i - 2].rjust(32, '0')
    w[i - 7] = w[i - 7].rjust(32, '0')
    w[i - 15] = w[i - 15].rjust(32, '0')
    w[i - 16] = w[i - 16].rjust(32, '0')

    s0 = right_rotate_shift_xor_3(w[i - 15], 7,
                                  w[i - 15], 18,
                                  w[i - 15], 3)

    s1 = right_rotate_shift_xor_3(w[i - 2], 17,
                                  w[i - 2], 19,
                                  w[i - 2], 10)


    val = add_n_32_bit_strings_modo([w[i - 16], s0, w[i - 7], s1])
    w[i] = val
    print(hex(int(w[i], 2))[2:].rjust(8, '0'))



#
#
#initial_dm = 0x6a09e667bb67ae853c6ef372a54ff53a510e527f9b05688c1f83d9ab5be0cd19
#initial_dm = bin(initial_dm)[2:].rjust(256, '0')
#
#sha = sha_shifter(
#    bin(0xb5c0fbcf)[2:],
#    bin(0x55adfba4)[2:],
#    initial_dm)
#
#print(initial_dm)
#print(sha)
#print(hex(int(sha, 2)))
#


