//
//  MusicCenter.m
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-1-16.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "MusicCenter.h"
#import "SysConf.h"

SimpleAudioEngine *engine;

@interface MusicCenter()
+(void)playEffect:(NSString*)path;
@end

@implementation MusicCenter

static int nowPlayingBackgroundMusic = no;

+(ALuint)playSoundEffect:(soundEffectType)eff
{
    if(![SysConf IsSoundEffect]) return -1;
    switch (eff) {
//       coin effect     
        case moneyRateOne:
            return [engine playEffect:OC("tc_sound_mpbuy01.m4a")];
        case moneyRateTwo:
            return [engine playEffect:OC("tc_sound_mpbuy02.m4a")];
        case moneyRateThree:
            return [engine playEffect:OC("tc_sound_mpbuy03.m4a")];
        case moneyRateFour:
            return [engine playEffect:OC("tc_sound_mpbuy04.m4a")];
        case moneyRateFive:
            return [engine playEffect:OC("tc_sound_mpbuy05.m4a")];
        case moneyRateSix:
            return [engine playEffect:OC("tc_sound_mpbuy06.m4a")];
        case moneyRateSeven:
            return [engine playEffect:OC("tc_sound_mpbuy07.m4a")];
        case moneyRateEight:
            return [engine playEffect:OC("tc_sound_mpbuy08.m4a")];

//         tiger effect   
        case silly:
            return [engine playEffect:OC("tc_sound_dai.m4a")];
        case cry:
            return [engine playEffect:OC("tc_sound_ku.m4a")];
        case happy:
            return [engine playEffect:OC("tc_sound_xi.m4a")];
        case embarrassment:
            return [engine playEffect:OC("tc_sound_jiong.m4a")];
        case angry:
            return [engine playEffect:OC("tc_sound_nu.m4a")];
        case dizzy:
            return [engine playEffect:OC("tc_sound_yun.m4a")];
        case normalStay:
            return [engine playEffect:OC("tc_sound_standby.m4a")];            

//           coin effect 
        case bottomButton:
            return [engine playEffect:OC("tc_sound_labaji_sananniu.m4a")];
        case leftButton:
            return [engine playEffect:OC("tc_sound_labaji_other.m4a")];
        case insertCoin:
            return [engine playEffect:OC("tc_sound_toubi.m4a")];
        case camera:
            return [engine playEffect:OC("tc_sound_camera.m4a")];
        case error:
            return [engine playEffect:OC("tc_sound_error.m4a")];
            

        case slotOne:
            return [engine playEffect:OC("tc_sound_btn1.m4a")];
        case slotTwo:
            return [engine playEffect:OC("tc_sound_btn2.m4a")];
        case slotThree:
            return [engine playEffect:OC("tc_sound_btn3.m4a")];
        case lagan:
            return [engine playEffect:OC("tc_sound_lagan.m4a")];
        case levelUp:
            return [engine playEffect:OC("tc_sound_levelup.m4a")];
        case powerFull:
            return [engine playEffect:OC("tc_sound_xuliman.m4a")];
        case powerSlot:
            return [engine playEffect:OC("tc_sound_bell.m4a")];
        case trearun:
            return [engine playEffect:OC("tc_sound_zhuanpan_xuanzhuan.m4a")];
        case treastop:
            return [engine playEffect:OC("tc_sound_zhuanpan_stop.m4a")];
        case treasure:
            return [engine playEffect:OC("tc_sound_baoxiang.m4a")];
            
        default:
            return -1;
    }
}


+(void)stopEffect:(ALuint)soundId
{
    [engine stopEffect:soundId];
}

+(void)preloadMusic:(backgroundMusic)music
{
    engine = [SimpleAudioEngine sharedEngine];
    
    switch (music) {
        case menuMain:
            [engine preloadBackgroundMusic:OC("tc_sound_main.m4a")];
            break;
        case singleModeFirst:
            [engine preloadBackgroundMusic:OC("tc_gi_mainmusic.m4a")];
            break;
            
        case singleModeSecond:
            [engine preloadBackgroundMusic:OC("tc_sound_ch.m4a")];
            break;
            
        case partyMode:
            [engine preloadBackgroundMusic:OC("tc_sound_food.m4a")];
            break;
            
        case loveMode:
            [engine preloadBackgroundMusic:OC("tc_sound_home.m4a")];
            break;
            
        default:
            break;
    }
}

+(void)preLoad
{
    [self preloadMusic:menuMain];
    [self preloadMusic:singleModeFirst];
    [self preloadMusic:singleModeSecond];
    [self preloadMusic:partyMode];
}

+(void)stopBackgroundMusic
{
    [engine stopBackgroundMusic];    
}

+(void)playBackgroundMusic
{
    if(![engine isBackgroundMusicPlaying])
        [self playModeBackgroundMusic:nowPlayingBackgroundMusic];
}

+(void)playModeBackgroundMusic:(backgroundMusic)music
{
    if ([engine isBackgroundMusicPlaying] && music == nowPlayingBackgroundMusic) return;
    if ([engine isBackgroundMusicPlaying]) [engine stopBackgroundMusic];
    nowPlayingBackgroundMusic = music;
    if (![SysConf IsBkMusic]) return;
    switch (music) {
        case menuMain:
            [engine playBackgroundMusic:OC("tc_sound_main.m4a") loop:YES];
            break;

        case singleModeFirst:
            [engine playBackgroundMusic:OC("tc_gi_mainmusic.m4a") loop:YES];
            break;
            
        case singleModeSecond:
            [engine playBackgroundMusic:OC("tc_sound_ch.m4a") loop:YES];
            break;
            
        case partyMode:
            [engine playBackgroundMusic:OC("tc_sound_food.m4a") loop:YES];
            break;
            
        case loveMode:
            [engine playBackgroundMusic:OC("tc_sound_home.m4a") loop:YES];
            break;
            
        default:
            break;
    }

}

#pragma mark - Function

+(void)playEffect:(NSString *)path
{
	[[SimpleAudioEngine sharedEngine] playEffect:path];
}

-(void)dealloc
{
	[super dealloc];
}

@end
