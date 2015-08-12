# random-utils

General
--------------
Utilities to work with random numbers in Objective-C

This set of utils allows to easily generate random numbers in desired range, select random element from arrays, dictionaries and generate random strings of desired length.

All allows generate random sequences that are repeatable by using their version with seed.
Seeding the randomizer with same value, will always generate same sequences.

Example:
--------------

```Objective-C
unsigned seed = 100;
[GKRandomizer setSeed:seed];
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //31
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //74
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //62
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //82
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //60

//reseeding the randomizer
[GKRandomizer setSeed:seed];
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //31
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //74
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //62
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //82
NSLog(@"%d", [GKRandomizer randomIntBetweenMin:0 andMax:100 useSeed:YES]); //60
```

Installation
--------------

To use utils just drag the files into your project.

ARC
------------------

Those tools requires ARC enabled.