//
//  BuyLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BuyLayer.h"
#import "GameConfig.h"


@implementation BuyLayer

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
    /*CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * backgroundImage = [CCSprite spriteWithFile:OC("tc_gi_single_pr_coinbuy.png")];
    backgroundImage.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:backgroundImage];
    
    CCMenuItemSprite * close = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_guanbianniu.png")] selectedSprite:nil disabledSprite:nil target:self selector:@selector(RemoveLayer)];
    CCMenu * closeMenu = [CCMenu menuWithItems:close, nil];
    closeMenu.position = ccp(425, 45);
    [self addChild:closeMenu z:2];*/
    if (_buyVC == nil) {
        RootViewController* rootVC = (RootViewController *)([UIApplication sharedApplication].keyWindow.rootViewController);

        _buyVC = [[BuyCoinViewController alloc]init];
        _buyVC.delegate = self;
        _buyVC.view.frame = rootVC.view.bounds;
        [rootVC.view addSubview:_buyVC.view];
    }
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

#pragma mark - Delegate

- (void)dismissBuyCoinViewController
{
    [_buyVC release];
    _buyVC = nil;
    [self RemoveLayer];
}

@end


