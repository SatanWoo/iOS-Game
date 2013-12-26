//
//  MGFishingGameLayer.h
//  MiniGame
//
//  Created by Ye Gabriel on 11-3-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define SF_NUM 9
#define MF_NUM 6
#define LF_NUM 3

#define BUBBLE_NUM 30
#define RUBBISH_NUM 6
#define BOMB_NUM 6

#define COLLISION_SCALE .2f
#define DOWN_SPEED 1600
#define UP_SPEED 250
#define DRAGGED_UPSPEED 70
#define FISHUP_DURATION 1
#define SF_DURATION 8
#define MF_DURATION 6
#define LF_DURATION 4
#define HOOKDOWN_DURATION 4

#define SSCORE 1
#define MSCORE 3
#define LSCORE 10

#define TIME_LIMIT 90

typedef enum{
	bgTag,
	hookTag,
	smallfishTag,
	midfishTag,
	largefishTag,
	labelTag,
	bubbleTag,
	bombTag,
	rubbishTag,
	timewarning1,
	timewarning2,
}GameLayerTags;

typedef enum{
	uncatched,
	retrieving,
	catched,
}FishStatus;

typedef enum{
	left,
	right,
}FishDirection;


@interface MGFishingGameLayer : CCLayer {
	CCSprite * gameBackground;
	
	CCSprite * hookSprite;
	CGPoint playerPos;
	CGSize screenSize;
	
	CCArray * SFishes;
	CCArray * MFishes;
	CCArray * LFishes;
	
	CCArray * Bubbles;
	
	CCArray * Rubbish;
	CCArray * Bombs;
	
	CCLabelTTF * scoreLabel;
	
	
//	float fishMoveDuration;
//	int numFishesMoved;
	
	int curScore;
	int lastScore;
	int timeTemp;
	
	float retrieveSpeed;
	float hookCollisionRadius;
	float sfCollisionRadius;
	float mfCollisionRadius;
	float lfCollisionRadius;
	
	float bombCollisionRadius;
	float rubbishCollisionRadius;
	
	ccTime totalTime;
//	id hookAnimation;
	
	bool isTouchEnabled;
	bool hookReady;
	bool hookLaunched;
	
	FishStatus fishCatchedOrNot;
//	GameLayerTags curFishType;
	
	CGPoint gameLayerPosition;
	CGPoint lastTouchLocation;
	
}

@end
