//
//  Character.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "GameConfig.h"

#define CharacterPointX 240
#define CharacterPointY 295


@implementation Character

-(id)init
{
    self = [super init];
    if (self) {
        [self InitCharacter];
        [self InitAction];
    }
    return self;
}

-(void)InitCharacter
{
    [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:OC("tc_ani_juese_win1.plist")];
    _spriteSheet1 = [CCSpriteBatchNode batchNodeWithFile:OC("tc_ani_juese_win1.png")];
    _win = [CCSprite spriteWithSpriteFrameName:OC("tc_ani_juese_win1_001.png")];
    _win.position = ccp(CharacterPointX,CharacterPointY);
    [_spriteSheet1 addChild:_win];        
    _win.visible = false;
    [self addChild:_spriteSheet1];

    [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:OC("tc_ani_juese_standby1.plist")];
    _spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:OC("tc_ani_juese_standby1.png")];
    _standby = [CCSprite spriteWithSpriteFrameName:OC("tc_ani_juese_standby1_001.png")];
    _standby.position = ccp(CharacterPointX,CharacterPointY);
    [_spriteSheet2 addChild:_standby];            
    
    [self addChild:_spriteSheet2];
}

- (void)InitAction
{
    NSMutableArray *winFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 30; ++i) {
        [winFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] 
                              spriteFrameByName:[NSString stringWithFormat:OC("tc_ani_juese_win1_%03d.png"), i]]];
    }
    CCAnimation *winAnim = [CCAnimation
                             animationWithFrames:winFrames delay:0.1f];  
    CCAction *winAction = [CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:winAnim restoreOriginalFrame:NO]];
    [_win runAction:winAction];
    
    
    NSMutableArray *standbyFrames = [NSMutableArray array];
    
    for(int i = 1; i <= 60; ++i) {
        [standbyFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] 
                              spriteFrameByName:[NSString stringWithFormat:OC("tc_ani_juese_standby1_%03d.png"), i]]];
    }
    CCAnimation *standbyAnim = [CCAnimation
                            animationWithFrames:standbyFrames delay:0.1f];  
    CCAction *standbyAction = [CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:standbyAnim restoreOriginalFrame:NO]];
    [_standby runAction:standbyAction];
}

-(void)SetCharacter:(int)rate
{
    if(rate > 0){
        _win.visible = true;
        _standby.visible = false;
    }else
    {
        _win.visible = false;
        _standby.visible = true;
    }
}

-(void)dealloc
{
    [super dealloc];
}


@end
