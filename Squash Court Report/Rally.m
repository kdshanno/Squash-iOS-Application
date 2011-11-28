//
//  Rally.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Rally.h"
#import "Player.h"


@implementation Rally

@dynamic finishingShot;
@dynamic p1Score;
@dynamic p2Score;
@dynamic xPosition;
@dynamic yPosition;
@dynamic note;
@dynamic player;
@dynamic game;
@dynamic pointNumber;
@dynamic p1Finished;

-(int)getPreviousp1Score {
    if (self.p1Score.intValue == 0) {
        return 0;
    }
    if (self.finishingShot) {
        if (self.p1Finished.boolValue) {
            if (self.finishingShot.intValue == kWinner) {
                return self.p1Score.intValue-1;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError) {
                return self.p1Score.intValue;
            }
        }
        else {
            if (self.finishingShot.intValue == kWinner) {
                return self.p1Score.intValue;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError) {
                return self.p1Score.intValue-1;
            }
        }
    }
    return -1;
}

-(int)getPreviousp2Score {
    if (self.p2Score.intValue == 0) {
        return 0;
    }
    if (self.finishingShot) {
        if (!self.p1Finished.boolValue) {
            if (self.finishingShot.intValue == kWinner) {
                return self.p2Score.intValue-1;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError) {
                return self.p2Score.intValue;
            }
        }
        else {
            if (self.finishingShot.intValue == kWinner) {
                return self.p2Score.intValue;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError) {
                return self.p2Score.intValue-1;
            }
        }
    }
    return -1;
    
    
}


@end
