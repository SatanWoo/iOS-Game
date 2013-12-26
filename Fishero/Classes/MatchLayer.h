//
//  MatchLayer.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameConfig.h"
#import "cocos2d.h"
#import "SceneManager.h"

@interface MatchLayer : CCLayer {
	CCSprite* beans[maxRow][maxLine];
	CCSprite* point[maxRow][maxLine];
	CGPoint show[maxRow][maxLine];
	int isUsed[maxRow][maxLine];
	int colorCount[maxColor + maxProp];
	int score;
	
	double runTime;
	double gameTime;
	double lastTime;
	
	CCLabelTTF* recordScore;
	CCLabelTTF* recordClock;
	CCLabelTTF* recordRefresh;
	CCLabelTTF* yourScore;
	CCLabelTTF* combo;
	
	
	CCSprite* left;
	CCSprite* run;
	CCSprite* gameOverPicture;
	
	
	bool isGameOver;
	bool isFirstTouch;
	
	int comboNum;
	int clockNum;
	int refreshNum;
	
	

}

@end
