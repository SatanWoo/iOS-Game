//
//  SysConf.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SysConf.h"

@implementation SysConf

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc
{
	[super dealloc];
}


+(bool)IsBkMusic
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:BKMusicKey];
}

+(bool)IsSoundEffect
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:SoundEffectKey];
}

+(bool)IsShockEffect
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:ShockEffectKey];
}

+(bool)IsDataRefresh
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:DataRefreshKey];
}

+(bool)IsHelp
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:HelpKey];
}

+(void)SetBkMusic:(bool)flag
{
	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:BKMusicKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)SetSoundEffect:(bool)flag
{
	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:SoundEffectKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)SetShockEffect:(bool)flag
{
	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:ShockEffectKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)SetDataRefresh:(bool)flag
{
	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:DataRefreshKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)SetHelp:(bool)flag
{
	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:HelpKey];
	[[NSUserDefaults standardUserDefaults] synchronize];    
}

+(void)SysReset
{
    
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:BKMusicKey];
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:SoundEffectKey];
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:ShockEffectKey];
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:DataRefreshKey];
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:HelpKey];    
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
