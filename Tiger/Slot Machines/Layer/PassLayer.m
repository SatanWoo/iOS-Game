//
//  PassLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PassLayer.h"
#import "DataSys.h"
#import "SysConf.h"
#import "GameConfig.h"


@implementation PassLayer

-(id)init
{
    self = [super init];
    if(self)
    {
        [self LoadImage];
    }
    return self;
}

-(void)LoadImage
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * backgroundImage = [CCSprite spriteWithFile:OC("tc_i_zhezhao.png")];
    backgroundImage.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:backgroundImage];
    
    CCMenuItemSprite * openItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_tips_open.png")] selectedSprite:nil disabledSprite:nil target:self selector:@selector(OpenPass)];

    CCMenuItemSprite * closeItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_vi_tips_cancel.png")] selectedSprite:nil disabledSprite:nil target:self selector:@selector(RemoveLayer)];
    CCMenu * closeMenu = [CCMenu menuWithItems:openItem, closeItem, nil];
    closeMenu.position = ccp(320, 145);
    [closeMenu alignItemsHorizontallyWithPadding:5.0f];
    [self addChild:closeMenu z:2];
}

-(void)SetInfo:(NSString *)name Mode:(gameMode)mode Level:(int)level Coin:(int)coin
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * image = [CCSprite spriteWithFile:name];
    image.position = ccp(size.width / 2 , size.height / 2 + 20);
    [self addChild:image];
    nowMode = mode;
    needLevel = level;
    needCoin = coin;
}

-(void)OpenPass
{
//    if([DataSys GetLevel] < needLevel || [DataSys GetScore] < needCoin){
//        return;
//    }
//    [DataSys ScoreMinus:needCoin];
    if(nowMode == gameSingleMode) [DataSys AddSinglePass];
    if(nowMode == gamePartyMode) [DataSys AddPartyPass];
    [self.parent PassRefresh];
    [self RemoveLayer];
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
    return YES;
}

-(void)dealloc
{
    [super dealloc];
}

@end


