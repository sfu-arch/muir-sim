import re
import sys

location = "MI_example-cache.sm"
if len(sys.argv) > 1:
    location = sys.argv[1]

file = open(location, 'r')

in_event = False
states = []

for line in file:
    if "enumeration(Event" in line:
        in_event = True
    elif in_event:
        if '}' in line:
            break
        
        cleaned_arg = re.findall("[a-z|A-Z|_]+", line)
        if not cleaned_arg:
            continue

        states.append(cleaned_arg[0])

event_file = open("events.scala", "w")

event_file.write("package memGen.memory.cache\n\n\
import chisel3._\n\
import chisel3.util._\n\n\
object Events {\n\n\
\tval StateArray = Map(\n")

text = '\t\t(s"{state}", {index})'
for index, state in enumerate(states):
    event_file.write(text.format(state=state, index=hex(index)))
    if state is not states[-1]:
        event_file.write(', ')
    event_file.write('\n')

event_file.write("\t)\n\tval eventLen =  if (EventArray.size == 1 ) 1 else log2Ceil(EventArray.size)\n}")