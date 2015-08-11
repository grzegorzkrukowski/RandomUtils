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
 * Returns random number between given minimum (inclusive) and maximum (inclusive) using not seeded random generator
 *
 * @param min Minimum value
 * @param max Maximum value
 * @return random number between min (inclusive) and max (inclusive)
 */

+ (int) randomIntBetweenMin:(int)min andMax:(int)max;

#pragma mark - Seeded Methods

/*!
 * Returns random number between given minimum (inclusive) and maximum (inclusive) using seeded random generator
 *
 * @param min Minimum value
 * @param max Maximum value
 * @return random number between min (inclusive) and max (inclusive)
 */

+ (int) randomIntBetweenMin:(int)min andMax:(int)max andSeed:(unsigned) seed;

@end
