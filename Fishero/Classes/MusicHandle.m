//
//  MusicHandle.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-13.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "MusicHandle.h"
#import "SaveSetting.h"


SimpleAudioEngine *engine;

static NSString *menuMusic = @"backMusic.mp3";
static NSString *miniMusic = @"miniGame.mp3";
static NSString *tickEffect =@"tick.mp3";

@implementation MusicHandle

+(void) preload{
	engine = [SimpleAudioEngine sharedEngine];
	if (engine) {
		[engine preloadBackgroundMusic:menuMusic];
        [engine preloadBackgroundMusic:miniMusic];
		[engine preloadEffect:tickEffect];
			//[engine preloadBackgroundMusic:musicEffect];
	}
}

+(void) notifyMenuMusic{
	if ([engine isBackgroundMusicPlaying]||[SaveSetting getMusic]==1) {
		return ;
	}
	
	[engine playBackgroundMusic:menuMusic];
}

+(void) notifyMiniMusic
{
	if ([engine isBackgroundMusicPlaying]||[SaveSetting getMusic]==1) {
		return ;
	}
	[engine playBackgroundMusic:miniMusic];
}

+(void)notifyTick
{
	if ([SaveSetting getSound]==1) {
		return;
	}
	[engine setEffectsVolume:100.0f];
	[engine playEffect:tickEffect];
}

+(void)stopSound
{
	if ([engine isBackgroundMusicPlaying]) {
		[engine stopBackgroundMusic];
	}
}

+(void)stopEffect
{
	[engine setEffectsVolume:0.0];
}

-(void)dealloc
{
	[super dealloc];
}



@end
