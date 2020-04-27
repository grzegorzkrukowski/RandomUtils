//
//  RandomUtilsTests.m
//  random-utils
//
//  Created by Grzegorz Krukowski on 11/08/15.
//  Copyright (c) 2015 GrzegorzKrukowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "RandomUtils.h"

//testing random numbers usually required few iterations to gather results, to make sure tests are not failing randomly
#define ITERATIONS_SINGLE 1
#define ITERATIONS_FEW 100
#define ITERATIONS_MANY 1000

@interface RandomUtilsTests : XCTestCase

@end

@implementation RandomUtilsTests

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
        [RandomUtils setSeed:[RandomUtils randomSeed]];
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
        random = [RandomUtils randomIntBetweenMin:min andMax:max useSeed:useSeed];

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
    unsigned seed = [RandomUtils randomSeed];
    [RandomUtils setSeed:seed];

    int min = 0;
    int max = 1000;

    //generate first number
    int firstRandom = [RandomUtils randomIntBetweenMin:min andMax:max useSeed:YES];

    //every other number should be same as first one if we reseed the generator
    for (int i = 0; i < ITERATIONS_FEW; i++)
    {
        [RandomUtils setSeed:seed];
        int nextRandom = [RandomUtils randomIntBetweenMin:min andMax:max useSeed:YES];
        XCTAssertEqual(firstRandom, nextRandom);
    }

    //one of next numbers should be different than first random if we do not set seed
    BOOL same = YES;

    //still need to few iterations to make sure it's not randomly failing
    for (int i = 0; i < ITERATIONS_FEW; i++)
    {
        int nextRandom = [RandomUtils randomIntBetweenMin:min andMax:max useSeed:YES];
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
        [RandomUtils setSeed:[RandomUtils randomSeed]];
    }

    //for floats we just check if they are in range, can make range bigger
    float min = 5.0f;
    float max = 1005.0f;

    float random = 0;
    for (int i = 0; i < ITERATIONS_MANY; i++)
    {
        random = [RandomUtils randomFloatBetweenMin:min andMax:max useSeed:useSeed];
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
        XCTAssertTrue([RandomUtils randomEventOccurs:100.0f]);
        XCTAssertFalse([RandomUtils randomEventOccurs:0.0f]);
        numberOfOccurences += [RandomUtils randomEventOccurs:50.0f];
    }

    //50.0f chance should be more less equal to half of iterations
    XCTAssertEqualWithAccuracy(numberOfOccurences, ITERATIONS_FEW * 0.5f, ITERATIONS_FEW / 0.1f);
}

- (void) testRandomName
{
    int length = 10;
    NSString* randomName = [RandomUtils randomStringNameWithLength:length];
    XCTAssertEqual(length, [randomName length]);

    unsigned seed = [RandomUtils randomSeed];
    [RandomUtils setSeed:seed];
    NSString* randomNameSeed = [RandomUtils randomStringNameWithLength:length useSeed:YES];
    [RandomUtils setSeed:seed];
    XCTAssertEqualObjects(randomNameSeed, [RandomUtils randomStringNameWithLength:length useSeed:YES]);
}

- (void) testRandomStringWithCharctersFromString
{
    int length = 10;
    NSString* charset = @"qweasdzxc";
    NSString* randomString = [RandomUtils randomStringWithCharctersFromString:charset andLength:length];

    for (int i = 0; i < [randomString length]; i++)
    {
        unichar character = [randomString characterAtIndex:i];
        BOOL characterInCharset = [randomString rangeOfString:[NSString stringWithFormat:@"%c", character]].location != NSNotFound;
        XCTAssertTrue(characterInCharset);
    }
}

- (void) testRandomElementFromArray
{
    XCTAssertNil([RandomUtils randomElementFromArray:nil useSeed:NO]);
    XCTAssertNil([RandomUtils randomElementFromArray:nil useSeed:YES]);

    NSArray* array = @[@"a", @"b", @"c", @"d"];
    XCTAssertNotNil([RandomUtils randomElementFromArray:array useSeed:NO]);
    XCTAssertNotNil([RandomUtils randomElementFromArray:array useSeed:YES]);
}

- (void) testRandomElementFromDictionary
{
    XCTAssertNil([RandomUtils randomElementFromDictionary:nil useSeed:NO]);
    XCTAssertNil([RandomUtils randomElementFromDictionary:nil useSeed:YES]);

    NSDictionary* dict = @{ @"a" : @"a", @"b" : @"b", @"c" : @"c" };
    XCTAssertNotNil([RandomUtils randomElementFromDictionary:dict useSeed:NO]);
    XCTAssertNotNil([RandomUtils randomElementFromDictionary:dict useSeed:YES]);
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
        int index = [RandomUtils randomIndexWeighted:weights];
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
    UIColor* randomColor = [RandomUtils randomColor];
    XCTAssertNotNil(randomColor);
}

- (void) testShuffleArray
{
    NSArray* array = @[@(1), @(2), @(3), @(4), @(5), @(6), @(7)];
    NSMutableArray* mutableArray = [array mutableCopy];
    [RandomUtils shuffleArray:mutableArray];
    XCTAssertEqual([array count], [mutableArray count]);

    XCTAssertFalse([array isEqualToArray:mutableArray]);
    
    //test seeded shuffle
    unsigned seed = [RandomUtils randomSeed];
    NSMutableArray* array1 = [array mutableCopy];
    NSMutableArray* array2 = [array mutableCopy];
    [RandomUtils setSeed:seed];
    [RandomUtils shuffleArray:array1 useSeed:YES];
    [RandomUtils setSeed:seed];
    [RandomUtils shuffleArray:array2 useSeed:YES];
    XCTAssertTrue([array1 isEqualToArray:array2]);
}

@end
