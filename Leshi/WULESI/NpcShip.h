//
//  NpcShip.h
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define STARTHEIGHT IPADHEIGHT * 2 / 3 // Wu:Put it here so you can use it in subclass

@interface NpcShip : CCSprite {
    CCSpriteBatchNode *_spriteSheet;
    CCSprite *_image;
    int _type;
    int _line;
    int _minusTime;
}

@property (nonatomic ,assign) int line;
@property (nonatomic ,readonly) int minusTime;

+ (id)createNpcWithType:(int)type;
- (void)actionStart;
- (void)move;

@end
