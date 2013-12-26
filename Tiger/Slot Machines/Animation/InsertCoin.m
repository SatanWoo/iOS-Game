//
//  InsertCoin.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InsertCoin.h"
#import "GameConfig.h"
#import "MusicCenter.h"
#define INSERT_COIN_X 413 
#define INSERT_COIN_Y 113

@implementation InsertCoin

-(id)init
{
    self = [super init];
    if (self) {
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:OC("tc_ani_coin_in.plist")];
        _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:OC("tc_ani_coin_in.png")];
        [self addChild:_spriteSheet z:0];
        _image = [CCSprite spriteWithSpriteFrameName:OC("tc_ani_coin_in_001.png")];
        _image.position = ccp(INSERT_COIN_X,INSERT_COIN_Y);
        [_spriteSheet addChild:_image];        
    }
    return self;
}

- (void)ActionBegin
{
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 8; ++i) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] 
                                   spriteFrameByName:[NSString stringWithFormat:OC("tc_ani_coin_in_%03d.png"), i]]];
    }
    CCAnimation *walkAnim = [CCAnimation
                             animationWithFrames:walkAnimFrames delay:0.1f];  
    CCSequence *action = [CCSequence actions:
                          [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO],
                          [CCFadeOut actionWithDuration:0.0],nil];
    
    [_image runAction:action];
    [self performSelector:@selector(PlayEffect) withObject:nil afterDelay:0.5f];
}

-(void)PlayEffect
{
    [MusicCenter playSoundEffect:insertCoin];
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
