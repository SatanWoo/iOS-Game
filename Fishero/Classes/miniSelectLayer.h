//
//  miniSelectLayer.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface miniSelectLayer : CCLayer {
	CCMenuItemSprite* threeStage[3];
	CCSprite* threeLock[3];
	CGPoint startPoint;
	int index;
	int cannotUse[3];

}

@end
