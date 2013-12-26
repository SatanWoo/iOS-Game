//
//  JoySticker.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfig.h"

@interface Tiger : CCSprite{
    CCSprite * _image;
    CCSpriteBatchNode *_spriteSheet;
    CCAction * _action;
}

-(void)InitTigerWithPng:(NSString *)name;
-(void)SetActionable:(bool)isActionable;
@end