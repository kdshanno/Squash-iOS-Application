//
//  Player.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Match.h"


@implementation Player

@dynamic dateBorn;
@dynamic handedness;
@dynamic firstName;
@dynamic lastName;
@dynamic matches;
@dynamic city;
@dynamic country;
@dynamic headCoach;
@dynamic homeClub;
@dynamic stateProvince;
@dynamic style;
@dynamic imageData;

- (void)setHanded:(int)handedness {
    self.handedness = [NSNumber numberWithInt:handedness];
}
- (int)getHanded {
    return [self.handedness intValue];
}

- (NSString *)getName:(nameType) nameType {
    switch (nameType) {
        case kFullName:
            return [self.firstName stringByAppendingFormat:@" %@", self.lastName];
            break;
        case kFirstInitialLastName:
            return [NSString stringWithFormat:@"%@. %@", [self.firstName characterAtIndex:0], self.lastName];
            break;
        case kFirstInitialLastInitial:
            return [NSString stringWithFormat:@"%@. %@.", [self.firstName characterAtIndex:0], [self.lastName characterAtIndex:0]];
            break;
        default:
            break;
    }
    return NULL;
}


- (void)setImage:(UIImage *)image {
    imageCache = image;
    self.imageData = UIImageJPEGRepresentation(image, 1.0);
}

- (UIImage *)getImage {
    if (imageCache) {
        return imageCache;
    }
    if (self.imageData) {
        return [UIImage imageWithData:self.imageData];

    }
    else return NULL;
}
-(int)getNumberOfWins {
    int wins = 0;
    for (Match *match in self.matches) {
        if (match.player1 == self) {
            if (match.p1GameScore > match.p2GameScore) {
                wins++;
            }
        }
        else {
            if (match.p2GameScore > match.p1GameScore) {
                wins++;
            }
        }
    }
    return  wins;

}

-(int)getNumberOfLosses {
    int losses = 0;
    for (Match *match in self.matches) {
        if (match.player1 == self) {
            if (match.p1GameScore < match.p2GameScore) {
                losses++;
            }
        }
        else {
            if (match.p2GameScore < match.p1GameScore) {
                losses++;
            }
        }
    }
    return  losses;
}

-(int)getNumberOfMatches {
    return [self.matches count];
}

@end
