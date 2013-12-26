	//
	//  saveData.m
	//  tapat
	//
	//  Created by 吴 wuziqi on 11-1-26.
	//  Copyright 2011 同济大学. All rights reserved.
	//

#import "saveData.h"


@implementation saveData

+(void)saveChallengeScore:(int)temp
{
	[[NSUserDefaults standardUserDefaults]setInteger:temp forKey:saveChallengeKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getChallengeScore
{
	return [[NSUserDefaults standardUserDefaults] integerForKey: saveChallengeKey];		
}

+(void)saveLevel:(int)temp
{
	[[NSUserDefaults standardUserDefaults]setInteger:temp forKey:saveLevelKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getLevel
{
	return [[NSUserDefaults standardUserDefaults] integerForKey:saveLevelKey];
}

+(void)saveAdvenScore:(int)temp level:(int)level
{
	NSArray *arrayTemp = [saveData getArray];
	
	if(temp==0) {
		NSMutableArray *newScoreArray = [NSMutableArray arrayWithArray: arrayTemp];
		[newScoreArray replaceObjectAtIndex:level withObject:[NSNumber numberWithInt:0]];
	 
		
			
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newScoreArray];
		[[NSUserDefaults standardUserDefaults] setValue:data forKey:saveAdvenKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
		return ;//表示reset
	 }
	
	
	
	if (level<0||level>=8) {
		return ;
	}
	
	NSNumber* tempNumber =[NSNumber numberWithInt:temp];
	NSNumber* oldScore =[arrayTemp objectAtIndex:level];
	
	if (temp>[oldScore intValue]) {
		NSMutableArray *newScoreArray = [NSMutableArray arrayWithArray: arrayTemp];
		[newScoreArray replaceObjectAtIndex:level withObject:tempNumber];
		NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newScoreArray];
		[[NSUserDefaults standardUserDefaults] setValue:data forKey:saveAdvenKey];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	else {
		return ;
	}
	
	
	
	
}

+(int)getAdvenScore:(int)level
{
	NSData* data=[[NSUserDefaults standardUserDefaults]objectForKey:saveAdvenKey];
	NSArray* arrayTemp=[NSKeyedUnarchiver unarchiveObjectWithData:data];
	NSNumber* temp=[arrayTemp objectAtIndex:level];
	return [temp intValue];
}

+(NSArray*)getArray
{
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:saveAdvenKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData: data];
}


-(void)dealloc
{
	[super dealloc];
}

@end
