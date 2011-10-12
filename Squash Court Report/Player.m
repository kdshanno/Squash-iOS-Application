//
//  Player.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

@dynamic dateBorn;
@dynamic handedness;
@dynamic firstName;
@dynamic lastName;
@dynamic matches;

- (void)setHanded:(int)handedness {
    self.handedness = [NSNumber numberWithInt:handedness];
}
- (int)getHanded {
    return [self.handedness intValue];
}

- (NSString *)getFullName {
    return [self.firstName stringByAppendingFormat:@" %@", self.lastName];
    
}


@end
