//
//  ScoreScene.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-16.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "ScoreScene.h"
#import "Macro.h"
#import "SceneManager.h"
#import "MusicHandle.h"

int offset = 2;

@implementation ScoreScene

- (id)init
{
    self = [super init];
    if (self) {
        _bgp = [CCSprite spriteWithFile:@"showScore.png"];
        _bgp.position = ccp(IPADWIDTH / 2, IPADHEIGHT / 2);
        [self addChild:_bgp];
        
        _items = [CCSprite spriteWithFile:@"showScore_items.png"];
        _items.position = ccp(470, 100);
        [self addChild:_items];
        [self schedule:@selector(itemsShake) interval:0.2f];
        _isMovingRight = YES;
        _movingCount = 0;
    
        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",globalGameScore] 
                                               fontName:@"Marker Felt" fontSize:48];
        [label setColor:ccc3(255, 255, 255)];
        label.position = ccp(IPADWIDTH / 2 + 50, IPADHEIGHT / 2 + 45);
        [self addChild:label z:1];
        
        CCMenuItemSprite *gobackItem = 
        [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"quit.png"] 
                                selectedSprite:nil 
                                disabledSprite:nil 
                                        target:self 
                                      selector:@selector(goGame)];
        
        _menu = [CCMenu menuWithItems:gobackItem,nil];
        [_menu alignItemsVerticallyWithPadding:50];
        _menu.position = ccp(IPADWIDTH/2, IPADHEIGHT / 2 - 200);
        [self addChild:_menu z:1];
        
        [MusicHandle notifyCongratulation];
        [MusicHandle notifyClapping];
    }
    return self;
}

- (void)dealloc
{
    [self stopAllActions];
    [self removeAllChildrenWithCleanup:YES];
    _bgp = nil;
    [super dealloc];
}

- (void)itemsShake{
    if (_isMovingRight) {
        _items.position = CGPointMake(_items.position.x + 5, _items.position.y);
        _movingCount++;
        if (_movingCount == offset) {
            _isMovingRight = NO;
            _movingCount = 0;
        }
    }else {
        _items.position = CGPointMake(_items.position.x - 5, _items.position.y);
        _movingCount++;
        if (_movingCount == offset) {
            _isMovingRight = YES;
            _movingCount = 0;
        }
    }
}

- (void)goGame
{
    [SceneManager goMenu];
}

@end
