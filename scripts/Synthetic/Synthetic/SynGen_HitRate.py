# from _typeshed import WriteableBuffer
# import numpy as np
from random import randint, random
import csv
import argparse



parser = argparse.ArgumentParser(description='HitRate Sweeping')

parser.add_argument('--rep', dest='REP', type=int, required= False, default= 2048,
                    help='Number of generated address')

parser.add_argument('--round', dest='ROUND', type=int, required= False, default= 1,
                    help='number of reads from DRAM for each address')

parser.add_argument('--p', dest='PARAL', type=int, required= True,
                    help='number of addresses searched in parallel')

parser.add_argument('--hit', dest='HITRATE', type=int, required= True,
                    help='HITRATE')

args = parser.parse_args()


INDEX = 10
AGEN = 10
DRAM = 200 #ALWAYS FIXED
NUM_ADDR = 4096

REP = args.REP
ROUND = args.ROUND
PARAL = args.PARAL
HITRATE = args.HITRATE



FILE = "python/Synthetic/walker_{}.csv".format(HITRATE)
HEADER =  ["opcode", "address", "data"]


INDEX_OPCODE = 0
AGEN_OPCODE = 5
DRAM_OPCODE  = 1
ACK_OPCODE = 2
PROD_OPCODE = 3
STALL_OPCODE = 4


class Generator:
    def __init__(self):
        self.indexTime = INDEX
        self.DRAMTime = DRAM
        self.repetition = REP
        self.round = ROUND
        # self.fileName = FILE
        self.listOut = []
        self.addr = [None] * PARAL
        self.history = [None] * PARAL

    
    def indexing(self, thread):
        self.listOut.append([INDEX_OPCODE,self.addr[thread], INDEX])
        for i in range(INDEX): self.listOut.append( [STALL_OPCODE,0,0])  


    def agen(self, thread):
        self.listOut.append([AGEN_OPCODE,self.addr[thread], AGEN])
        # for i in range(INDEX): self.listOut.append( [STALL_OPCODE,0,0])  

    def reading (self,thread):
        self.listOut.append([DRAM_OPCODE, self.addr[thread], DRAM])
        # for i in range(INDEX): self.listOut.append( [STALL_OPCODE,0,0] )

    def producing (self,thread):
        self.listOut.append([PROD_OPCODE, self.addr[thread], 0])
    
    def ack(self):
        self.listOut.append([ACK_OPCODE, 0, PARAL *self.round * self.repetition - 1])


    def generting (self):
        for i in range (self.repetition):
            self.addrGen()
            for k in range(PARAL): 
                self.indexing(k)
            for k in range (PARAL):
                for j in range (self.round - 1):
                    self.reading (k)
                    self.agen(k)
                self.reading (k)
                self.producing(k)




            # for k in range (PARAL):

        self.ack()
        self.dump()
    
    def addrGen(self):
        self.addr = [None] * PARAL

        if (all (v is None for v in self.history) ):
            while(len(set(self.addr)) != PARAL  ):
                self.addr =  [(randint(0, NUM_ADDR) << 6 ) for i in range (PARAL)]
            if PARAL == 1:
                self.addr =  [(randint(0, NUM_ADDR) << 6 ) for i in range (PARAL)]

            self.history = self.addr
        else:
            while(len(set(self.addr)) != PARAL):
                self.addr =  [ self.history[rand%len(self.history)] if (rand := randint(0,100)) < HITRATE  else (randint(0, 32) << 6 ) for i in range (PARAL)]

            if PARAL == 1:
                self.addr =  [ self.history[rand%len(self.history)] if (rand := randint(0,100)) < HITRATE  else (randint(0, 32) << 6 ) for i in range (PARAL)]

            self.history += (self.addr)

        # print(self.history)
        # print(self.addr)

    def dump (self):
        file =open (FILE,'w')
        writer = csv.writer(file)
        writer.writerow(HEADER)
        writer.writerows(self.listOut)


        
if __name__ == '__main__':

    for i in range (PARAL):
        gen = Generator()
    gen.generting()
