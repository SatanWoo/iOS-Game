//
//  Player.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "Player.h"
#import "Macro.h"

static Player *instance = nil;
@implementation Player

+ (id)getPlayer
{
    if (instance == nil) {
        instance = [[self alloc]init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _line = 1;
        _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"player.png"];
        _image = [CCSprite spriteWithSpriteFrameName:@"player_0.png"];
        [_spriteSheet addChild:_image];
        [self addChild:_spriteSheet];
    }
    return  self;
}

- (void)actionStart
{
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i =1; i <=11; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"player_%d.png", i]]];
    }
    CCAnimation *walkAnim = [CCAnimation 
                             animationWithSpriteFrames:walkAnimFrames delay:0.1f];
    CCAction *walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [_image runAction:walkAction];
}

- (void)move
{
    CCMoveTo *moveTo = [CCMoveTo actionWithDuration:0.3f 
                                           position:ccp(IPADWIDTH / 2 - 400, STARTHEIGHT  - _line * 0.65 * IPADHEIGHT / 3 -30)];
    [self runAction:moveTo];
}

- (void)dealloc
{
    [super dealloc];
}

@end
