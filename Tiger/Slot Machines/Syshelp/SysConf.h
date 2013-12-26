//
//  SysConf.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConfig.h"

#define BKMusicKey OC("BKMusicKey")
#define SoundEffectKey OC("SoundEffectKey")
#define ShockEffectKey OC("ShockEffectKey")
#define DataRefreshKey OC("DataRefreshKey")
#define HelpKey OC("HelpKey")

@interface SysConf : NSObject{
    
}

+(bool)IsBkMusic;
+(bool)IsSoundEffect;
+(bool)IsShockEffect;
+(bool)IsDataRefresh;
+(bool)IsHelp;

+(void)SetBkMusic:(bool)flag;
+(void)SetSoundEffect:(bool)flag;
+(void)SetShockEffect:(bool)flag;
+(void)SetDataRefresh:(bool)flag;
+(void)SetHelp:(bool)flag;

+(void)SysReset;

@end
