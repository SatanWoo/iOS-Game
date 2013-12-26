//
//  saveData.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-11.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "saveData.h"


@implementation saveData


+(void)setLevel:(int)Level
{
	[[NSUserDefaults standardUserDefaults]setInteger:Level forKey:levelKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getLevel
{
	return [[NSUserDefaults standardUserDefaults] integerForKey: levelKey];		
}

+(void)setMini:(int)status Level:(int)Level
{
	NSArray *arrayTemp = [saveData getArray];
	if (Level<1||Level>3) {
		return ;
	}
	
	NSNumber* tempNumber =[NSNumber numberWithInt:status];
	NSMutableArray *newScoreArray = [NSMutableArray arrayWithArray: arrayTemp];
	[newScoreArray replaceObjectAtIndex:Level-1 withObject:tempNumber];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newScoreArray];
	[[NSUserDefaults standardUserDefaults] setValue:data forKey:miniKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSArray*)getArray
{
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:miniKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData: data];
}

+(int)getMini:(int)Level
{
	NSData* data=[[NSUserDefaults standardUserDefaults]objectForKey:miniKey];
	NSArray* arrayTemp=[NSKeyedUnarchiver unarchiveObjectWithData:data];
	NSNumber* temp=[arrayTemp objectAtIndex:Level-1];
	return [temp intValue];
}

+(void)setPower:(int)power
{
	[[NSUserDefaults standardUserDefaults]setInteger:power forKey:powerKey];
	[[NSUserDefaults standardUserDefaults] synchronize];	
}

+(int)getPower
{
	return [[NSUserDefaults standardUserDefaults] integerForKey: powerKey];			
}

+(void)setSize:(float)size
{
	[[NSUserDefaults standardUserDefaults]setFloat:size forKey:sizeKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(float)getSize
{
	return [[NSUserDefaults standardUserDefaults] floatForKey: sizeKey];	
}


+(void)setShelter:(int)shelter
{
	[[NSUserDefaults standardUserDefaults] setInteger:shelter forKey:shelterKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getShelter
{
	return [[NSUserDefaults standardUserDefaults] integerForKey: shelterKey];
}

+(void)setCost:(int)cost sort:(int)sort
{
	NSArray *arrayTemp = [saveData getArrayOfCost];
	if (sort<1||sort>3) {
		return ;
	}
	NSNumber* tempNumber =[NSNumber numberWithInt:cost];
	NSMutableArray *newScoreArray = [NSMutableArray arrayWithArray: arrayTemp];
	[newScoreArray replaceObjectAtIndex:sort-1 withObject:tempNumber];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newScoreArray];
	[[NSUserDefaults standardUserDefaults] setValue:data forKey:costKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getCost:(int)sort
{
	NSData* data=[[NSUserDefaults standardUserDefaults]objectForKey:costKey];
	NSArray* arrayTemp=[NSKeyedUnarchiver unarchiveObjectWithData:data];
	NSNumber* temp=[arrayTemp objectAtIndex:sort-1];
	return [temp intValue];	
}

+(NSArray*)getArrayOfCost
{
	NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:costKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData: data];
}

+(void)setScore:(int)score
{
	[[NSUserDefaults standardUserDefaults]setInteger:score forKey:scoreKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(int)getScore
{
	return [[NSUserDefaults standardUserDefaults] integerForKey: scoreKey];		
}
-(void)dealloc
{
	[super dealloc];
}


@end
