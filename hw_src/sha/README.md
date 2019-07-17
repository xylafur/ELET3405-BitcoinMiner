This SHA implementation is based on the model described in "Cost-Efficient
SHA Hardware Accelerators" by Ricardo Chaves, Student Member, IEEE,  Georgi
Kuzmanov, Member, IEEE,  Leonel Sousa, Senior Member, IEEE,and  Stamatis
Vassiliadis, Fellow, IEEE




Description of SHA256
    http://www.iwar.org.uk/comsec/resources/cipher/sha256-384-512.pdf

Optimizing SHA 256 for HW
    https://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=57157C11C7E68624BCC04F1375275591?doi=10.1.1.148.7900&rep=rep1&type=pdf


    Its saying that the critical path is the calculation of little sigma, which
    is H + K + W
        - the paper states that this can be pipelined by dividing it into two
          parts

    Also we can reduce the number of adders for caldulating the digest
    manifests at the end of a block by considering the fact that h, g, and f
    can all be calculated from previous values of e and the same for b, c and d
    from a
        - it is also saying we can use a CSA instead of a full adder for DM0
          and DM4 (since they come from A and E) and we can add it on the first
          stage of the pipelien (since we know the previous DM0 and DM4)



