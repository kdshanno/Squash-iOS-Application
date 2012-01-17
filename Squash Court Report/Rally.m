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
            if (self.finishingShot.intValue == kWinner || self.finishingShot.intValue == kStroke) {
                return self.p1Score.intValue-1;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError || self.finishingShot.intValue == kLet || self.finishingShot.intValue == kNoLet) {
                return self.p1Score.intValue;
            }
        }
        else {
            if (self.finishingShot.intValue == kWinner || self.finishingShot.intValue == kStroke || self.finishingShot.intValue == kLet) {
                return self.p1Score.intValue;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError || self.finishingShot.intValue == kNoLet) {
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
            if (self.finishingShot.intValue == kWinner || self.finishingShot.intValue == kStroke) {
                return self.p2Score.intValue-1;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError || self.finishingShot.intValue == kLet || self.finishingShot.intValue == kNoLet) {
                return self.p2Score.intValue;
            }
        }
        else {
            if (self.finishingShot.intValue == kWinner || self.finishingShot.intValue == kStroke || self.finishingShot.intValue == kLet) {
                return self.p2Score.intValue;
            }
            else if (self.finishingShot.intValue == kUnforcedError || self.finishingShot.intValue == kError || self.finishingShot.intValue == kNoLet) {
                return self.p2Score.intValue-1;
            }
        }
    }
    return -1;
    
    
}

- (courtAreaType)courtAreaType
{
    double x = [self.xPosition doubleValue];
    double y = [self.yPosition doubleValue];
    courtAreaType t;
    
    if(x < 0.5)
    {
        if(y < 0.46)
            t = CourtAreaFrontLeft;
        else if (y > 0.75)
            t = CourtAreaBackLeft;
        else
            t = CourtAreaMiddleLeft;
    }
    else
    {
        if(y < 0.46)
            t = CourtAreaFrontRight;
        else if (y > 0.75)
            t = CourtAreaBackRight;
        else
            t = CourtAreaMiddleRight;
    }
    
    return t;
}

- (NSString *)courtAreaString
{
    courtAreaType t = [self courtAreaType];
    switch (t) {
        case CourtAreaBackLeft:
            return @"Back-Left";
            break;

        case CourtAreaBackRight:
            return @"Back-Right";
            break;
            
        case CourtAreaMiddleLeft:
            return @"Mid-Left";
            break;
            
        case CourtAreaMiddleRight:
            return @"Mid-Right";
            break;
            
        case CourtAreaFrontLeft:
            return @"Front-Left";
            break;
            
        case CourtAreaFrontRight:
            return @"Front-Right";
            break;
            
        default:
            abort();
            break;
    }
}


@end
