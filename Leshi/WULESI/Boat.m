//
//  Boat.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "Boat.h"
#import "NpcShip.h"
#import "Player.h"
#import "Macro.h"
#define OFFSET 400
#define CONSTRAIN 8

@implementation Boat

- (void)cache{
    _logo = [CCSprite spriteWithFile:@"logo_太阳_秒.png"];
    _logo.position = ccp(IPADWIDTH / 2, IPADHEIGHT - _logo.boundingBox.size.height / 2);
    [self addChild:_logo];

}

- (id)init
{
    self = [super init];
    if (self) {
        [self cache];
        
        CCSprite *timeLineBGP = [CCSprite spriteWithFile:@"game_lottery_res.png" rect:CGRectMake(1,178, 706, 39)];
        timeLineBGP.position = ccp(IPADWIDTH / 2, timeLineBGP.boundingBox.size.height);
        [self addChild:timeLineBGP z:0];

        _constraint = 0;
        //globalGameScore = 0;
        self.isAccelerometerEnabled = YES;// Wu:Important
        
        _player = [Player getPlayer];
        _player.position = ccp(IPADWIDTH / 2 - OFFSET, STARTHEIGHT - 0.65 * IPADHEIGHT / 3 -30);
        [self addChild:_player];
        //[self goMove];
    }
    return self;
}

// Wu:Accelerometer do not change the height .
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    _constraint ++;
    // Wu:Remember ,here is x to acclerate
    NSLog(@"x is %f",acceleration.x);
    if (acceleration.x < -0.1 && _player.line < 2  && _constraint > CONSTRAIN) {
        _constraint = 0;
        _player.line ++;
    } else if (acceleration.x >= -0.1 && _player.line > 0 && _constraint > CONSTRAIN)
    {
        _constraint = 0;
        _player.line --;
    }
}

- (void)goMove{
    [_player actionStart];
}

- (void)dealloc
{
    _player = nil;
    [super dealloc];
}


@end
