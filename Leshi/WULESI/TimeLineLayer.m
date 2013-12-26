//
//  TimeLineLayer.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-14.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "TimeLineLayer.h"
#import "SceneManager.h"
#import "Macro.h"
#define timeLineOriginX 159
#define timeLineOriginY 55.5
#define timeLineDesX 865
#define timeLineDexY 23.5
#define totalLength 706

@implementation TimeLineLayer
@synthesize length = _length;
@synthesize countDown = _countDown;
//@synthesize isStart;
- (id)init
{
    self = [super init];
    if (self) {
        _countDown = gameTime;
        _length =  totalLength;
        _countDownTTF = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",_countDown] fontName:@"Marker Felt" fontSize:42];
        _countDownTTF.position = ccp(40+timeLineDesX + _countDownTTF.boundingBox.size.width / 2,timeLineOriginY-20);
        [_countDownTTF setColor:ccORANGE];
        [self addChild:_countDownTTF];
        
    }
    return self;
}


- (void)dealloc
{
    _countDownTTF = nil;
    [self unscheduleAllSelectors];
    [super dealloc];
}

- (void)startMove
{
    [self schedule:@selector(scheduleUpdate) interval:1.0f];
}

- (void)scheduleUpdate
{
    _countDown --;
    _length =   _countDown * totalLength / gameTime;
    if (_countDown <= 0) {
        [self unschedule:@selector(scheduleUpdate)];
        [SceneManager goshowScore];
    }else {
        [_countDownTTF setString:[NSString stringWithFormat:@"%d",_countDown]];
        _countDownTTF.position = ccp(40+timeLineDesX + _countDownTTF.boundingBox.size.width / 2,timeLineOriginY - 20);
    }
}

// Wu:Override
- (void)draw
{
    ccDrawSolidRect(CGPointMake(timeLineOriginX + 3,timeLineOriginY), CGPointMake(timeLineOriginX - 3 + _length, timeLineDexY), ccc4f(232, 162, 0, 1));
}

@end
