# RandomUtils

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
[RandomUtils setSeed:seed];
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //31
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //74
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //62
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //82
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //60

//reseeding the randomizer
[RandomUtils setSeed:seed];
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //31
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //74
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //62
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //82
NSLog(@"%d", [RandomUtils randomIntBetweenMin:0 andMax:100 useSeed:YES]); //60
```

Weighted randomization
--------------

Weighter randomization provides an easy way to randomly select an item from NSArray on NSDictionary based on weight connected to every element.

```Objective-C
NSArray* weights = @[@(75), @(24), @(1)];
int index = [RandomUtils randomIndexWeighted:weights];
```

In example above:
- first element has 75% chance to be randomed (75 / (75+24+1))
- second element has 24% chance to be randomed (25 / (75+24+1))
- third element has 1% chance to be randomed (1 / (75+24+1)) 

Installation
--------------

To use utils just drag the files into your project.

Installation with CocoaPods
--------------

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. 

#### Podfile

```ruby
pod 'RandomUtils'
```

ARC
------------------

Those tools requires ARC enabled.

Author
------------------

Grzegorz Krukowski, grkrukowski@gmail.com

License
------------------

RandomUtils is available under the MIT license. See the LICENSE file for more info.
