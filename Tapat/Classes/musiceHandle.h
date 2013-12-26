	//
	//  musiceHandle.h
	//  tapat
	//
	//  Created by 吴 wuziqi on 11-1-27.
	//  Copyright 2011 同济大学. All rights reserved.
	//
#import "SimpleAudioEngine.h"


@interface musiceHandle : NSObject {
	
}


+(void) preload;

+(void) notifyMusic;

+(void) notifySoundOfMice;
+(void) notifySoundOfSnake;

+(void) stopSound;



@end
