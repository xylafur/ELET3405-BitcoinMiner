"""
    This is my implementation of the pseudocode given in

    https://en.wikipedia.org/wiki/Sha-256#Pseudocode
"""
from copy import copy
from bitstring import *

###############################################################################
#   Functions actually related to computing the hash
###############################################################################
#Initialize array of round constants:
#(first 32 bits of the fractional parts of the cube roots of the first 64
k = [
        convert_num_32_binary(0x428a2f98), convert_num_32_binary(0x71374491),
        convert_num_32_binary(0xb5c0fbcf), convert_num_32_binary(0xe9b5dba5),
        convert_num_32_binary(0x3956c25b), convert_num_32_binary(0x59f111f1),
        convert_num_32_binary(0x923f82a4), convert_num_32_binary(0xab1c5ed5),
        convert_num_32_binary(0xd807aa98), convert_num_32_binary(0x12835b01),
        convert_num_32_binary(0x243185be), convert_num_32_binary(0x550c7dc3),
        convert_num_32_binary(0x72be5d74), convert_num_32_binary(0x80deb1fe),
        convert_num_32_binary(0x9bdc06a7), convert_num_32_binary(0xc19bf174),
        convert_num_32_binary(0xe49b69c1), convert_num_32_binary(0xefbe4786),
        convert_num_32_binary(0x0fc19dc6), convert_num_32_binary(0x240ca1cc),
        convert_num_32_binary(0x2de92c6f), convert_num_32_binary(0x4a7484aa),
        convert_num_32_binary(0x5cb0a9dc), convert_num_32_binary(0x76f988da),
        convert_num_32_binary(0x983e5152), convert_num_32_binary(0xa831c66d),
        convert_num_32_binary(0xb00327c8), convert_num_32_binary(0xbf597fc7),
        convert_num_32_binary(0xc6e00bf3), convert_num_32_binary(0xd5a79147),
        convert_num_32_binary(0x06ca6351), convert_num_32_binary(0x14292967),
        convert_num_32_binary(0x27b70a85), convert_num_32_binary(0x2e1b2138),
        convert_num_32_binary(0x4d2c6dfc), convert_num_32_binary(0x53380d13),
        convert_num_32_binary(0x650a7354), convert_num_32_binary(0x766a0abb),
        convert_num_32_binary(0x81c2c92e), convert_num_32_binary(0x92722c85),
        convert_num_32_binary(0xa2bfe8a1), convert_num_32_binary(0xa81a664b),
        convert_num_32_binary(0xc24b8b70), convert_num_32_binary(0xc76c51a3),
        convert_num_32_binary(0xd192e819), convert_num_32_binary(0xd6990624),
        convert_num_32_binary(0xf40e3585), convert_num_32_binary(0x106aa070),
        convert_num_32_binary(0x19a4c116), convert_num_32_binary(0x1e376c08),
        convert_num_32_binary(0x2748774c), convert_num_32_binary(0x34b0bcb5),
        convert_num_32_binary(0x391c0cb3), convert_num_32_binary(0x4ed8aa4a),
        convert_num_32_binary(0x5b9cca4f), convert_num_32_binary(0x682e6ff3),
        convert_num_32_binary(0x748f82ee), convert_num_32_binary(0x78a5636f),
        convert_num_32_binary(0x84c87814), convert_num_32_binary(0x8cc70208),
        convert_num_32_binary(0x90befffa), convert_num_32_binary(0xa4506ceb),
        convert_num_32_binary(0xbef9a3f7), convert_num_32_binary(0xc67178f2)
    ]



def preprocess(message: str):
    """
        Run the preprocessing component of the algorithm
    """
    assert isinstance(message, str)

    # Create a copy of the message so we don't fuck up the old one
    new = copy(message)

    # append a single 1 to the end
    new += '1'

    # Add K 0's such that K + L + 1 + 64 is a multiple of 512
    # L is the length of the original message, the plus 1 is the '1' we added to the end
    # so n == L + 1
    n = len(new)
    i = 0
    while ((n + i + 64) % 512) != 0:
        new += '0'
        i += 1

    # Then we slap L on as a 64 bit value
    new += bin(n - 1)[2:].rjust(64, "0")

    return new

def get_chunks(preproc: str):
    """
        Slipt the preprocessed message up into 512 bit chunks
    """
    assert len(preproc) % 512 == 0
    return [preproc[i:i+512] for i in range(0, len(preproc), 512)]


def sha256(message):
    if isinstance(message, int):
        message = bin(message)[2:]

    elif isinstance(message, str):
        message = parse_input(message)
    else:
        assert False


    # Initialize hash values:
    # first 32 bits of the fractional parts of the square roots of the first 8 primes
    h0 = convert_num_32_binary(0x6a09e667)
    h1 = convert_num_32_binary(0xbb67ae85)
    h2 = convert_num_32_binary(0x3c6ef372)
    h3 = convert_num_32_binary(0xa54ff53a)
    h4 = convert_num_32_binary(0x510e527f)
    h5 = convert_num_32_binary(0x9b05688c)
    h6 = convert_num_32_binary(0x1f83d9ab)
    h7 = convert_num_32_binary(0x5be0cd19)

    preproc = preprocess(message)
    chunks = get_chunks(preproc)

    for chunk in chunks:
        # we will me manipulating an array of 32 bit unsigned numbersof length 64
        w = [chunk[i:i+32] for i in range(0, 512, 32)]
        assert len(w) == 16
        w += [0] * (64 - 16)
        assert len(w) == 64

        #     Extend the first 16 words into the remaining 48 words w[16..63]
        #     of the message schedule array:
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

        a = h0
        b = h1
        c = h2
        d = h3
        e = h4
        f = h5
        g = h6
        h = h7

        # Compression function main loop
        for i in range(0, 64):
            s1 = right_rotate_xor_3(e, 6, e, 11, e, 25)

            # (e and f) xor ((not e) and g)
            ch = xor_two_strings(and_two_strings(e, f),
                                 and_two_strings(not_string(e), g))

            temp1 = add_n_32_bit_strings_modo([h, s1, ch, k[i], w[i]])
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

            #print(hex(int(a + b + c + d + e + f + g + h, 2))[2:].rjust(64, '0'))


        h0 = mod32_add_str(h0, a)
        h1 = mod32_add_str(h1, b)
        h2 = mod32_add_str(h2, c)
        h3 = mod32_add_str(h3, d)
        h4 = mod32_add_str(h4, e)
        h5 = mod32_add_str(h5, f)
        h6 = mod32_add_str(h6, g)
        h7 = mod32_add_str(h7, h)

    return h0 + h1 + h2 + h3 + h4 + h5 + h6 + h7

def dhash(message):
    return sha256(sha256(message))

def main():
    #raw_inp = "hello\n"
    raw_inp = "3(X*{Dg"
    print("Input as string: ", raw_inp)
    inp = parse_input(raw_inp)
    print("Input in binary: ", inp)
    sha = sha256(inp)
    print("Calculated sha in binary: ", sha)
    print("Calculated sha in hex: ", hex(int(sha, 2)))

    from hashlib import sha256 as realsha256
    output = realsha256(inp.encode('utf-8'))
    print("Sha from native python sha lib: ", output.hexdigest())


if __name__ == '__main__':
    main()
