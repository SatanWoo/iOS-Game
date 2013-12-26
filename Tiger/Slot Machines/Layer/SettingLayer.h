//
//  SettingLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SettingLayer : CCLayer <CCTargetedTouchDelegate> {
    CCSprite * bkMusic, * soundEffect, * shockEffect, * dataRefresh;
    CCSprite * pointer;
    int ori_x, ori_y;
    int begin, move, end, offset;
    bool isSlide;
}


-(void)InitLayer;

@end
