//
//  PickLayer.h
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-11.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class TimeLineLayer;

@interface PickLayer : CCLayer{
    CCSprite *_bgp;
    CCSprite *_trolleySprite;
    CCSprite *_timeLineBGP;
    CCSprite *_mask;
    CCLabelTTF *_scoreTTF;
    CGPoint _velocity;
    CCArray *_chipsArray;
    int _readyIndex;
    NSArray *_startArray;

    TimeLineLayer *_timeLayer;
    int _score;
    int _currentItemCount;
    //int _speedLevel; // Wu:After some intervales ,speed up the down velocity
}

@end
