//
//  SelectLayer.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-11.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SelectLayer : CCLayer {
	CCMenuItemSprite* threeStage[4];
	CGPoint startPoint;
	int index;
}

-(void)addButton;

@end
