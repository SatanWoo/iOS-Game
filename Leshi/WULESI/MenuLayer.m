//
//  MenuLayer.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-11.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "MenuLayer.h"
#import "SceneManager.h"
#import "Macro.h"

@implementation MenuLayer

#pragma mark - Private Method

- (void)goGame
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ADDINPUTCONTROLLER object:nil];
}

- (void)goLottery
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ADDLOTTERYCONTROLLER object:nil];
}

#pragma mark - Public Method

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _bgp = [CCSprite spriteWithFile:@"menu_bg.png"];
        _bgp.position = ccp(IPADWIDTH / 2, IPADHEIGHT / 2);
        [self addChild:_bgp z:0];
        
        
        CCMenuItemSprite *startItem = 
                                [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"start_btn.png"] 
                                                              selectedSprite:nil 
                                                              disabledSprite:nil 
                                                                      target:self 
                                                                    selector:@selector(goGame)];
        
        CCMenuItemSprite *lotteryItem = 
                    [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"lottery_enable_btn.png"] 
                                                                selectedSprite:nil 
                                                                disabledSprite:[CCSprite spriteWithFile:@"lottery_disable_btn.png"] 
                                                                        target:self selector:@selector(goLottery)];
        NSDate *date = [[NSUserDefaults standardUserDefaults] valueForKey:UNLOCKKEY];
        NSLog(@"unlock:%@",[date description]);
        NSLog(@"today:%@",[[NSDate date]description]);
        NSDate *resultDate = [date earlierDate:[NSDate date]];
        if ([resultDate isEqualToDate:date]) {
            lotteryItem.isEnabled = TRUE;
        }else {
            lotteryItem.isEnabled = FALSE;
        }
        
        _menu = [CCMenu menuWithItems:startItem,lotteryItem,nil];
        [_menu alignItemsVerticallyWithPadding:15];
        _menu.position = ccp(IPADWIDTH / 2, IPADHEIGHT / 2 - 130);
        [self addChild:_menu z:1];
        
    }
    NSLog(@"class is %@",[self class]);
    return self;
}

- (void)dealloc
{
    _bgp = nil;
    _menu = nil;
    [super dealloc];
}

@end
