//
//  ShotFilter.m
//  Squash Court Report
//
//  Created by Rishi on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ShotFilter.h"

@implementation ShotFilter

@synthesize errors, winners, lets, noLets, strokes, unforcedErrors;

/**
 * Overrides superclass (NSObject) init method.
 */
-(ShotFilter *)init
{
    winners = NO;
    errors = NO;
    unforcedErrors = NO;
    strokes = NO;
    lets = NO;
    noLets = NO;
    
    return self;
}

-(ShotFilter *)initShowAll
{
    winners = YES;
    errors = YES;
    unforcedErrors = YES;
    strokes = YES;
    lets = YES;
    noLets = YES;
    
    return self;
}

+(UIColor *)winnersColor
{
    return [UIColor colorWithRed:0 green:0.5 blue:0 alpha:1];
}

+(UIColor *)errorsColor
{
    return [UIColor orangeColor];
}

+(UIColor *)unforcedErrorsColor
{
    return [UIColor redColor];
}

+(UIColor *)letsColor
{
    return [UIColor blackColor];
}

+(UIColor *)noLetsColor
{
    return [UIColor brownColor];
}

+(UIColor *)strokesColor
{
    return [UIColor blueColor];
}

+ (NSString *)stringForShotType:(ender)type
{
    switch (type) {
        case kError:
            return @"Error";
            break;
        case kLet:
            return @"Let";
            break; 
        case kNoLet:
            return @"No Let";
            break; 
        case kStroke:
            return @"Stroke";
            break; 
        case kWinner:
            return @"Winner";
            break; 
        case kUnforcedError:
            return @"Unforced";
            break;
        default:
            break;
    }
}

+ (UIColor *)colorForShotType:(ender)type
{
    switch (type) {
        case kError:
            return [ShotFilter errorsColor];
            break;
        case kLet:
            return [ShotFilter letsColor];
            break; 
        case kNoLet:
            return [ShotFilter noLetsColor];
            break; 
        case kStroke:
            return [ShotFilter strokesColor];
            break; 
        case kWinner:
            return [ShotFilter winnersColor];
            break; 
        case kUnforcedError:
            return [ShotFilter unforcedErrorsColor];
            break;
        default:
            break;
    }
}

@end




