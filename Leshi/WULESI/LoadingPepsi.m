//
//  LoadingPepsi.m
//  WULESI
//
//  Created by M.K.Rain on 12-5-31.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "LoadingPepsi.h"
#import "SceneManager.h"
#import "Macro.h"

@implementation LoadingPepsi

- (id)init{
    self = [super init];
    if (self){
        _bg = [CCSprite spriteWithFile:@"loading_pepsi.png"];
        _bg.position = ccp(IPADWIDTH / 2, IPADHEIGHT / 2);
        [self addChild:_bg z:0];
        
        CCMenuItemSprite *startItem = 
        [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithFile:@"loading_start.png"] 
                                selectedSprite:nil 
                                disabledSprite:nil 
                                        target:self 
                                      selector:@selector(goGame)];
        
        _menu = [CCMenu menuWithItems:startItem,nil];
        [_menu alignItemsVerticallyWithPadding:50];
        _menu.position = ccp(IPADWIDTH / 2, IPADHEIGHT / 2  - 230);
        [self addChild:_menu z:1];
        
    }
    
    NSLog(@"class is %@",[self class]);
    return self;
}

- (void)goGame{
    [SceneManager goShip];
}

@end
