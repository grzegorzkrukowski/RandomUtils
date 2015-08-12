//
//  GKRandomizer.h
//  random-utils
//
//  Created by Grzegorz Krukowski on 11/08/15.
//  Copyright (c) 2015 GrzegorzKrukowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKRandomizer : NSObject

#pragma mark - Generate random numbers with seed control

/*!
 * Returns random int between given minimum (inclusive) and maximum (inclusive) and option to use seed
 *
 * @param min Minimum value
 * @param max Maximum value
 * @param useSeed BOOL indicates if random generator should use seed
 * @see setSeed:
 * @return random int between min (inclusive) and max (inclusive)
 */

+ (int) randomIntBetweenMin:(int)min andMax:(int)max useSeed:(BOOL) useSeed;

/*!
 * Returns random float between given minimum (inclusive) and maximum (inclusive) and option to use seed
 *
 * @discussion It's guarantee that values will never go outside given range, but for floats it may never hit the minimum or maxmimum value due to float precision.
 * Problem of calculating range is solved by scaling up float values.
 * @param min Minimum value
 * @param max Maximum value
 * @param useSeed BOOL indicates if random generator should use seed
 * @see setSeed:
 * @return random float between min (inclusive) and max (inclusive)
 */

+ (float) randomFloatBetweenMin:(float)min andMax:(float)max useSeed:(BOOL) useSeed;

/*!
 * Checks if random event should happen based on a given probability from 0.0f to 100.0f (0.0f - never, 100.0f - always)
 *
 * @param chance Desired probability for an event
 * @param useSeed BOOL indicates if random generator should use seed
 * @return results BOOL YES if event should occur, which means random probability > desired chance
 */

+ (BOOL) randomEventOccurs:(float) chance useSeed:(BOOL) useSeed;

#pragma mark - Seed helpers

/*!
 * Generate random seed value that can be used for seeding
 * @see setSeed:
 * @return random seed value
 */

+ (unsigned) randomSeed;

/*!
 * Set seed value for all seeded methods
 *
 * @param seed Seed value
 */

+ (void) setSeed:(unsigned)seed;

#pragma mark - Generate random numbers without seed

/*!
 * Returns random int between given minimum (inclusive) and maximum (inclusive) using not seeded random generator
 *
 * @param min Minimum value
 * @param max Maximum value
 * @return random int between min (inclusive) and max (inclusive)
 */

+ (int) randomIntBetweenMin:(int)min andMax:(int)max;

/*!
 * Returns random float between given minimum (inclusive) and maximum (inclusive) using not seeded random generator
 *
 * @discussion It's guarantee that values will never go outside given range, but for floats it may never hit the minimum or maxmimum value due to float precision.
 * Problem of calculating range is solved by scaling up float values.
 * @param min Minimum value
 * @param max Maximum value
 * @return random float between min (inclusive) and max (inclusive)
 */

+ (float) randomFloatBetweenMin:(float)min andMax:(float)max;

/*!
 * Checks if random event should happen based on a given probability from 0.0f to 100.0f (0.0f - never, 100.0f - always)
 *
 * @param chance Desired probability for an event
 * @return results BOOL YES if event should occur, which means random probability > desired chance
 */

+ (BOOL) randomEventOccurs:(float) chance;

@end
