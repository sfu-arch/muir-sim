BLOCK_SIZE_IN_BYTE = 8

def convert_str_to_byte_stream(data):
    asciied = 0
    str_list = []
    for i in range(len(data)//BLOCK_SIZE_IN_BYTE + 1):
        asciied = 0
        
        for j in range(BLOCK_SIZE_IN_BYTE):
            if  i *  BLOCK_SIZE_IN_BYTE + j >= len(data):
                break

            asciied |= ord(data[ i *  BLOCK_SIZE_IN_BYTE + j])
            asciied <<= 8
        asciied >>= 8 
        str_list.append(asciied)

    return str_list

def read_index_table(mem, file_name='index_info.txt'):
    file = open(file_name, 'r')
    for line in file:
        index_data = line.split(',')
        address = int(index_data[0])
        for i, data in enumerate(index_data[1:]):
            data = data.strip(' ')
            data = data.strip('\n')
            if (i == 1): #skip row id
                continue
            if data.isnumeric():
                mem[address] |= int(data) << int(i/2) * 32
            else:
                str_list = convert_str_to_byte_stream(data)
                for index, asciied in enumerate(str_list):
                    mem[address+index] = asciied