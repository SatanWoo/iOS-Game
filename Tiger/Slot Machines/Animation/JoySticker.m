//
//  JoySticker.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "JoySticker.h"
#import "MusicCenter.h"
#import "GameConfig.h"
#import "SysConf.h"
#import <AudioToolbox/AudioToolbox.h>

#define JoySticker_X 405
#define JoySticker_Y 200
#define JOY_LEFT 375
#define JOY_RIGHT 438
#define JOY_TOP 292
#define JOY_BOTTOM 230


@implementation JoySticker


-(id)init
{
    self = [super init];
    if (self) {
        [self InitJoySticker];
    }
    return self;
}

-(void)InitJoySticker
{
    [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:OC("lagan_all.plist")];
    _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:OC("lagan_all.png")];
    [self addChild:_spriteSheet z:0];
    _image = [CCSprite spriteWithSpriteFrameName:OC("tc_ani_lagan_001.png")];
    _image.position = ccp(JoySticker_X,JoySticker_Y);
    [_spriteSheet addChild:_image];     
}

-(BOOL)ccTouchBegan :(UITouch *)touch withEvent:(UIEvent *)event
{
    isOn = false;
    touchBegin = [touch locationInView:[touch view]];
	touchBegin = [[CCDirector sharedDirector] convertToGL:touchBegin];
    isOn = (JOY_LEFT <= touchBegin.x && touchBegin.x <= JOY_RIGHT && JOY_BOTTOM <= touchBegin.y && touchBegin.y <= JOY_TOP);
    if(!isOn){
        if(95 <= touchBegin.y && touchBegin.y <= 255){
            int th = -1;
            if(100 <= touchBegin.x && touchBegin.x <= 180) th = 0;
            if(200 <= touchBegin.x && touchBegin.x <= 280) th = 1;
            if(300 <= touchBegin.x && touchBegin.x <= 380) th = 2;
            if(th != -1) [self.parent FruitStopScrollLine:th];
        }
    }else{
        [MusicCenter playSoundEffect:lagan];    
    }
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!isOn) return;
    touchMove = [touch locationInView:[touch view]];
	touchMove = [[CCDirector sharedDirector] convertToGL:touchMove];
    nowPage = (int)((touchBegin.y - touchMove.y) / 2);
    nowPage = MAX(nowPage, 1);
    nowPage = MIN(nowPage, 60);

    [_spriteSheet removeChild:_image cleanup:YES];
    _image = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:OC("tc_ani_lagan_%03d.png"), nowPage]];
    _image.position = ccp(JoySticker_X,JoySticker_Y);    
    [_spriteSheet addChild:_image];
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(!isOn) return;
    if(55 <= nowPage && nowPage <= 60){
        if([SysConf IsShockEffect]) {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        [self.parent FruitBeginScroll];
    }
    if(nowPage <= 1) return;
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = nowPage - 1; i >= 1; --i) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] 
                                   spriteFrameByName:[NSString stringWithFormat:OC("tc_ani_lagan_%03d.png"), i]]];
    }
    
    CCAnimation *walkAnim = [CCAnimation
                             animationWithFrames:walkAnimFrames delay:0.005f];  
    CCAction *action = [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO];    
    [_image runAction:action];    
}


- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}


-(void)dealloc
{
    [super dealloc];
}

@end