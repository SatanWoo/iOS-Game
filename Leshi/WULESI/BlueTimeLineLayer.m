//
//  BlueTimeLineLayer.m
//  WULESI
//
//  Created by M.K.Rain on 12-5-31.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "BlueTimeLineLayer.h"
#import "SceneManager.h"
#import "Macro.h"
#define timeLineOriginX 159
#define timeLineOriginY 55.5
#define timeLineDesX 865
#define timeLineDexY 23.5
#define totalLength 706

@implementation BlueTimeLineLayer
@synthesize length = _length;
@synthesize countDown = _countDown;

// Cai:Override
- (id)init
{
    self = [super init];
    if (self) {
        _countDown = gameTime;
        _length =  totalLength;
        _countDownTTF = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",_countDown] fontName:@"Marker Felt" fontSize:42];
        _countDownTTF.position = ccp(40+timeLineDesX + _countDownTTF.boundingBox.size.width / 2,timeLineOriginY-20);
        [_countDownTTF setColor:ccc3(255, 255, 255)];
        [self addChild:_countDownTTF];
        
    }
    return self;
}

- (void)scheduleUpdate
{
    _countDown --;
    _length =   _countDown * totalLength / gameTime;
    if (_countDown <= 0) {
        [self unschedule:@selector(scheduleUpdate)];
        [SceneManager goLoadingLesi];
    }else {
        [_countDownTTF setString:[NSString stringWithFormat:@"%d",_countDown]];
    }
    
}

- (void)startMove
{
    [self schedule:@selector(scheduleUpdate) interval:1.0f];
}

- (void)draw
{
    ccDrawSolidRect(CGPointMake(timeLineOriginX + 3,timeLineOriginY), CGPointMake(timeLineOriginX - 3 + _length, timeLineDexY), ccc4f(0, 0, 240, 1));
    _countDownTTF.position = ccp(20+timeLineDesX + _countDownTTF.boundingBox.size.width / 2,timeLineOriginY-13);
}

@end
