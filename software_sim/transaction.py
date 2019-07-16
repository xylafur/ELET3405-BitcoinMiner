"""
    Note that for our implementation we don't have to actually comute
    transactions or anything like that.  Our module just neesd to be able to
    understand the structure of transactions and be able to pass them into our
    hashing function to construct the merkle root
"""


from bitstring import convert_int_to_binary_string

class CompactInt:
    """
        Special data type used by bitcoin..
        since the size is variable, the first byte (if its longer than a single
        byte) starts with a very special identifier

        https://bitcoin.org/en/developer-reference#compactsize-unsigned-integers
    """

    def __init__(self: CompactInt, value: int):
        if value >= 0 and value <= 252:
            self.identifier = None
            self._type = 'uint8_t'
            self.num_bytes = 1

        elif value >= 253 and <= 0xfff:
            self.identifier = 0xfd
            self._type = 'uint16_t'
            self.num_bytes = 3

        elif value >= 0x10000 and <= 0xffffffff:
            self.identifier = 0xfe
            self._type = 'uint32_t'
            self.num_bytes = 5

        elif value >= 0x100000000 and <= 0xffffffffffffffff:
            self.identifier = 0xff
            self._type = 'uint64_t'
            self.num_bytes = 9

        self.num_bits = 8 * self.num_bytes
        if self.identifier:
            self.value = bin(self.identifier)[2:] + \
                         convert_int_to_binary_string(value, self.num_bits - 8)

        else:
            self.value = convert_int_to_binary_string(value, self.num_bits)


class Outpoint:
    pass

class TxIn:
    def __init__(self: TxIn, previous_output: Outpoint, script_bytes: CompactInt,
                 signature_script: str, sequence: int):
        """
            Parameters:
                previous_output: (36 bytes)
                    The previous outpoint being spent.

                script_bytes: (varying bytes)
                    The number of bytes in the signature script. Maximum is
                    10,000 bytes.

                signature_script: (varying bytes)
                    A script-language script which satisfies the conditions
                    placed in the outpoint’s pubkey script. Should only contain
                    data pushes; see the signature script modification warning.

                sequence: (4 bytes)
                    Sequence number. Default for Bitcoin Core and almost all
                    other programs is 0xffffffff.
        """
        pass


class TxOut:
    def __init__(self: TxOut, value: int, pk_script_bytes: CompactInt,
                 pk_script: str):
        """
            Parameters:
                value: 8 bytes
                    Number of satoshis to spend. May be zero; the sum of all
                    outputs may not exceed the sum of satoshis previously spent
                    to the outpoints provided in the input section. (Exception:
                    coinbase transactions spend the block subsidy and collected
                    transaction fees.)

                pk_script_bytes: (one or more bytes)
                    Number of bytes in the pubkey script. Maximum is 10,000
                    bytes.

                pk_script: (varying number of bytes)
                    Defines the conditions which must be satisfied to spend
                    this output.
        """
        pass


class Transaction:
    def __init__(self: Transaction, version: int,
                 tx_in_count: CompactInt, tx_in: TxIn,
                 tx_out_count: CompactInt, tx_out: TxOut,
                 lock_time: int):
        """
            Parameters:
                version: (4 bytes)
                    Transaction version number (note, this is signed);
                    currently version 1 or 2. Programs creating transactions
                    using newer consensus rules may use higher version numbers.
                    Version 2 means that BIP 68 applies.

                tx_in_count: (varying bytes)
                    Number of inputs in this transaction.

                tx_in: (varying bytes)
                    Transaction inputs

                tx_out_count: (varying bytes)
                    Number of outputs in this transaction.

                tx_out: (varying bytes)
                    Transaction outputs.

                lock_time: (4 bytes)
                    A time (Unix epoch time) or block number.


        """
        pass




def generate_sample_transaction():
    version =           0x1000000
    number_of_inputs =  0x1
    inp =               0x7b1eabe0209b1fe794124575ef807057
    output_txid =       0xc77ada2138ae4fa8d6c4de0398a14f3f
    outpint_index_num = 0x0
    bytes_in_sig =      0x49
    bytes_data =        0x48



