//
//  SettingLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingLayer.h"
#import "SysConf.h"
#import "MusicCenter.h"
#import "GameConfig.h"
#define BUTTON_START_X 270
#define BUTTON_START_Y 260
#define BUTTON_INTERVAL_X 10
#define BUTTON_INTERVAL_Y 60
#define BUTTON_LEFT 270
#define BUTTON_RIGHT 325
#define BUTTON_BOARD 30
#define BUTTON_ON_LEFT 212
#define BUTTON_ON_RIGHT 249
#define BUTTON_OFF_LEFT 343
#define BUTTON_OFF_RIGHT 382

@implementation SettingLayer

-(id)init
{
    self = [super init];
    if(self)
    {
        [self InitLayer];
    }
    return self;
}

-(void)InitLayer
{
    CCSprite * background = [CCSprite spriteWithFile:OC("tc_gi_single_pr_setting.png")];
    background.position = ccp(SCREEN_X, SCREEN_Y);
    [self addChild:background];

    CCMenuItemSprite * close = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_guanbianniu.png")] selectedSprite:nil disabledSprite:nil target:self selector:@selector(RemoveLayer)];
    CCMenu * closeMenu = [CCMenu menuWithItems:close, nil];
    closeMenu.position = ccp(409, 46);
    [self addChild:closeMenu z:2];

    bkMusic = [CCSprite spriteWithFile:OC("tc_gi_single_pr_button_huatiao2.png")];
    soundEffect = [CCSprite spriteWithFile:OC("tc_gi_single_pr_button_huatiao2.png")];
    shockEffect = [CCSprite spriteWithFile:OC("tc_gi_single_pr_button_huatiao2.png")];
    dataRefresh = [CCSprite spriteWithFile:OC("tc_gi_single_pr_button_huatiao2.png")];
    if([SysConf IsBkMusic])
        bkMusic.position = ccp(BUTTON_LEFT, BUTTON_START_Y - 0 * BUTTON_INTERVAL_Y);
    else
        bkMusic.position = ccp(BUTTON_RIGHT, BUTTON_START_Y - 0 * BUTTON_INTERVAL_Y);
    
    if([SysConf IsSoundEffect])
        soundEffect.position = ccp(BUTTON_LEFT, BUTTON_START_Y - 1 * BUTTON_INTERVAL_Y);
    else
        soundEffect.position = ccp(BUTTON_RIGHT, BUTTON_START_Y - 1 * BUTTON_INTERVAL_Y);
    
    if([SysConf IsShockEffect])
        shockEffect.position = ccp(BUTTON_LEFT, BUTTON_START_Y - 2 * BUTTON_INTERVAL_Y);
    else
        shockEffect.position = ccp(BUTTON_RIGHT, BUTTON_START_Y - 2 * BUTTON_INTERVAL_Y);
    
    if([SysConf IsDataRefresh])
        dataRefresh.position = ccp(BUTTON_LEFT, BUTTON_START_Y - 3 * BUTTON_INTERVAL_Y);
    else
        dataRefresh.position = ccp(BUTTON_RIGHT, BUTTON_START_Y - 3 * BUTTON_INTERVAL_Y);
        
    [self addChild: bkMusic z:2];
    [self addChild:soundEffect z:2];
    [self addChild:shockEffect z:2];
    [self addChild:dataRefresh z:2];
}

-(void)RemoveLayer
{
    [self removeFromParentAndCleanup:YES];
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

-(BOOL)ccTouchBegan :(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    pointer = nil;
    if(fabs(bkMusic.position.x - touchPoint.x) <= BUTTON_BOARD && fabs(bkMusic.position.y - touchPoint.y) <= BUTTON_BOARD){
        pointer = bkMusic;
    }
    if(fabs(soundEffect.position.x - touchPoint.x) <= BUTTON_BOARD && fabs(soundEffect.position.y - touchPoint.y) <= BUTTON_BOARD){
        pointer = soundEffect;   
    }
    if(fabs(shockEffect.position.x - touchPoint.x) <= BUTTON_BOARD && fabs(shockEffect.position.y - touchPoint.y) <= BUTTON_BOARD){
        pointer = shockEffect;
    }
    if(fabs(dataRefresh.position.x - touchPoint.x) <= BUTTON_BOARD && fabs(dataRefresh.position.y - touchPoint.y) <= BUTTON_BOARD){
        pointer = dataRefresh;   
    }
    if(pointer != nil){
        isSlide = true;
        begin = (int)touchPoint.x;
        ori_x = pointer.position.x;
        ori_y = pointer.position.y;
    }else{
        isSlide = false;
        if(fabs(bkMusic.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = bkMusic;
        }
        if(fabs(soundEffect.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = soundEffect;   
        }
        if(fabs(shockEffect.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = shockEffect;
        }
        if(fabs(dataRefresh.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = dataRefresh;   
        }      
        if(pointer != nil){
            if(BUTTON_ON_LEFT <= touchPoint.x && touchPoint.x <= BUTTON_ON_RIGHT){
                [pointer runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(BUTTON_LEFT, pointer.position.y)]];
                if(pointer == bkMusic){
                    [SysConf SetBkMusic:true];
                    [MusicCenter playBackgroundMusic];
                }
                if(pointer == soundEffect) [SysConf SetSoundEffect:true];
                if(pointer == shockEffect) [SysConf SetShockEffect:true];
                if(pointer == dataRefresh) [SysConf SetDataRefresh:true];
            }
            if(BUTTON_OFF_LEFT <= touchPoint.x && touchPoint.x <= BUTTON_OFF_RIGHT){
                [pointer runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(BUTTON_RIGHT, pointer.position.y)]];
                if(pointer == bkMusic){
                    [SysConf SetBkMusic:false];
                    [MusicCenter stopBackgroundMusic];
                }
                if(pointer == soundEffect) [SysConf SetSoundEffect:false];
                if(pointer == shockEffect) [SysConf SetShockEffect:false];
                if(pointer == dataRefresh) [SysConf SetDataRefresh:false];
            }
        }
    }    
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    if (!isSlide){        
        if(fabs(bkMusic.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = bkMusic;
        }
        if(fabs(soundEffect.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = soundEffect;   
        }
        if(fabs(shockEffect.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = shockEffect;
        }
        if(fabs(dataRefresh.position.y - touchPoint.y) <= BUTTON_BOARD){
            pointer = dataRefresh;   
        }      
        if(pointer != nil && [pointer numberOfRunningActions] <= 0){
            if(BUTTON_ON_LEFT <= touchPoint.x && touchPoint.x <= BUTTON_ON_RIGHT){
                [pointer runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(BUTTON_LEFT, pointer.position.y)]];
                if(pointer == bkMusic){
                    [SysConf SetBkMusic:true];
                    [MusicCenter playBackgroundMusic];
                }
                if(pointer == soundEffect) [SysConf SetSoundEffect:true];
                if(pointer == shockEffect) [SysConf SetShockEffect:true];
                if(pointer == dataRefresh) [SysConf SetDataRefresh:true];
                
            }
            if(BUTTON_OFF_LEFT <= touchPoint.x && touchPoint.x <= BUTTON_OFF_RIGHT){
                [pointer runAction:[CCMoveTo actionWithDuration:0.3f position:ccp(BUTTON_RIGHT, pointer.position.y)]];
                if(pointer == bkMusic){
                    [SysConf SetBkMusic:false];
                    [MusicCenter stopBackgroundMusic];
                }
                if(pointer == soundEffect) [SysConf SetSoundEffect:false];
                if(pointer == shockEffect) [SysConf SetShockEffect:false];
                if(pointer == dataRefresh) [SysConf SetDataRefresh:false];
            }
        }
     return;   
    }
    move = (int)touchPoint.x;
    offset = move - begin;
    if(BUTTON_LEFT <= ori_x + offset && ori_x +offset <= BUTTON_RIGHT){
        pointer.position = ccp(ori_x + offset, ori_y);  
    }    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    if (!isSlide) return;
    end = (int)touchPoint.x;
    offset = end - begin;
    if(fabs(ori_x + offset - BUTTON_LEFT) < fabs(ori_x + offset - BUTTON_RIGHT)){
        pointer.position = ccp(BUTTON_LEFT, ori_y);
        if(pointer == bkMusic){
            [SysConf SetBkMusic:true];
            [MusicCenter playBackgroundMusic];
        }
        if(pointer == soundEffect) [SysConf SetSoundEffect:true];
        if(pointer == shockEffect) [SysConf SetShockEffect:true];
        if(pointer == dataRefresh) [SysConf SetDataRefresh:true];
    }else{
        pointer.position = ccp(BUTTON_RIGHT, ori_y);
        if(pointer == bkMusic){
            [SysConf SetBkMusic:false];
            [MusicCenter stopBackgroundMusic];
        }
        if(pointer == soundEffect) [SysConf SetSoundEffect:false];
        if(pointer == shockEffect) [SysConf SetShockEffect:false];
        if(pointer == dataRefresh) [SysConf SetDataRefresh:false];        
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end
