//
//  Chips.h
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-12.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
    // Wu:Score5
    fiveGreenBOGUCUI = 0,
    fiveYellowBOGUCUI = 1,
    fiveGreenLEKAICUI = 2,
    fiveRedLEKAICUI = 3,
    fiveBlueQIDUO = 4,
    fiveRedQIDUO = 5,
    
    // Wu:Score10
    tenPinkLESI = 6,
    tenBlueLESI = 7,
    tenYellowLESI = 8,
    tenRedLESI = 9,
    
    // Wu:Score15
    seasedgeYOUMICUI = 10,
    natureYOUMOCUI = 11,
    orginLESI = 12,
    barbecueLESI = 13,
    spicySeaFoodLES = 14,
    
    // Wu:-5
    timeMinus5 = 15,
    
    // Wu:Score-5
    scoreMinus5 = 16,
    
    // Wu:Level 2
    doubleScore = 17,
    smallCoke = 18,
    bigCoke = 19,
    canCoke = 20,
    smallqixi = 21,
    bigqixi = 22,
    canqixi = 23,
    bigchunguole = 24,
    bigmeinianda = 25,
    xianguoli = 26,
    smallguobingfen = 27,
    smalljilang = 28,
    smalljiadele = 29,
    smalllidun = 30,
    smallmeinianda = 31,
    smallxianguoli = 32,
    canjilang = 33,
    canmeinianda = 34,
    icebergone = 35,
    icebergtwo = 36,
    icebergthree = 37
}chipType;

@interface Chips : CCSprite {
    int _value;
    int _time;
    int _line;
    chipType _type;
}

@property (nonatomic ,readonly) int value;
@property (nonatomic ,readonly) int time;
@property (nonatomic ,assign) int line;

+ (id)createNewChips:(chipType)type;
- (id)initWithType:(chipType)type;
@end
