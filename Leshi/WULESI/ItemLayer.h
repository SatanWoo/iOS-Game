//
//  ItemLayer.h
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Player;
@class BlueTimeLineLayer;

@interface ItemLayer : CCLayer {
    CCArray *_array;
    CCArray *_npcArray;
    Player *_player;
    int _lastMoveLine;
    int _count; // Wu:to count how many items in the scene maxu
    BlueTimeLineLayer *_timeLayer;
    NSArray *_startArray;
    int _readyIndex;
    CCLabelTTF *_scoreTTF;
    int _score;
}

@end
