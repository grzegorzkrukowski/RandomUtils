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

- (void) testRandomName
{
    int length = 10;
    NSString* randomName = [GKRandomizer randomStringNameWithLength:length];
    XCTAssertEqual(length, [randomName length]);

    unsigned seed = [GKRandomizer randomSeed];
    [GKRandomizer setSeed:seed];
    NSString* randomNameSeed = [GKRandomizer randomStringNameWithLength:length useSeed:YES];
    [GKRandomizer setSeed:seed];
    XCTAssertEqualObjects(randomNameSeed, [GKRandomizer randomStringNameWithLength:length useSeed:YES]);
}

- (void) testRandomStringWithCharctersFromString
{
    int length = 10;
    NSString* charset = @"qweasdzxc";
    NSString* randomString = [GKRandomizer randomStringWithCharctersFromString:charset andLength:length];

    for (int i = 0; i < [randomString length]; i++)
    {
        unichar character = [randomString characterAtIndex:i];
        BOOL characterInCharset = [randomString rangeOfString:[NSString stringWithFormat:@"%c", character]].location != NSNotFound;
        XCTAssertTrue(characterInCharset);
    }
}

- (void) testRandomElementFromArray
{
    XCTAssertNil([GKRandomizer randomElementFromArray:nil useSeed:NO]);
    XCTAssertNil([GKRandomizer randomElementFromArray:nil useSeed:YES]);

    NSArray* array = @[@"a", @"b", @"c", @"d"];
    XCTAssertNotNil([GKRandomizer randomElementFromArray:array useSeed:NO]);
    XCTAssertNotNil([GKRandomizer randomElementFromArray:array useSeed:YES]);
}

- (void) testRandomElementFromDictionary
{
    XCTAssertNil([GKRandomizer randomElementFromDictionary:nil useSeed:NO]);
    XCTAssertNil([GKRandomizer randomElementFromDictionary:nil useSeed:YES]);

    NSDictionary* dict = @{ @"a" : @"a", @"b" : @"b", @"c" : @"c" };
    XCTAssertNotNil([GKRandomizer randomElementFromDictionary:dict useSeed:NO]);
    XCTAssertNotNil([GKRandomizer randomElementFromDictionary:dict useSeed:YES]);
}

- (void) testWeightRandomizer
{
    NSArray* weights = @[@(75), @(24), @(1)];
    NSMutableArray* results = [NSMutableArray array];

    float chancesSum = 0.0f;
    for(int i = 0; i < weights.count; i++)
    {
        chancesSum += [[weights objectAtIndex:i] intValue];
        [results addObject:[NSNumber numberWithInt:0]];
    }

    int testsCount = ITERATIONS_MANY;
    for(int i = 0; i < testsCount; i++)
    {
        int index = [GKRandomizer randomIndexWeighted:weights];
        NSNumber* number = [results objectAtIndex:index];
        [results replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:[number intValue]+1]];
    }

    for(int i=0 ; i < weights.count; i++)
    {
        NSNumber* weight = [weights objectAtIndex:i];
        NSNumber* result = [results objectAtIndex:i];

        float orginalChance = [weight floatValue] / chancesSum;
        float resultChance = [result floatValue] / testsCount;
        XCTAssertEqualWithAccuracy(orginalChance, resultChance, 0.1f);
    }
}

- (void) testRandomColor
{
    UIColor* randomColor = [GKRandomizer randomColor];
    XCTAssertNotNil(randomColor);
}

- (void) testShuffleArray
{
    NSArray* array = @[@(1), @(2), @(3), @(4), @(5), @(6), @(7)];
    NSMutableArray* mutableArray = [array mutableCopy];
    [GKRandomizer shuffleArray:mutableArray];
    XCTAssertEqual([array count], [mutableArray count]);

    XCTAssertFalse([array isEqualToArray:mutableArray]);
}

@end
