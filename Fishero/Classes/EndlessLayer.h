	//
	//  EndlessLayer.h
	//  Fishero
	//
	//  Created by 吴 wuziqi on 11-3-6.
	//  Copyright 2011年 同济大学. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCJoyStick.h"


@interface EndlessLayer : CCLayer<CCJoyStickDelegate> {
    CCJoyStick* controller;
    CCSprite* hero;
    CCSprite* enemy;
    CCSprite* leftBlood;
    CCSprite* rightBlood;
    int heroBlood;
    int enemyBlood;
	int enemySpeed;
	int enemyLevel;
	double moveInterval;
	double attackInterval;
	
	bool isShelter;
	
	int endlessScore;
}

-(void)initSprit;
-(void)initBoss;
-(void)initController;
-(void)moveItself;
-(void)shootToHero;
-(void)checkEnemyCollision:(CGPoint)bullet towards:(CGPoint)temp;
-(void)checkHeroCollision:(CGPoint)bullter towards:(CGPoint)temp;
-(void)goLose;
-(void)bossRefresh;

@end
