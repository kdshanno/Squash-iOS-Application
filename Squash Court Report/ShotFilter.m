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

@end
