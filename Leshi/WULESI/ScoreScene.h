//
//  ScoreScene.h
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-16.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScoreScene : CCLayer {
    CCSprite *_bgp;
    CCSprite *_items;
    CCMenu *_menu;
    
    BOOL _isMovingRight;
    int _movingCount;
}

@end
