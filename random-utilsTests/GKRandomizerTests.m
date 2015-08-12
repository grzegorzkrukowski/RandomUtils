//
//  GKRandomizerTests.m
//  random-utils
//
//  Created by Grzegorz Krukowski on 11/08/15.
//  Copyright (c) 2015 GrzegorzKrukowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "GKRandomizer.h"

//testing random numbers usually required few iterations to gather results, to make sure tests are not failing randomly
#define ITERATIONS_SINGLE 1
#define ITERATIONS_FEW 100
#define ITERATIONS_MANY 1000

@interface GKRandomizerTests : XCTestCase

@end

@implementation GKRandomizerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testRandomIntBetween
{
    [self testRandomIntBetweenSeeded:NO];
}

- (void) testRandomIntBetweenSeeded
{
    [self testRandomIntBetweenSeeded:YES];
}

- (void) testRandomIntBetweenSeeded:(BOOL) seeded
{
    if(seeded)
    {
        [GKRandomizer setSeed:[GKRandomizer randomSeed]];
    }

    //keeping range small, to make sure testing border hits always works
    int min = 5;
    int max = 10;

    //flags to check if randomizer hit the borders of given range
    BOOL minRandom = NO;
    BOOL maxRandom = NO;
    int random = 0;
    for (int i = 0; i < ITERATIONS_MANY; i++)
    {
        if(seeded)
        {
            random = [GKRandomizer randomSeedIntBetweenMin:min andMax:max];
        }
        else
        {
            random = [GKRandomizer randomIntBetweenMin:min andMax:max];
        }

        if(random == min)
        {
            minRandom = YES;
        }

        if(random == max)
        {
            maxRandom = YES;
        }

        //check if it's in range
        XCTAssertGreaterThanOrEqual(random, min);
        XCTAssertLessThanOrEqual(random, max);
    }

    //check if borders were randomed
    XCTAssertTrue(minRandom);
    XCTAssertTrue(maxRandom);
}

- (void) testRandomFloatBetween
{
    [self testRandomFloatBetweenSeeded:NO];
}

- (void) testRandomFloatBetweenSeeded
{
    [self testRandomFloatBetweenSeeded:YES];
}

- (void) testRandomFloatBetweenSeeded:(BOOL) seeded
{
    if(seeded)
    {
        [GKRandomizer setSeed:[GKRandomizer randomSeed]];
    }

    //for floats we just check if they are in range, can make range bigger
    float min = 5.0f;
    float max = 1005.0f;

    float random = 0;
    for (int i = 0; i < ITERATIONS_MANY; i++)
    {
        if(seeded)
        {
            random = [GKRandomizer randomSeedFloatBetweenMin:min andMax:max];
        }
        else
        {
            random = [GKRandomizer randomFloatBetweenMin:min andMax:max];
        }

        //check if it's in range
        XCTAssertGreaterThanOrEqual(random, min);
        XCTAssertLessThanOrEqual(random, max);
    }
}


@end
