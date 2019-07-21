def hash(string):
    return(process(pad(string)))

def pad(string):
    data = ""
    length = len(string) * 8
    for c in string:
        data += bin(ord(c))[2:].zfill(8)
    data += "1"
    while len(data)%512 != 448:
        data += "0"
    data += bin(length)[2:].zfill(64)
    return data

def process(bins):
    main_block=[
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2]

    h0 = 0x6a09e667
    h1 = 0xbb67ae85
    h2 = 0x3c6ef372
    h3 = 0xa54ff53a
    h4 = 0x510e527f
    h5 = 0x9b05688c
    h6 = 0x1f83d9ab
    h7 = 0x5be0cd19

    for c in chunks(bins, 512):
        words = chunks(c, 32)
        w = [0]*64

        w[:15] = [int(n, 2) for n in words]
        for i in range(16, len(w)):
            tmp1 = rightRotate(w[i-15], 7) ^ rightRotate(w[i-15], 18) ^ rightShift(w[i-15], 3)
            tmp2 = rightRotate(w[i-2], 17) ^ rightRotate(w[i-2], 19) ^ rightShift(w[i-2], 10)
            w[i] = (w[i-16] + tmp1 + w[i-7] + tmp2) & 0xffffffff

    a = h0
    b = h1
    c = h2
    d = h3
    e = h4
    f = h5
    g = h6
    h = h7

    for i in range(0, 64):
        s1 = rightRotate(e, 6) ^ rightRotate(e, 11) ^ rightRotate(e, 25)
        ch = g ^ (e & (f ^ g))
        tmp1 = (h + s1 + ch + main_block[i] + w[i]) & 0xffffffff
        s0 = rightRotate(a, 2) ^ rightRotate(a, 13) ^ rightRotate(a, 22)
        maj = (a&b) ^ (a&c) ^ (b&c)
        tmp2 = (s0 + maj) & 0xffffffff

        h = g
        g = f
        f = e
        e = (d + tmp1) & 0xffffffff
        d = c
        c = b
        b = a
        a = (tmp1 + tmp2) & 0xffffffff

    h0 += a & 0xffffffff
    h1 += b & 0xffffffff
    h2 += c & 0xffffffff
    h3 += d & 0xffffffff
    h4 += e & 0xffffffff
    h5 += f & 0xffffffff
    h6 += g & 0xffffffff
    h7 += h & 0xffffffff

    return '%08x%08x%08x%08x%08x%08x%08x%08x' % (h0, h1, h2, h3, h4, h5, h6, h7) 

def rightShift(x, n):
    return (x & 0xffffffff) >> n

def rightRotate(x, y):
    return (((x & 0xffffffff) >> (y & 31)) | (x << (32 - (y & 31)))) & 0xffffffff

def chunks(l, n):
        return [l[i:i+n] for i in range(0, len(l), n)]

string = "3(X*Dg"
print(hash(string))
