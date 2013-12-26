//
//  MusicHandle.m
//  WULESI
//
//  Created by M.K.Rain on 12-6-4.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "MusicHandle.h"

SimpleAudioEngine *engine;

static NSString *countDownEffect = @"321开始.mp3";
static NSString *getScore = @"得分.mp3";
static NSString *loseTime = @"扣分扣时间.mp3";
static NSString *congratulationEffect = @"恭喜中奖音效.mp3";
static NSString *clapping = @"鼓掌.mp3";

@implementation MusicHandle

+ (void) preload{
	engine = [SimpleAudioEngine sharedEngine];
	if (engine) {
        [engine preloadEffect:countDownEffect];
        [engine preloadEffect:getScore];
        [engine preloadEffect:loseTime];
        [engine preloadEffect:congratulationEffect];
        [engine preloadEffect:clapping];
	}
}

+ (ALuint)playCountDown {
    return  [engine playEffect:countDownEffect];
}

+ (ALuint)notifyCountDown
{
    return  [engine playEffect:countDownEffect];
}

+ (ALuint)notifyGetScore
{
    return  [engine playEffect:getScore];
}

+ (ALuint)notifyLoseTime
{
    return  [engine playEffect:loseTime];
}

+ (ALuint)notifyCongratulation
{
    return  [engine playEffect:congratulationEffect];
}

+ (ALuint)notifyClapping
{
    return  [engine playEffect:clapping];
}


+ (void)stopSound
{
	if ([engine isBackgroundMusicPlaying]) {
		[engine stopBackgroundMusic];
	}
}

- (void)dealloc
{
	[super dealloc];
}

@end
