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
@dynamic city;
@dynamic country;
@dynamic headCoach;
@dynamic homeClub;
@dynamic stateProvince;
@dynamic style;
@dynamic image;
@dynamic matchesIAmPlayer2;
@dynamic matchesIAmPlayer1;
@dynamic rallies;

@synthesize numberOfWins, numberOfLosses, numberOfMatches, averageLetsPerMatch, averageErrorsPerMatch, averageNoLetsPerMatch, averageStrokesPerMatch, averageWinnersPerMatch, averageUnforcedErrorsPerMatch, totalLets, totalErrors, totalNoLets, totalStrokes, totalWinners, totalUnforcedErrors;

+ (void)initialize {
	if (self == [Player class]) {
		UIImageToDataTransformer *transformer = [[UIImageToDataTransformer alloc] init];
		[NSValueTransformer setValueTransformer:transformer forName:@"UIImageToDataTransformer"];
	}
}

- (NSSet *)matches {
    return [self.matchesIAmPlayer1 setByAddingObjectsFromSet:self.matchesIAmPlayer2];
    
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


//STATS
-(int)numberOfMatches {
    return self.matches.count;
}

-(int)numberOfWins {
    int wins = 0;
    for (Match *match in self.matches) {
        if (match.winner == self) {
            wins++;
        }
    }
    return  wins;
}

-(int)numberOfLosses {
    int losses = 0;
    for (Match *match in self.matches) {
        if (match.loser == self) {
            losses++;
        }    
    }
    return  losses;
}

-(int)totalWinners {
    int winners = 0;
    for (Rally *rally in self.rallies) {
        if (rally.finishingShot.intValue == kWinner) {
            winners++;
        }
    }
    return winners;    
}

-(int)totalErrors {
    int errors = 0;
    for (Rally *rally in self.rallies) {
        if (rally.finishingShot.intValue == kError) {
            errors++;
        }
    }
    return errors;    
}

-(int)totalUnforcedErrors {
    int unforcedErrors= 0;
    for (Rally *rally in self.rallies) {
        if (rally.finishingShot.intValue == kUnforcedError) {
            unforcedErrors++;
        }
    }
    return unforcedErrors;    
}

-(int)totalLets {
    int lets = 0;
    for (Rally *rally in self.rallies) {
        if (rally.finishingShot.intValue == kLet) {
            lets++;
        }
    }
    return lets;    
}

-(int)totalNoLets {
    int noLets = 0;
    for (Rally *rally in self.rallies) {
        if (rally.finishingShot.intValue == kNoLet) {
            noLets++;
        }
    }
    return noLets;    
}

-(int)totalStrokes {
    int strokes = 0;
    for (Rally *rally in self.rallies) {
        if (rally.finishingShot.intValue == kStroke) {
            strokes++;
        }
    }
    return strokes;    
}

-(float)averageWinnersPerMatch {
    return (float)self.totalWinners/self.numberOfMatches;
}

-(float)averageErrorsPerMatch {
    return (float)self.totalErrors/self.numberOfMatches;
}

-(float)averageUnforcedErrorsPerMatch {
    return (float)self.totalUnforcedErrors/self.numberOfMatches;
}

-(float)averageLetsPerMatch {
    return (float)self.totalLets/self.numberOfMatches;
}

-(float)averageNoLetsPerMatch {
    return (float)self.totalNoLets/self.numberOfMatches;
}

-(float)averageStrokesPerMatch {
    return (float)self.totalStrokes/self.numberOfMatches;
}


//END STATS


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
    int tnumberOfMatches = [self getNumberOfMatches];

    if (tnumberOfMatches == 0) {
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
    return winners/tnumberOfMatches;
}

-(int)getNumberofErrorsPerMatch {
    int tnumberOfMatches = [self getNumberOfMatches];
    
    if (tnumberOfMatches == 0) {
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
    return errors/tnumberOfMatches;

}

@end
