//
//  Player.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Game.h"
#import "Rally.h"


#import "Match.h"
#import "UIImageToDataTransformer.h"


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
@dynamic image;

+ (void)initialize {
	if (self == [Player class]) {
		UIImageToDataTransformer *transformer = [[UIImageToDataTransformer alloc] init];
		[NSValueTransformer setValueTransformer:transformer forName:@"UIImageToDataTransformer"];
	}
}

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
            return [NSString stringWithFormat:@"%@. %@", [self.firstName substringToIndex:1], self.lastName];
            break;
        case kFirstInitialLastInitial:
            return [NSString stringWithFormat:@"%@. %@.", [self.firstName substringToIndex:1], [self.lastName substringToIndex:1]];
            break;
        default:
            break;
    }
    return NULL;
}


-(int)getNumberOfWins {
    int wins = 0;
    for (Match *match in self.matches) {
        if (match.winner == self) {
            wins++;
        }
    }
    return  wins;

}

-(int)getNumberOfLosses {
    int losses = 0;
    for (Match *match in self.matches) {
        if (match.loser == self) {
            losses++;
        }    
    }
    return  losses;
}

-(int)getNumberOfMatches {
    return self.matches.count;
}

-(int)getNumberofWinnersPerMatch {
    int numberOfMatches = [self getNumberOfMatches];

    if (numberOfMatches == 0) {
        return 0;
    }
    int winners = 0;
    for (Match *match in self.matches) {
        if (match.player1 == self) {
            for (Game *game in match.games) {
                for (Rally *rally in game.rallies) {
                    if (rally.p1Finished.boolValue && rally.finishingShot.intValue == kWinner) {
                        winners++;
                    }
                }
            }

        }
        else {
            for (Game *game in match.games) {
                for (Rally *rally in game.rallies) {
                    if (!rally.p1Finished.boolValue && rally.finishingShot.intValue == kWinner) {
                        winners++;
                    }

                }
            }

        }
    }
    return winners/numberOfMatches;
}

-(int)getNumberofErrorsPerMatch {
    int numberOfMatches = [self getNumberOfMatches];
    
    if (numberOfMatches == 0) {
        return 0;
    }
    int errors = 0;
    for (Match *match in self.matches) {
        if (match.player1 == self) {
            for (Game *game in match.games) {
                for (Rally *rally in game.rallies) {
                    if (rally.p1Finished.boolValue && rally.finishingShot.intValue == kError) {
                        errors++;
                    }
                }
            }
            
        }
        else {
            for (Game *game in match.games) {
                for (Rally *rally in game.rallies) {
                    if (!rally.p1Finished.boolValue && rally.finishingShot.intValue == kError) {
                        errors++;
                    }
                    
                }
            }
            
        }
    }
    return errors/numberOfMatches;

}

@end
