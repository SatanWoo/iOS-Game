//
//  MenuLayer.h
//  T01
//
//  Created by 吴 wuziqi on 11-3-6.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface MenuLayer : CCLayer {
    
    BOOL optionUsed;
    BOOL infoUsed;
	CGPoint startPos1;
	CGPoint startPos2;
	CGPoint startPos3;
	CGPoint startPos4;
	CGPoint startPos5;
	
	CGPoint endPos1;
	CGPoint endPos2;
	CGPoint endPos3;
	CGPoint endPos4;
	CGPoint endPos5;
	
	CCLabelTTF* totalScore;
}

+(id)scene;

-(void)addButton;

-(void)goEndless;
-(void)goAdventure;
-(void)goMiniGame;
-(void)goStore;
-(void)addOption;

-(void)addInfo;

-(void)checkState;


@end
