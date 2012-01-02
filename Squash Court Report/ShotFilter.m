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

-(UIColor *)winnersColor
{
    return [UIColor greenColor];
}

-(UIColor *)errorsColor
{
    return [UIColor redColor];
}

-(UIColor *)unforcedErrorsColor
{
    return [UIColor orangeColor];
}

-(UIColor *)letsColor
{
    return [UIColor grayColor];
}

-(UIColor *)noLetsColor
{
    return [UIColor blackColor];
}

-(UIColor *)strokesColor
{
    return [UIColor blueColor];
}

@end




