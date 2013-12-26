//
//  Arrow.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Arrow.h"
#import "GameConfig.h"
#define INSERT_COIN_X 440 
#define INSERT_COIN_Y 160

@implementation Arrow

-(id)init
{
    self = [super init];
    if (self) {
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:OC("tc_ani_jiantou.plist")];
        _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:OC("tc_ani_jiantou.png")];
        [self addChild:_spriteSheet z:0];
        _image = [CCSprite spriteWithSpriteFrameName:OC("tc_ani_jiantou_001.png")];
        _image.position = ccp(INSERT_COIN_X,INSERT_COIN_Y);
        [_spriteSheet addChild:_image];        
    }
    return self;
}

- (void)ActionBegin
{
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 24; ++i) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] 
                                   spriteFrameByName:[NSString stringWithFormat:OC("tc_ani_jiantou_%03d.png"), i]]];
    }
    CCAnimation *walkAnim = [CCAnimation
                             animationWithFrames:walkAnimFrames delay:0.05f];  
    CCSequence *action = [CCSequence actions:
                          [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO],
                          [CCDelayTime actionWithDuration:1.0],nil];
    [_image runAction:[CCRepeatForever actionWithAction:action]];
}

-(void)ActionStop
{
    [_image stopAllActions];
}

-(void)dealloc
{
    [super dealloc];
}
@end
