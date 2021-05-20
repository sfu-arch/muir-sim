import re
import sys

location = "MI_example-cache.sm"
if len(sys.argv) > 1:
    location = sys.argv[1]

file = open(location, 'r')

arg_set = []
in_transition = False
transition_args = []
action_set = []

for line in file:
    if "transition" in line:
        in_transition = True
        tuple_index = 0
        args = line.split("(")[1].split(')')[0]
        args = re.findall("\{[\s|a-z|A-Z|_|,]+\}|[a-z|A-Z|_|,]+", args)
        for arg in args:
            cleaned_arg = re.findall("[a-zA-Z_]+", arg)
            if not cleaned_arg:
                continue
            transition_args.append(cleaned_arg)
    elif in_transition:
        if '}' in line:
            in_transition = False
            transition_args.append(action_set)
            arg_set.append(transition_args)
            transition_args = []
            action_set = []
            continue
        cleaned_arg = re.findall("[a-z|A-Z|_]+", line)
        if 'z_stall' in cleaned_arg:
            cleaned_arg = ['set_state']
        action_set.append(cleaned_arg)
        

routine_file = open("Routine.scala", "w")

routine_file.write("package memGen.memory.cache\n\n")
routine_file.write("object RoutineROM {\n\n")
routine_file.write("\tval routineActions = Array [RoutinePC](\n")

for transition_args in arg_set:
    for instruction in transition_args[1]:
        for state in transition_args[0]:
            actions = ''
            for action in transition_args[-1]:
                actions += '"' + action[0] +'"'
                if action is not transition_args[-1][-1]:
                    actions += ', '
            routine_file.write("\tRoutine (" + instruction + "_" + state + "), Actions(Seq(" + actions +  "))\n")

routine_file.write(')\n')


