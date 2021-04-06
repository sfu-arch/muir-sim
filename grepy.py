# import sys
import re
import argparse

parser = argparse.ArgumentParser()

parser.add_argument("--name", action="store", help="Node name")
parser.add_argument("--log", action="store", help="Log name")
# parser.parse_args()
args = parser.parse_args()

# answer = args.x**args.y
# if args.verbosity >= 2:
    # print("Running '{}'".format(__file__))
# if args.verbosity >= 1:
    # print("{}^{} == ".format(args.x, args.y), end="")
# print(answer)


# name = 'phiindvars_iv20'
# name = sys.argv[1]
name = args.name
outs = list()
with open(args.log) as f:
    for line in f:
        if name in line:
            substring = re.search(r"\[Out:\s*(.*?)\]", line).group(1)
            outs.append(int(substring))

print("Outputs:")
# print(outs)
print('List('+', '.join('%i' % (v) for v in outs) + ')')
