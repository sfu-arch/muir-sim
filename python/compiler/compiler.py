import sys
from eventExtractor import extract_events
from routineExtractor import *
from stateExtractor import *

if __name__ == "__main__":
    location = "MI_example-cache.sm"
    if len(sys.argv) > 1:
        location = sys.argv[1]
        
    extract_events(location)
    extract_routines(location)
    extract_states(location)