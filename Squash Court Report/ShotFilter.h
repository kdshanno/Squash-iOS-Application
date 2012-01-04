//
//  ShotFilter.h
//  Squash Court Report
//
//  Created by Rishi on 12/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Rally.h"

typedef enum {
    CourtAreaFrontLeft = 0,
    CourtAreaFrontRight = 1,
    CourtAreaMiddleLeft = 2,
    CourtAreaMiddleRight = 3,
    CourtAreaBackLeft = 4,
    CourtAreaBackRight = 5,
    CourtAreaFullCourt = 6
} courtAreaType;

@interface ShotFilter : NSObject {    
    BOOL winners;
    BOOL errors;
    BOOL unforcedErrors;
    BOOL lets;
    BOOL noLets;
    BOOL strokes;
    int gameNumber;
    int courtArea;
}

@property(nonatomic, assign) BOOL winners;
@property(nonatomic, assign) BOOL errors;
@property(nonatomic, assign) BOOL unforcedErrors;
@property(nonatomic, assign) BOOL lets;
@property(nonatomic, assign) BOOL noLets;
@property(nonatomic, assign) BOOL strokes;
@property(nonatomic, assign) int gameNumber;
@property(nonatomic, assign) int courtArea;

+(UIColor *)winnersColor;
+(UIColor *)errorsColor;
+(UIColor *)unforcedErrorsColor;
+(UIColor *)letsColor;
+(UIColor *)noLetsColor;
+(UIColor *)strokesColor;

+ (NSString *)stringForShotType:(ender)type;
+ (UIColor *)colorForShotType:(ender)type;

-(ShotFilter *)init;
-(ShotFilter *)initShowAll;

@end
