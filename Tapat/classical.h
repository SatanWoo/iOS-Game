//
//  classical.h
//  tapat
//
//  Created by Yu Dingsheng on 11-1-29.
//  Copyright 2011 Tongji. All rights reserved.
//


#import "cocos2d.h"
#import "gameLayer.h"

@interface classical : CCLayer {
	// data of hole
	Point showPosition[MaxRow][MaxLine];
	int isUsed[MaxRow][MaxLine];
	
	// data of the mice
	CCSprite* mice[MaxRow][MaxLine];
	int miceBlood[MaxRow][MaxLine];
	ccTime miceShowTime[MaxRow][MaxLine];
	ccTime miceRefreshTime;
	ccTime miceLiveTime;
	
	int firstMice;
	int secondMice;
	int thirdMice;
	
	int blood_1;
	int blood_2;
	int blood_3;
	
	// data of the prop
	CCSprite* prop[MaxRow][MaxLine];
	int propKind[MaxRow][MaxLine];
	ccTime propShowTime[MaxRow][MaxLine];
	ccTime propRefreshTime;
	ccTime propLiveTime;
	
	double proMucus;
	double proFood;
	double proNet;
	double proToxic;
	double proVirus;
	double proSnake;
	
	int ownMucusNum;
	int ownFoodNum;
	int ownNetNum;
	int ownToxicNum;
	int ownVirusNum;
	
	int snakeNum;
	
	int totMucusTime;
	int totFoodTime;
	int totToxicTime;
	int totVirusTime;
	
	int runMucusTime;
	int runFoodTime;
	int runToxicTime;
	int runVirusTime;
	
	CCLabelTTF* recordMucus;
	CCLabelTTF* recordFood;
	CCLabelTTF* recordNet;
	CCLabelTTF* recordToxic;
	CCLabelTTF* recordVirus;
	
	bool isMucus;
	bool isFood;
	bool isToxic;
	bool isVirus;
	
	int tempForFood;
	
	
	
	//data of the game
	ccTime gameRunTime;
	
	int score;
	int escape;
	
	
	CCLabelTTF* recordScore;//记录分数
	CCLabelTTF* recordTime;//记录时间
	CCLabelTTF* timeShow;
	CCLabelTTF* scoreShow;
	
	bool isOn[4];
	CCSprite* statu[4];
	CCSprite* statuProp[4];
	
	CCSprite* cross[3];
	
	NSArray* startArray;
	int readyIndex;
	
	int state;
    
    int coldNowOfMucus;
    BOOL canBeUsedOfMucus;
    CCSprite* coldEffectOfMucus;
    
    int coldNowOfVirus;
    BOOL canBeUsedOfVirus;
    CCSprite* coldEffectOfVirus;
    
    int coldNowOfFood;
    BOOL canBeUsedOfFood;
    CCSprite* coldEffectOfFood;
    
    
    int coldNowOfNet;
    BOOL canBeUsedOfNet;
    CCSprite* coldEffectOfNet;
    
    int coldNowOfToxic;
    BOOL canBeUsedOfToxic;
    CCSprite* coldEffectOfToxic;
	CCSprite* pauseView;
    
    BOOL isPause;
    CCMenu* tempMenu;
}

-(void)showColdEffectOfMucus;
-(void)showColdEffectOfFood;
-(void)showColdEffectOfVirus;
-(void)showColdEffectOfNet;
-(void)showColdEffectOfToxic;
-(void)initStatus;

@end