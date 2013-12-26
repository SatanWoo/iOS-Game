//
//  saveSetting.m
//  tapat
//
//  Created by 吴 wuziqi on 11-1-26.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "saveSetting.h"


@implementation saveSetting

+(void)saveChoiceBackground:(int)choice
{
	[[NSUserDefaults standardUserDefaults]setInteger:choice forKey:choiceBackgroundKey];
}

+(void)saveSoundPlay:(int)choice
{
	[[NSUserDefaults standardUserDefaults]setInteger:choice forKey:soundPlayKey];
}

+(void)saveMusicPlay:(int)choice
{
	[[NSUserDefaults standardUserDefaults]setInteger:choice forKey:musicPlayKey];
}

+(int)getSoundPlay{
	return [[NSUserDefaults standardUserDefaults]integerForKey:soundPlayKey];
}

+(int)getMusicPlay
{
	return [[NSUserDefaults standardUserDefaults]integerForKey:musicPlayKey];
}

+(int)getBackground
{
	return [[NSUserDefaults standardUserDefaults]integerForKey:choiceBackgroundKey];
}

-(void)dealloc
{
	[super dealloc];
}

@end
