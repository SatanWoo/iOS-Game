//
//  saveData.h
//  tapat
//
//  Created by 吴 wuziqi on 11-1-26.
//  Copyright 2011 同济大学. All rights reserved.
//
#define saveChallengeKey @"chanllengeScore"
#define saveAdvenKey @"advenScore"
#define saveLevelKey @"levelKey"



@interface saveData : NSObject {
	
}

+(void)saveChallengeScore:(int)temp;
+(int)getChallengeScore;

+(void)saveAdvenScore:(int)temp level:(int)level;
+(int)getAdvenScore:(int)level;

+(void)saveLevel:(int)temp;
+(int)getLevel;

+(NSArray*)getArray;


@end
