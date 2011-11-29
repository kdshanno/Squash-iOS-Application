//
//  Match.m
//  Squash Court Report
//
//  Created by Max Shaw on 10/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Match.h"
#import "Player.h"


@implementation Match

@dynamic numberOfGames;
@dynamic p1GameScore;
@dynamic p2GameScore;
@dynamic datePlayed;
@dynamic player1;
@dynamic player2;
@dynamic games;
@dynamic city;
@dynamic complex;
@dynamic country;
@dynamic courtCondition;
@dynamic drawRound;
@dynamic matchType;
@dynamic notes;
@dynamic provinceState;
@dynamic recordingType;
@dynamic tournamentName;
@dynamic pointsPerGame;


-(Player *)winner {
    if (self.p1GameScore.intValue > self.p2GameScore.intValue) {
        return self.player1;
    }
    if (self.p2GameScore.intValue > self.p1GameScore.intValue) {
        return self.player2;
    }
    return NULL;
}

-(Player *)loser {
    if (self.p1GameScore.intValue > self.p2GameScore.intValue) {
        return self.player2;
    }
    if (self.p2GameScore.intValue > self.p1GameScore.intValue) {
        return self.player1;
    }
    return NULL;
}


@end
