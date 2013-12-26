//
//  MusicCenter.h
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-1-16.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "GameConfig.h"

typedef enum {
//    coin effect
    moneyRateOne,
    moneyRateTwo,
    moneyRateThree,
    moneyRateFour,
    moneyRateFive,
    moneyRateSix,
    moneyRateSeven,
    moneyRateEight,
//    tiger effect
    silly,
    cry,
    happy,
    embarrassment,
    dizzy,
    angry,
    normalStay,
//    button effect
    leftButton,
    bottomButton,
    camera,
    insertCoin,    
    error,
//    animation effect
    slotOne,
    slotTwo,
    slotThree,
    lagan,
    levelUp,
    powerFull,
    powerSlot,
    treasure,
    trearun,
    treastop
}soundEffectType;

typedef enum 
{
   menuMain,
   singleModeFirst,
   singleModeSecond,
   partyMode,
   loveMode,
   no,
}backgroundMusic;

@interface MusicCenter : NSObject{
}

+(ALuint)playSoundEffect:(soundEffectType)eff;
+(void)stopEffect:(ALuint)soundId;


+(void)preLoad;
+(void)playModeBackgroundMusic:(backgroundMusic)music;
+(void)playBackgroundMusic;
+(void)stopBackgroundMusic;

@end
