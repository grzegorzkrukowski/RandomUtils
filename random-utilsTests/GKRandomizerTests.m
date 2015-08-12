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
    [self testRandomIntBetweenUsingSeed:NO];
}

- (void) testRandomIntBetweenSeeded
{
    [self testRandomIntBetweenUsingSeed:YES];
}

- (void) testRandomIntBetweenUsingSeed:(BOOL) useSeed
{
    if(useSeed)
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
        random = [GKRandomizer randomIntBetweenMin:min andMax:max useSeed:useSeed];

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

- (void) testSeeding
{
    unsigned seed = [GKRandomizer randomSeed];
    [GKRandomizer setSeed:seed];

    int min = 0;
    int max = 1000;

    //generate first number
    int firstRandom = [GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];

    //every other number should be same as first one if we reseed the generator
    for (int i = 0; i < ITERATIONS_FEW; i++)
    {
        [GKRandomizer setSeed:seed];
        int nextRandom = [GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
        XCTAssertEqual(firstRandom, nextRandom);
    }

    //one of next numbers should be different than first random if we do not set seed
    BOOL same = YES;

    //still need to few iterations to make sure it's not randomly failing
    for (int i = 0; i < ITERATIONS_FEW; i++)
    {
        int nextRandom = [GKRandomizer randomIntBetweenMin:min andMax:max useSeed:YES];
        if(nextRandom != firstRandom)
        {
            same = NO;
            break;
        }
    }
    XCTAssertFalse(same);
}

- (void) testRandomFloatBetween
{
    [self testRandomFloatBetweenUsingSeed:NO];
}

- (void) testRandomFloatBetweenSeeded
{
    [self testRandomFloatBetweenUsingSeed:YES];
}

- (void) testRandomFloatBetweenUsingSeed:(BOOL) useSeed
{
    if(useSeed)
    {
        [GKRandomizer setSeed:[GKRandomizer randomSeed]];
    }

    //for floats we just check if they are in range, can make range bigger
    float min = 5.0f;
    float max = 1005.0f;

    float random = 0;
    for (int i = 0; i < ITERATIONS_MANY; i++)
    {
        random = [GKRandomizer randomFloatBetweenMin:min andMax:max useSeed:useSeed];
        //check if it's in range
        XCTAssertGreaterThanOrEqual(random, min);
        XCTAssertLessThanOrEqual(random, max);
    }
}

- (void) testRandomEventOccurs
{
    int numberOfOccurences = 0;
    for (int i = 0; i < ITERATIONS_FEW; i++)
    {
        XCTAssertTrue([GKRandomizer randomEventOccurs:100.0f]);
        XCTAssertFalse([GKRandomizer randomEventOccurs:0.0f]);
        numberOfOccurences += [GKRandomizer randomEventOccurs:50.0f];
    }

    //50.0f chance should be more less equal to half of iterations
    XCTAssertEqualWithAccuracy(numberOfOccurences, ITERATIONS_FEW * 0.5f, ITERATIONS_FEW / 0.1f);
}

@end
