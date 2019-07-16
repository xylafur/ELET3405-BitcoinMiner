###############################################################################
#   Utilities to aid in binary string manipuation
###############################################################################

def right_rotate(value: str, how_much: int):
    assert isinstance(value, str)
    assert isinstance(how_much, int)

    return value[-how_much:] + value[:-how_much]

def xor_two_strings(s1: str, s2: str):
    s = ''
    for i in range(len(s1)):
        if s1[i] == s2[i]:
            s += '0'
        else:
            s += '1'
    return s

def and_two_strings(s1: str, s2: str):
    s = ''
    for i in range(len(s1)):
        if s1[i] == s2[i] and s1[i] == '1':
            s += '1'
        else:
            s += '0'
    return s

def two_two_strings(s1: str, s2: str):
    s = ''
    for i in range(len(s1)):
        if s1[i] == '1' or s2[i] == '1':
            s += '1'
        else:
            s += '0'
    return s

def convert_int_to_binary_string(num: int, bits: int):
    assert num >= 0
    assert bits >= 0

    _bin = bin(num)[2:]
    # If the length of the binary number without padding is already greater
    # than the number of bits specified in the function that a problem
    assert len(_bin) <= bits

    return _bin.rjust(bits, '0')


def convert_num_32_binary(num: int):
    return convert_int_to_binary_string(num, 32)


two_to_32 = (2**32)
def mod32_add(n1: int, n2: int):
    return (n1 + n2) % two_to_32

def mod32_add_str(s1: str, s2: int):
    assert isinstance(s1, str)
    assert isinstance(s2, str)
    return convert_num_32_binary(mod32_add(int(s1, 2), int(s2, 2)))

def not_string(s1: str):
    S = ""
    for s in s1:
        if s == '0':
            S += '1'
        else:
            S += '0'
    return S

def right_rotate_xor_3(s1: str, n1: int, s2: str, n2: int, s3: str, n3: int):
    s1_r = right_rotate(s1, n1)
    s2_r = right_rotate(s2, n2)
    s3_r = right_rotate(s3, n3)

    s1_r_i = int(s1_r, 2)
    s2_r_i = int(s2_r, 2)
    s3_r_i = int(s3_r, 2)

    return convert_num_32_binary(s1_r_i ^ s2_r_i ^ s3_r_i)

def add_n_32_bit_strings_modo(L: list):
    val = "".rjust(32, '0')
    for _val in L:
        val = mod32_add_str(_val, val)
    return val

def bin_8bit(dec: str):
    return(str(format(dec,'08b')))

def bin_64bit(dec: str):
    return(str(format(dec,'064b')))


def seperate(val: str, n: int):
    return [val[s:s+n] for s in range(0, len(val), n)]

def parse_input(string_input: str):
    bit_list=[]
    for i in range(len(string_input)):
        bit_list.append(bin_8bit(ord(string_input[i])))

    return ''.join(bit_list)

def right_shift(s1, n1):
    return s1[:-n1].rjust(32, '0')

def right_rotate_shift_xor_3(s1, n1, s2, n2, s3, n3):
    s1_r = right_rotate(s1, n1)
    s2_r = right_rotate(s2, n2)
    s3_r = right_shift(s3, n3)

    s1_r_i = int(s1_r, 2)
    s2_r_i = int(s2_r, 2)
    s3_r_i = int(s3_r, 2)

    return convert_num_32_binary(s1_r_i ^ s2_r_i ^ s3_r_i)
