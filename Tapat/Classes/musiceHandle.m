	//
	//  musiceHandle.m
	//  tapat
	//
	//  Created by 吴 wuziqi on 11-1-27.
	//  Copyright 2011 同济大学. All rights reserved.
	//

#import "musiceHandle.h"
#import "saveSetting.h"

SimpleAudioEngine *engine;
static NSString *musicEffect = @"wronglove.mp3";
static NSString *soundEffect = @"Battlefield.mp3";
static NSString *snakeEffect = @"snake.mp3";

@interface musiceHandle()
+(void)playEffect:(NSString*)path;

@end


@implementation musiceHandle

+(void) preload{
	engine = [SimpleAudioEngine sharedEngine];
	if (engine) {
		[engine preloadEffect:soundEffect];
        [engine preloadEffect:snakeEffect];
		[engine preloadBackgroundMusic:musicEffect];
	}
}

+(void) notifyMusic{
	if ([engine isBackgroundMusicPlaying]) {
		return ;
	}
	
	[engine playBackgroundMusic:musicEffect];
}

+(void) notifySoundOfMice{
	if ([saveSetting getSoundPlay]==1) {
		return ;
	}
	[musiceHandle playEffect:soundEffect];	

}

+(void) notifySoundOfSnake
{
    if ([saveSetting getSoundPlay]==1)
    {
        return;
    }
    [musiceHandle playEffect:snakeEffect];
}

+(void)stopSound
{
	if ([engine isBackgroundMusicPlaying]) {
		[engine stopBackgroundMusic];
	}
}

+(void)playEffect:(NSString *)path
{
	[[SimpleAudioEngine sharedEngine] playEffect:path];
	
}

-(void)dealloc
{
	[engine release];
	[super dealloc];
}

@end
