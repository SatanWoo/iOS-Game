//
//  CoinFall.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoinFall.h"
#import "GameConfig.h"
#define FALL_COIN_X 240
#define FALL_COIN_Y 160

@implementation CoinFall

@synthesize image = _image;
@synthesize spriteSheet = _spriteSheet;
@synthesize action = _action;

-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)InitCoinWithPng:(NSString *)name start:(int)s end:(int)e{
    self.spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[name stringByAppendingString:OC(".png")]];
    [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:[name stringByAppendingString:OC(".plist")]];
    [self addChild:self.spriteSheet z:0];
    self.image = [CCSprite spriteWithSpriteFrameName:[name stringByAppendingString:[NSString stringWithFormat:OC("_%04d.png"), s]]];
    self.image.position = ccp(FALL_COIN_X, FALL_COIN_Y);
    [self.image runAction:[CCFadeOut actionWithDuration:0.0f]];
    [self.spriteSheet addChild:self.image];            
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = s; i <= e; ++i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [name stringByAppendingString: [NSString stringWithFormat:OC("_%04d.png"), i]]]];
    }
    CCAnimation *walkAnim = [CCAnimation
                             animationWithFrames:walkAnimFrames delay:1.0 / 60];  

    self.action = [CCSequence actions:
                          [CCDelayTime actionWithDuration:1.0 / 60 * s],
                          [CCFadeIn actionWithDuration:0.0f],
                          [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO],
                          [CCFadeOut actionWithDuration:0.0f],
                          nil];
}

-(void)ActionBegin
{
    [self.image runAction:self.action];
}

-(void)dealloc
{
    [_image release];
    [_spriteSheet release];
    [_action release];
    [super dealloc];
}
@end
