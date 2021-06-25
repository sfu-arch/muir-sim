condition: 
```
	actual result = (hash &= mask2) < nbucket ? hash : hash & mask1;
```

Hash STR:
```
    y = 0;
	for (i = 0; key[i]; i++) {
		y += key[i];
		y += (y << 10);
		y ^= (y >> 6);
	}
	y += (y << 3);
	y ^= (y >> 11);
	y += (y << 15);
```
Hash INT:
```
    ((unsigned int) (key) >> 7)  ^ 
    ((unsigned int) (key) >> 13) ^ 
    ((unsigned int) (key) >> 21) ^ 
    (unsigned int) (key))
```

Hash LONG:
```
    ( (unsigned long) (key) >> 7)  ^	
    ( (unsigned long) (key) >> 13) ^	
    ( (unsigned long) (key) >> 21) ^	
    ( (unsigned long) (key) >> 31) ^	
    ( (unsigned long) (key) >> 38) ^	
    ( (unsigned long) (key) >> 46) ^	
    ( (unsigned long) (key) >> 56) ^	
    ( (unsigned long) (key))
```
