//
//  GKRandomizer.h
//  random-utils
//
//  Created by Grzegorz Krukowski on 11/08/15.
//  Copyright (c) 2015 GrzegorzKrukowski. All rights reserved.
//

#import "GKRandomizer.h"

//private interface
@interface GKRandomizer ()
+ (void) setSeed:(unsigned)seed;
+ (int) randomIntBetweenMin:(int)min andMax:(int)max andSeeded:(BOOL) seeded;
@end

@implementation GKRandomizer

#pragma mark - Private methods

+ (void) setSeed:(unsigned)seed
{
    srandom(seed);
}

+ (int) randomIntBetweenMin:(int)min andMax:(int)max andSeeded:(BOOL) seeded
{
    if(min == max) return min;

    //make sure that min < max
    int realMin = MIN(min, max);
    int realMax = MAX(min, max);
    int range = realMax - realMin + 1;
    if(seeded)
    {
        return realMin + random() % range;
    }
    else
    {
        return realMin + arc4random_uniform(range);
    }
}

#pragma mark - Not Seeded Methods

+ (int) randomIntBetweenMin:(int)min andMax:(int)max
{
    return [[self class] randomIntBetweenMin:min andMax:max andSeeded:NO];
}

#pragma mark - Seeded Methods

+ (int) randomIntBetweenMin:(int)min andMax:(int)max andSeed:(unsigned) seed
{
    [[self class] setSeed:seed];
    return [[self class] randomIntBetweenMin:min andMax:max andSeeded:YES];
}

@end
