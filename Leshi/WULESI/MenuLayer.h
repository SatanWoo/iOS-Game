//
//  MenuLayer.h
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-11.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuLayer : CCLayer {
    CCSprite *_bgp;
    CCMenu *_menu;
}

+(CCScene *) scene;

@end
