//
//  DataSys.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConfig.h"

#define ScoreKey OC("ScoreKey")
#define LevelKey OC("LevelKey")
#define ExpKey OC("ExpKey")
#define EngKey OC("EngKey")
#define SinglePass OC("SinglePass")
#define PartyPass OC("PartyPass")

@interface DataSys : NSObject{
    
}


// Level 
+(int)GetLevel;
+(void)LevelAdd;

// Exp
+(int)GetExp;
+(void)ExpAdd:(int)exp;
+(void)ExpReset;

// Engineer
+(int)GetEng;
+(void)EngAdd:(int)eng;
+(void)EngReset;

// Score
+(int)GetScore;
+(void)ScoreMinus:(int)score;
+(void)ScoreAdd:(int)score;

// Pass
+(int)GetSinglePass;
+(void)AddSinglePass;
+(int)GetPartyPass;
+(void)AddPartyPass;

+(void)DataReset;

@end
