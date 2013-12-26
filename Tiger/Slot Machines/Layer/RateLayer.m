//
//  RateLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RateLayer.h"
#import "GameConfig.h"


@implementation RateLayer

-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)setBackground:(NSString *)name
{
    
   /* CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite * backImage = [CCSprite spriteWithFile:name];
    backImage.position = ccp(size.width / 2,size.height / 2);
    [self addChild:backImage z:0];
    
    CCMenuItemSprite * close = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_guanbianniu.png")] selectedSprite:nil disabledSprite:nil target:self selector:@selector(RemoveLayer)];
    CCMenu * closeMenu = [CCMenu menuWithItems:close, nil];
    closeMenu.position = ccp(425, 45);
    [self addChild:closeMenu z:2];*/
    if (_rateViewController == nil) {
        _rateViewController = [[RateViewController alloc] init];
        RootViewController* rootVC = (RootViewController *)([UIApplication sharedApplication].keyWindow.rootViewController);
        _rateViewController.delegate = self;
        _rateViewController.rateName = name;
        _rateViewController.view.frame = rootVC.view.bounds;
        [rootVC.view addSubview:_rateViewController.view];
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

#pragma mark - RateViewDelegate

- (void)dismissRateViewController
{
    [_rateViewController release];
    _rateViewController = nil;
    [self RemoveLayer];
}

@end
