//
//  Boat.h
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Player;

@interface Boat : CCLayer {
    Player *_player;
    CCSprite *_logo;
    CCSpriteBatchNode *_spriteSheet;
    int _constraint;
}

@end
