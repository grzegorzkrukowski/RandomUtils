//
//  RandomUtils.m
//  RandomUtils
//
//  Created by Grzegorz Krukowski on 11/08/15.
//  Copyright (c) 2015 GrzegorzKrukowski. All rights reserved.
//

#import "RandomUtils.h"

//private interface
@interface RandomUtils ()
@end

@implementation RandomUtils

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

+ (int) randomIntBetweenMin:(int)min andMax:(int)max
{
    return [[self class] randomIntBetweenMin:min andMax:max useSeed:NO];
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

+ (float) randomFloatBetweenMin:(float)min andMax:(float)max;
{
    return [[self class] randomFloatBetweenMin:min andMax:max useSeed:NO];
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

+ (BOOL) randomEventOccurs:(float) chance
{
    return [[self class] randomEventOccurs:chance useSeed:NO];
}

#pragma mark - Generate random NSString

+ (NSString *) randomStringNameWithLength:(int) length
{
    return [[self class] randomStringNameWithLength:length useSeed:NO];
}

+ (NSString *) randomStringNameWithLength:(int) length useSeed:(BOOL) useSeed
{
    return [[self class] randomStringWithCharctersFromString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" andLength:length useSeed:useSeed];
}

+ (NSString *) randomStringNumberWithLength:(int) length
{
    return [[self class] randomStringNumberWithLength:length useSeed:NO];
}

+ (NSString *) randomStringNumberWithLength:(int) length useSeed:(BOOL) useSeed
{
    return [[self class] randomStringWithCharctersFromString:@"0123456789" andLength:length];
}

+ (NSString *) randomStringWithCharctersFromString:(NSString*) charset andLength: (int) length
{
    return [[self class] randomStringWithCharctersFromString:charset andLength:length useSeed:NO];
}

+ (NSString *) randomStringWithCharctersFromString:(NSString*) charset andLength: (int) length useSeed:(BOOL) useSeed
{
    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    for (int i=0; i<length; i++)
    {
        [randomString appendFormat: @"%C", [charset characterAtIndex:[[self class] randomIntBetweenMin:0 andMax:(int)[charset length] - 1 useSeed:useSeed]]];
    }
    return randomString;
}

#pragma mark - Random elements methods

+ (id) randomElementFromArray:(NSArray*) array
{
    return [[self class] randomElementFromArray:array useSeed:NO];
}

+ (id) randomElementFromArray:(NSArray*) array useSeed:(BOOL) useSeed
{
    if([array count] > 0)
    {
        return [array objectAtIndex:[[self class] randomIntBetweenMin:0 andMax:((int) [array count] - 1) useSeed:useSeed]];
    }

    return nil;
}

+ (id) randomElementFromDictionary:(NSDictionary*) dictionary
{
    return [[self class] randomElementFromDictionary:dictionary useSeed:NO];
}

+ (id) randomElementFromDictionary:(NSDictionary*) dictionary useSeed:(BOOL) useSeed
{
    return [[self class] randomElementFromArray:[dictionary allKeys] useSeed:useSeed];
}

#pragma mark - Weigthed randomizer methods

+ (int) randomIndexWeighted:(NSArray *)weights
{
    return [[self class] randomIndexWeighted:weights useSeed:NO];
}

+ (int) randomIndexWeighted:(NSArray *)weights useSeed:(BOOL) useSeed
{
    int weightSum = 0;
    for(int weightIndex = 0; weightIndex < weights.count; weightIndex++)
    {
        weightSum += [[weights objectAtIndex:weightIndex] intValue];
    }

    int randomNumber = [[self class] randomIntBetweenMin:0 andMax:weightSum useSeed:useSeed];

    int elementIndex = 0;
    int currentWeightSum = 0;
    for(elementIndex = 0; elementIndex < weights.count; elementIndex++)
    {
        int elementWeight = [[weights objectAtIndex:elementIndex] intValue];
        currentWeightSum += elementWeight;

        if(currentWeightSum >= randomNumber)
        {
            break;
        }
    }
    
    return elementIndex;
}

+ (id) randomKeyBasedOnWeights:(NSDictionary*) weights
{
    return [[self class] randomKeyBasedOnWeights:weights useSeed:NO];
}

+ (id) randomKeyBasedOnWeights:(NSDictionary*) weights useSeed:(BOOL) useSeed
{
    int weightSum = 0;
    id key;
    for (key in weights) {
        weightSum += [[weights objectForKey:key] intValue];
    }

    //Always uses seeded random, as long as we don't need option to use arc4random and random on same scene
    int randomNumber = [[self class] randomIntBetweenMin:0 andMax:weightSum useSeed:useSeed];
    int currentWeightSum = 0;

    key = nil;
    for (key in weights) {
        
        weightSum += [[weights objectForKey:key] intValue];
        
        int elementWeight = [[weights objectForKey:key] intValue];
        currentWeightSum += elementWeight;
        
        if(currentWeightSum >= randomNumber)
        {
            break;
        }
        
    }

    return key;
}

#pragma mark - Random Color

+ (UIColor*) randomColor
{
    return [[self class] randomColorUseSeed:NO];
}

+ (UIColor*) randomColorUseSeed:(BOOL)useSeed
{
    CGFloat hue = [[self class] randomFloatBetweenMin:0.0f andMax:1.0f];
    CGFloat saturation = [[self class] randomFloatBetweenMin:0.0f andMax:1.0f];
    CGFloat brightness = [[self class] randomFloatBetweenMin:0.0f andMax:1.0f];
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

#pragma mark - Shuffling

+ (void) shuffleArray:(NSMutableArray*) array
{
    [[self class] shuffleArray:array useSeed:NO];
}

+ (void) shuffleArray:(NSMutableArray*) array useSeed:(BOOL) useSeed
{
    for (int i = (int)[array count] - 1; i > 0; i--)
    {
        int j = [[self class] randomIntBetweenMin:0 andMax:i+1];
        [array exchangeObjectAtIndex:j withObjectAtIndex:i];
    }
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

@end
