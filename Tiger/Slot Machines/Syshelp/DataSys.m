//
//  DataSys.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DataSys.h"

@implementation DataSys

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


+(int)GetLevel
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:LevelKey];
}

+(void)LevelAdd
{
	int lastLevel = [[NSUserDefaults standardUserDefaults] integerForKey:LevelKey];
	lastLevel += 1;
    lastLevel = lastLevel <= 999 ? lastLevel : 999;
	[[NSUserDefaults standardUserDefaults] setInteger:lastLevel forKey:LevelKey];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}

//Exp
+(int)GetExp
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:ExpKey];
}

+(void)ExpAdd:(int)exp
{
	int lastExp = [[NSUserDefaults standardUserDefaults] integerForKey:ExpKey];
	lastExp += exp;
    lastExp = lastExp <= 100 ? lastExp : 100;
	[[NSUserDefaults standardUserDefaults] setInteger:lastExp forKey:ExpKey];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}

+(void)ExpReset
{
	[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:ExpKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

//Eng
+(int)GetEng
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:EngKey];
}

+(void)EngAdd:(int)eng
{
    int lastEng = [[NSUserDefaults standardUserDefaults] integerForKey:EngKey];
	lastEng += eng;
    lastEng = lastEng <= 100? lastEng : 100;
	[[NSUserDefaults standardUserDefaults] setInteger:lastEng forKey:EngKey];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}

+(void)EngReset
{
	[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:EngKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

// Score
+(int)GetScore
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:ScoreKey];
}

+(void)ScoreAdd:(int)score
{
	int lastScore = [[NSUserDefaults standardUserDefaults] integerForKey:ScoreKey];
	lastScore += score;
	[[NSUserDefaults standardUserDefaults] setInteger:lastScore forKey:ScoreKey];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}

+(void)ScoreMinus:(int)score
{
	int lastScore = [[NSUserDefaults standardUserDefaults] integerForKey:ScoreKey];
	lastScore -= score;
	[[NSUserDefaults standardUserDefaults] setInteger:lastScore forKey:ScoreKey];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}

+(int)GetSinglePass
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:SinglePass];
}

+(void)AddSinglePass
{
	int lastPass = [[NSUserDefaults standardUserDefaults] integerForKey:SinglePass];
    lastPass++;
	[[NSUserDefaults standardUserDefaults] setInteger:lastPass forKey:SinglePass];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}

+(int)GetPartyPass
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:PartyPass];
}
+(void)AddPartyPass
{
	int lastPass = [[NSUserDefaults standardUserDefaults] integerForKey:PartyPass];
    lastPass++;
	[[NSUserDefaults standardUserDefaults] setInteger:lastPass forKey:PartyPass];
	[[NSUserDefaults standardUserDefaults] synchronize];//update immediately
}


+(void)DataReset
{
	[[NSUserDefaults standardUserDefaults]setInteger:1 forKey:LevelKey];
	[[NSUserDefaults standardUserDefaults]setInteger:100 forKey:ScoreKey];
	[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:ExpKey];    
	[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:EngKey]; 
	[[NSUserDefaults standardUserDefaults]setInteger:1 forKey:SinglePass];
	[[NSUserDefaults standardUserDefaults]setInteger:0 forKey:PartyPass];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)dealloc
{
	[super dealloc];
}

@end
