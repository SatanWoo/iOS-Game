	//
	//  AdventureLayer.h
	//  Fishero
	//
	//  Created by 吴 wuziqi on 11-3-7.
	//  Copyright 2011年 同济大学. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCJoyStick.h"


@interface AdventureLayer : CCLayer<CCJoyStickDelegate> {
    CCSprite* hero;
    float heroScale;
    CCSprite* enemy[10];
	CGPoint reachPoint[10];
	int maxOfEnemy;
	double speedOfEnemy;
    CCJoyStick* controller;
	
	int advenScore;
}

-(void)initData;
-(void)initController;
-(void)initEnemy;
-(void)generateEnemy;
	//-(void)checkForEat;
-(void)backToNormal;
-(void)scaleBack;
@end
