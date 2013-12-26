//
//  MusicHandle.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-13.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"


@interface MusicHandle : NSObject {

}

+(void) preload;

+(void) notifyMenuMusic;
+(void) notifyMiniMusic;
+(void) notifyTick;

+(void) stopEffect;
+(void) stopSound;

@end
