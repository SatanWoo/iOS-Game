//
//  RedeemLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RedeemLayer.h"
#import "GameConfig.h"


@implementation RedeemLayer

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
    CCSprite * backgroundImage = [CCSprite spriteWithFile:OC("tc_shuihuan_background.png")];
    backgroundImage.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:backgroundImage];

    CCMenuItemSprite * closeItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_shuihuan_guanbi.png")]
                                                            selectedSprite:nil 
                                                                    target:self
                                                                  selector:@selector(RemoveLayer)];
    CCMenu * closeMenu = [CCMenu menuWithItems:closeItem, nil];
    closeMenu.position = ccp(407, 267);
    [self addChild:closeMenu];    
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