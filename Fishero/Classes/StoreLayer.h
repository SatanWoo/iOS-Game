//
//  StoreLayer.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SceneManager.h"
@interface StoreLayer : CCLayer {
	
	CCLabelTTF* recordLevelofShelter;
	CCLabelTTF* recordCostofShelter;

	
	CCLabelTTF* recordLevelofSize;
	CCLabelTTF* recordCostofSize;
	
	CCLabelTTF* recordLevelofPower;
	CCLabelTTF* recordCostofPower;
	
	CCLabelTTF* recordMyScore;
	
	int lastScore;
}

-(void)addUpdate;

-(void)updateShelter:(id)sender;

-(void)updateSize:(id)sender;

-(void)updatePower:(id)sender;

-(void)goMenu;

@end
