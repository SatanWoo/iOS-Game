//
//  NpcShip.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "NpcShip.h"
#import "Macro.h"

@implementation NpcShip
@synthesize line = _line;
@synthesize minusTime = _minusTime;

+ (id)createNpcWithType:(int)type
{
    return [[[self alloc] initwithType:type] autorelease];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initwithType:(int)type
{
    self = [super init];
    if (self) {
        _minusTime = 5;
        _type = type;
        if (type == 0) {
            _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"npc1.png"];
            _image = [CCSprite spriteWithSpriteFrameName:@"npc_a_1.png"];
        } else if (type == 1) {
            _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"npc2.png"];
            _image = [CCSprite spriteWithSpriteFrameName:@"npc_b_1.png"];
        } else {
            _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"npc3.png"];
            _image = [CCSprite spriteWithSpriteFrameName:@"npc_c_1.png"];
        }
        [_spriteSheet addChild:_image];
        [self addChild:_spriteSheet];
    }
    return self;
}

- (void)actionStart
{
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    if (_type == 0) {
        for(int i =1; i <=12; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"npc_a_%d.png", i]]];
        }
    } else if (_type == 1) {
        for(int i =1; i <=12; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"npc_b_%d.png", i]]];
        }
    } else {
        for(int i =1; i <=12; ++i) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"npc_c_%d.png", i]]];
        }
    }
    CCAnimation *walkAnim = [CCAnimation 
                             animationWithSpriteFrames:walkAnimFrames delay:0.1f];
    CCAction *walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [_image runAction:walkAction];
}

- (void)move
{
    self.position = ccp(IPADWIDTH * (_line + 1) + IPADWIDTH / 2, STARTHEIGHT  - _line * 0.65 * IPADHEIGHT / 3 - 30);
}

- (void)setLine:(int)line
{
    _line = line;
    [self move];
}

- (void)dealloc
{
    _image = nil;
    _spriteSheet = nil;
    [super dealloc];
}

@end

