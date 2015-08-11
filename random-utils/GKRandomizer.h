//
//  GKRandomizer.h
//  random-utils
//
//  Created by Grzegorz Krukowski on 11/08/15.
//  Copyright (c) 2015 GrzegorzKrukowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GKRandomizer : NSObject

#pragma mark - Not Seeded Methods

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

#pragma mark - Seeded Methods

/*!
 * Returns random int between given minimum (inclusive) and maximum (inclusive) using seeded random generator
 *
 * @param min Minimum value
 * @param max Maximum value
 * @param seed Seed value for random generator
 * @return random int between min (inclusive) and max (inclusive)
 */

+ (int) randomIntBetweenMin:(int)min andMax:(int)max andSeed:(unsigned) seed;

/*!
 * Returns random float between given minimum (inclusive) and maximum (inclusive) using seeded random generator
 *
 * @discussion It's guarantee that values will never go outside given range, but for floats it may never hit the minimum or maxmimum value due to float precision.
 * Problem of calculating range is solved by scaling up float values.
 * @param min Minimum value
 * @param max Maximum value
 * @param seed Seed value for random generator
 * @return random float between min (inclusive) and max (inclusive)
 */

+ (float) randomFloatBetweenMin:(float)min andMax:(float)max andSeed:(unsigned) seed;

@end
