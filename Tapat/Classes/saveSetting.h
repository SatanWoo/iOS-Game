//
//  saveSetting.h
//  tapat
//
//  Created by 吴 wuziqi on 11-1-26.
//  Copyright 2011 同济大学. All rights reserved.
//

#define choiceBackgroundKey @"choiceBackgroundKey"
#define soundPlayKey @"soundPlayKey"
#define musicPlayKey @"musicPlayKey"
@interface saveSetting : NSObject {
	
}

+(void)saveChoiceBackground:(int)choice;

+(void)saveSoundPlay:(int)choice;

+(void)saveMusicPlay:(int)choice;


+(int)getSoundPlay;

+(int)getMusicPlay;

+(int)getBackground;


@end
