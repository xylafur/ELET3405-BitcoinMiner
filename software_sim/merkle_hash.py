from sha256 import dhash
from transaction import Transaction

def merkle_hash(transactions):
    hashes = []

    # hash all of the transactions, store the result in the hashes array
    for trans in transactions:
        hashes.append(dhash(trans))

    # The number of first order hashes needs to be even, so if the number of
    # total transactions is odd we hash the last one twice
    if (len(hashes) % 2) != 0:
        hashes.append(dhash(transactions[-1]))





