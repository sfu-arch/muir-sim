import re
import sys

location = "MI_example-cache.sm"
if len(sys.argv) > 1:
    location = sys.argv[1]

file = open(location, 'r')

in_state = False
states = []

for line in file:
    if "state_declaration" in line:
        in_state = True
    elif in_state:
        if '}' in line:
            break
        
        cleaned_arg = re.findall("[a-z|A-Z|_]+", line)
        if not cleaned_arg:
            continue

        print(cleaned_arg)
        states.append(cleaned_arg[0])

state_file = open("States.scala", "w")

state_file.write("package memGen.memory.cache\n\n\
import chisel3._\n\
import chisel3.util._\n\n\
object States{\n\n\
\tval StateArray = Map(\n")

text = '\t\t(s"{state}", {index})'
for index, state in enumerate(states):
    state_file.write(text.format(state=state, index=hex(index)))
    if state is not states[-1]:
        state_file.write(', ')
    state_file.write('\n')

state_file.write("\t)\n\tval stateLen =  if (StateArray.size == 1 ) 1 else log2Ceil(StateArray.size)\n}")