# random-utils
Utilities to work with random numbers in Objective-C

This set of utils allows to easily generate random numbers in desired range, select random element from arrays, dictionaries and generate random strings of desired length.

All allows generate random sequences that are repeatable by using their version with seed.

```ios
unsigned seed = [GKRandomizer randomSeed];
[GKRandomizer setSeed:seed];
[GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
[GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
[GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
[GKRandomizer setSeed:seed];
[GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
[GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
[GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
```
