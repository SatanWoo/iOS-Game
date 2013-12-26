//
//  MusicHandle.h
//  WULESI
//
//  Created by M.K.Rain on 12-6-4.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleAudioEngine.h"

@interface MusicHandle : NSObject{
    
}

+(void) preload;

+(ALuint) notifyCountDown;
+(ALuint) notifyGetScore;
+(ALuint) notifyLoseTime;
+(ALuint) notifyCongratulation;
+(ALuint) notifyClapping;

+(void) stopSound;

+(ALuint)playCountDown;
@end
