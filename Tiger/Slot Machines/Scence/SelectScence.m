//
//  SelectScence.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
#import "SelectScence.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "MusicCenter.h"
#import "DataSys.h"

#define BUTTON_BACK_X 30
#define BUTTON_BACK_Y 30
#define MENU_X 240
#define MENU_Y 178

@implementation SelectScence

-(id)init
{
    self = [super init];
    if(self)
    {
        [MusicCenter playModeBackgroundMusic:menuMain];
        [self SingleLayerInit];
        [self PartyLayerInit];
        [self Load];
    }
    return self;
}

-(void)Load
{
    offset = 0;
    sx = 0, px = 340;
    CCMenuItemSprite * left = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_fanye_zuo.png")] selectedSprite:nil target:self selector:@selector(ScrollLeft)];
    CCMenuItemSprite * right = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_fanye_you.png")] selectedSprite:nil target:self selector:@selector(ScrollRight)];
    CCMenu * LRMenu = [CCMenu menuWithItems:left, right, nil];
    LRMenu.position = ccp(MENU_X, MENU_Y);
    [LRMenu alignItemsHorizontallyWithPadding:400];
    [self addChild:LRMenu];
    
    CCMenuItemSprite * backItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_fanhui.png")]
                                                          selectedSprite:nil 
                                                                  target:self
                                                                selector:@selector(BackMenuLayer)];
    CCMenu * BackMenu = [CCMenu menuWithItems:backItem, nil];
    BackMenu.position = ccp(BUTTON_BACK_X, BUTTON_BACK_Y);
    [self addChild:BackMenu];
    
    CCMenuItemSprite * redeemItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_shuihuan_redeem.png")]
                                                          selectedSprite:nil 
                                                                  target:self
                                                                selector:@selector(OpenRedeem)];
    CCMenu * redeemMenu = [CCMenu menuWithItems:redeemItem, nil];
    redeemMenu.position = ccp(240, 60);
    [self addChild:redeemMenu];
    
    point1 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_fanye_pointon.png")]
                                      selectedSprite:nil 
                                      disabledSprite:[CCSprite spriteWithFile:OC("tc_vi_fanye_pointoff.png")]
                                              target:self 
                                            selector:nil];
    point2 = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_fanye_pointon.png")]
                                      selectedSprite:nil 
                                      disabledSprite:[CCSprite spriteWithFile:OC("tc_vi_fanye_pointoff.png")] 
                                              target:self 
                                            selector:nil];
    [point1 setIsEnabled:true];
    [point2 setIsEnabled:false];
    CCMenu * pointMenu = [CCMenu menuWithItems:point1, point2, nil];
    [pointMenu alignItemsHorizontallyWithPadding:10];
    pointMenu.position = ccp(240, 20);
    [self addChild:pointMenu];
}

-(void)PointRefresh:(int)th
{
    point1.isEnabled = (th == 1);
    point2.isEnabled = (th == 2);
}

-(void)ScrollLeft
{
    if([singleLayer numberOfRunningActions] + [partyLayer numberOfRunningActions] > 0) return;
    sx = singleLayer.position.x;
    px = partyLayer.position.x;
    offset = 240;
    if(sx == 0) return;
    [singleLayer runAction:[CCMoveTo actionWithDuration:fabs(offset) * 0.001 position:ccp(sx + (offset / 240) * 480, 0)]];
    [partyLayer runAction:[CCMoveTo actionWithDuration:fabs(offset) * 0.001 position:ccp(px + (offset / 240) * 480, 0)]];
    [self PointRefresh:1];
}

-(void)ScrollRight
{
    if([singleLayer numberOfRunningActions] + [partyLayer numberOfRunningActions] > 0) return;
    offset = -240;
    sx = singleLayer.position.x;
    px = partyLayer.position.x;
    if(px == 0) return;
    [singleLayer runAction:[CCMoveTo actionWithDuration:fabs(offset) * 0.001 position:ccp(sx + (offset / 240) * 480, 0)]];
    [partyLayer runAction:[CCMoveTo actionWithDuration:fabs(offset) * 0.001 position:ccp(px + (offset / 240) * 480, 0)]];
    [self PointRefresh:2];
}

-(void)BackMenuLayer
{
    [MusicCenter playSoundEffect:leftButton];
    [SceneManager GoMenu];
}

-(void)OpenRedeem
{
    [MusicCenter playSoundEffect:bottomButton];
    _redeemLayer = [RedeemLayer node];
    [self addChild:_redeemLayer];
}

-(void)SingleLayerInit
{
    singleLayer = [CCLayer node];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * background = [CCSprite spriteWithFile:OC("tc_ch_vi_bk.png")];
    background.position = ccp(size.width / 2, size.height / 2);
    
    [singleLayer addChild:background];

    slevel1 = [CCMenuItemToggle itemWithTarget:self 
                                      selector:@selector(Go_Level_1_1)
                                         items:
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_1.png")] 
                                       selectedSprite:nil],
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_suo.png")] 
                                       selectedSprite:nil],
               nil];
    
    slevel2 = [CCMenuItemToggle itemWithTarget:self 
                                      selector:@selector(Go_Level_1_2)
                                         items:
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_2.png")] 
                                       selectedSprite:nil],
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_ch_vi_lock_2.png")] 
                                       selectedSprite:nil],
               nil];
    
    slevel3 = [CCMenuItemToggle itemWithTarget:self 
                                      selector:@selector(Go_Level_1_3)
                                         items:
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_3.png")] 
                                       selectedSprite:nil],
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_ch_vi_lock_3.png")] 
                                       selectedSprite:nil],
               nil];    
    CCMenu * levelMenu = [CCMenu menuWithItems:slevel1, slevel2, slevel3, nil];
    [levelMenu alignItemsHorizontallyWithPadding:20];
    levelMenu.position = ccp(MENU_X, MENU_Y);
    [singleLayer addChild:levelMenu];
    [self addChild:singleLayer];
    [self PassRefresh];
}



-(void)PartyLayerInit
{
    partyLayer = [CCLayer node];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * background = [CCSprite spriteWithFile:OC("tc_vi_pt_bk.png")];
    background.position = ccp(size.width / 2, size.height / 2);
    
    [partyLayer addChild:background];
    
    plevel1 = [CCMenuItemToggle itemWithTarget:self 
                                      selector:@selector(Go_Level_2_1)
                                         items:
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_pt_1.png")] 
                                       selectedSprite:nil],
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_pt_lock_1.png")] 
                                       selectedSprite:nil],
               nil];    
    
    plevel2 = [CCMenuItemToggle itemWithTarget:self 
                                      selector:@selector(Go_Level_2_2)
                                         items:
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_pt_2.png")] 
                                       selectedSprite:nil],
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_pt_lock_2.png")] 
                                       selectedSprite:nil],
               nil];  
    
    plevel3 = [CCMenuItemToggle itemWithTarget:self 
                                      selector:@selector(Go_Level_2_3)
                                         items:
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_pt_3.png")] 
                                       selectedSprite:nil],
               [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_pt_lock_3.png")] 
                                       selectedSprite:nil],
               nil];      
    CCMenu * levelMenu = [CCMenu menuWithItems:plevel1, plevel2, plevel3, nil];
    levelMenu.position = ccp(MENU_X, MENU_Y);
    [levelMenu alignItemsHorizontallyWithPadding:20];
    [partyLayer addChild:levelMenu];
    partyLayer.position = ccp(size.width, 0);
    [self addChild:partyLayer];
    [self PassRefresh];
}

-(void)PassRefresh
{
    if(1 <= [DataSys GetSinglePass]) [slevel1 setSelectedIndex:0];
    else [slevel1 setSelectedIndex:1];
    
    if(2 <= [DataSys GetSinglePass]) [slevel2 setSelectedIndex:0];
    else [slevel2 setSelectedIndex:1];
    
    if(3 <= [DataSys GetSinglePass]) [slevel3 setSelectedIndex:0];
    else [slevel3 setSelectedIndex:1];
    
    if(1 <= [DataSys GetPartyPass]) [plevel1 setSelectedIndex:0];
    else [plevel1 setSelectedIndex:1];
    
    if(2 <= [DataSys GetPartyPass]) [plevel2 setSelectedIndex:0];
    else [plevel2 setSelectedIndex:1];
    
    if(3 <= [DataSys GetPartyPass]) [plevel3 setSelectedIndex:0];
    else [plevel3 setSelectedIndex:1];
}

-(void)GoGame{
    if(selectMode == gameSingleMode && selectLevel == 1)
        [SceneManager GoSingle1];
    if(selectMode == gameSingleMode && selectLevel == 2)
        [SceneManager GoSingle2];
    if(selectMode == gamePartyMode && selectLevel == 1)
        [SceneManager GoParty1];
    
}


-(void)Go_Level_1_1{
    [MusicCenter playSoundEffect:bottomButton];
    [slevel1 setSelectedIndex:1 - [slevel1 selectedIndex]];    
    selectMode = gameSingleMode;
    selectLevel = 1;
    [self AddLoadLayer];
    [self performSelector:@selector(GoGame) withObject:nil afterDelay:0.5f];
}

-(void)Go_Level_1_2
{
    [MusicCenter playSoundEffect:bottomButton];
    [slevel2 setSelectedIndex:1 - [slevel2 selectedIndex]];
    if([slevel2 selectedIndex] == 1)
    {
        PassLayer * _passLayer = [PassLayer node];
        [_passLayer SetInfo:OC("tc_guanka_1_2.png") Mode:gameSingleMode Level:10 Coin:2000];
        [self addChild:_passLayer z:3];
    }else
    {
        selectMode = gameSingleMode;
        selectLevel = 2;
        [self AddLoadLayer];
        [self performSelector:@selector(GoGame) withObject:nil afterDelay:0.5f];
    }
}

-(void)Go_Level_1_3{
    [MusicCenter playSoundEffect:error];
    [slevel3 setSelectedIndex:1 - [slevel3 selectedIndex]];      
}

-(void)Go_Level_2_1
{
    [MusicCenter playSoundEffect:bottomButton];
    [plevel1 setSelectedIndex:1 - [plevel1 selectedIndex]];
    if([plevel1 selectedIndex] == 1)
    {
        PassLayer * _passLayer = [PassLayer node];
        [_passLayer SetInfo:OC("tc_guanka_2_1.png") Mode:gamePartyMode Level:15 Coin:2000];
        [self addChild:_passLayer z:3];
    }else
    {
        selectMode = gamePartyMode;
        selectLevel = 1;
        [self AddLoadLayer];
        [self performSelector:@selector(GoGame) withObject:nil afterDelay:0.5f];
    }
}

-(void)Go_Level_2_2
{
    [MusicCenter playSoundEffect:error];
    [plevel2 setSelectedIndex:1 - [plevel2 selectedIndex]];
}

-(void)Go_Level_2_3
{
    [MusicCenter playSoundEffect:error];
    [plevel3 setSelectedIndex:1 - [plevel3 selectedIndex]];
}

-(void)AddLoadLayer
{
    CCSprite * loadLayer = [CCSprite spriteWithFile:OC("tc_loading.png")];
    loadLayer.position = ccp(SCREEN_X, SCREEN_Y);
    [self addChild:loadLayer z:3];
}

-(BOOL)ccTouchBegan :(UITouch *)touch withEvent:(UIEvent *)event
{
    isAction = (bool)([singleLayer numberOfRunningActions] + [partyLayer numberOfRunningActions] > 0);
    if(isAction) return YES;
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    begin = (int)touchPoint.x;
    sx = singleLayer.position.x;
    px = partyLayer.position.x;
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    if(isAction) return;
    CGPoint touchPoint = [touch locationInView:[touch view]];
    touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    move = (int)touchPoint.x;
    offset = move - begin;
    if(sx + offset > 0) return;
    if(px + offset < 0) return;
    singleLayer.position = ccp(sx + offset, 0);
    partyLayer.position = ccp(px + offset, 0);
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(isAction) return;
    CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
    if(sx + offset > 0) return;
    if(px + offset < 0) return;
    [singleLayer runAction:[CCMoveTo actionWithDuration:fabs(offset) * 0.001 position:ccp(sx + (offset / 240) * 480, 0)]];
    [partyLayer runAction:[CCMoveTo actionWithDuration:fabs(offset) * 0.001 position:ccp(px + (offset / 240) * 480, 0)]];
    if(offset > 0 && fabs(offset) >= 240) [self PointRefresh:1];
    if(offset < 0 && fabs(offset) >= 240) [self PointRefresh:2];
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