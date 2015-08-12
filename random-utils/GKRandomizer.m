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
@end

@implementation GKRandomizer

#pragma mark - Generating random numbers

+ (int) randomIntBetweenMin:(int)min andMax:(int)max useSeed:(BOOL) useSeed
{
    if(min == max) return min;
    
    //make sure that min < max
    int realMin = MIN(min, max);
    int realMax = MAX(min, max);
    int range = realMax - realMin + 1;
    if(useSeed)
    {
        return realMin + random() % range;
    }
    else
    {
        return realMin + arc4random_uniform(range);
    }
}

+ (float) randomFloatBetweenMin:(float)min andMax:(float)max useSeed:(BOOL) useSeed;
{
    //float values are scaled up and send as integers to make calculation of range for floats possible
    int scaleUp = 1000;
    int minScaled = min * scaleUp;
    int maxScaled = max * scaleUp;

    float randomValue = (float) [[self class] randomIntBetweenMin:minScaled andMax:maxScaled useSeed:useSeed];
    return (randomValue / (float)scaleUp);
}

+ (BOOL) randomEventOccurs:(float) chance useSeed:(BOOL) useSeed
{
    if(chance == 0.0f)
    {
        return NO;
    }
    
    if(chance == 100.0f)
    {
        return YES;
    }
    
    float randomedValue = [[self class] randomFloatBetweenMin:0.0f andMax:100.0f useSeed:useSeed];
    return chance >= randomedValue;
}

#pragma mark - Seed helpers

+ (unsigned) randomSeed
{
    return arc4random_uniform(INT_MAX);
}

+ (void) setSeed:(unsigned)seed
{
    srandom(seed);
}

#pragma mark - Generate random numbers without seed

+ (int) randomIntBetweenMin:(int)min andMax:(int)max
{
    return [[self class] randomIntBetweenMin:min andMax:max useSeed:NO];
}

+ (float) randomFloatBetweenMin:(float)min andMax:(float)max;
{
    return [[self class] randomFloatBetweenMin:min andMax:max useSeed:NO];
}

+ (BOOL) randomEventOccurs:(float) chance
{
    return [[self class] randomEventOccurs:chance useSeed:NO];
}

@end
