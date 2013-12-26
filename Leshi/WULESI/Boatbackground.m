//
//  Boatbackground.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "Boatbackground.h"
#import "Macro.h"
#define GAMETIME 30

@implementation Boatbackground


- (id)init
{
    self = [super init];
    if (self) {
        _bgp = [CCSprite spriteWithFile:@"ship_bg_crop.png"];
        _bgp.anchorPoint = ccp(0,0.5);
        _bgp.position = ccp(0, IPADHEIGHT / 2);
        _secondBGP = [CCSprite spriteWithFile:@"ship_bg_crop.png"];
        _secondBGP.flipX = YES;
        _secondBGP.anchorPoint = ccp(0, 0.5);
        _secondBGP.position = ccp(IPADWIDTH - 1,IPADHEIGHT / 2);
        _bgpArray = [[CCArray alloc]init];
        [_bgpArray addObject:_bgp],[_bgpArray addObject:_secondBGP];
        [self addChild:_bgp];
        [self addChild:_secondBGP];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goMove) name:STARTMOVE object:nil];
        //[self goMove];
    }
    return self;
}

- (void)goMove{
    [self schedule:@selector(moveForward) interval:0];
}

- (void)moveForward
{
    CCSprite *sprite;
    for (int i = 0; i < [_bgpArray count]; i++) {
        sprite = [_bgpArray objectAtIndex:i];
        CGPoint pos = sprite.position;
        pos.x -= IPADWIDTH / (GAMETIME * 3) ;
        if (pos.x < - IPADWIDTH) {
            pos.x += IPADWIDTH * 2 - 2;
        }
        sprite.position = pos;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self unscheduleAllSelectors];
    [_bgpArray release], _bgpArray = nil;
    _bgp = nil;
    [super dealloc];
}

@end
