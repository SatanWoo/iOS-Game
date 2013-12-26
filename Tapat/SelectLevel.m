//
//  SelectLevel.m
//  tapat
//
//  Created by Yu Dingsheng on 11-1-26.
//  Copyright 2011 Tongji. All rights reserved.
//

#import "SelectLevel.h"
#import "cocos2d.h"
#import "GameConfig.h"
#import "gameLayer.h"
#import "gameBackground.h"
#import "SceneManager.h"
#import "saveSetting.h"
#import "saveData.h"


@interface SelectLevel()

-(void)setBackground;
-(void)setLevelButton;
-(void)setBackButton;

@end

@implementation SelectLevel

+(id)scene{
	CCScene* scene =[CCScene node];
	SelectLevel* layer =[SelectLevel node];
	[scene addChild:layer];
	return  scene;
}

-(id)init{
	self =[super init];
	if (self) {
		[self setBackground];
		[self setLevelButton];
		[self setBackButton];
	}
	return self;
}

-(void)setBackground{
	//Set the menu's background
	CCSprite* background =[CCSprite spriteWithFile:@"SelectLevel.png" rect:CGRectMake(0, 0, ipadWidth, ipadLength)];
	background.position=ccp(ipadWidth/ 2,ipadLength / 2);
	[self addChild:background z:0];
}

-(void)setLevelButton{
	finish = [saveData getLevel];
	if(finish == 0){
		finish = 1;
		[saveData saveLevel:1];
	}
		
	CCSprite* lock = [CCSprite spriteWithFile:@"lock.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level1Sprite =[CCSprite spriteWithFile:@"level1.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level2Sprite =[CCSprite spriteWithFile:@"level2.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level3Sprite =[CCSprite spriteWithFile:@"level3.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level4Sprite =[CCSprite spriteWithFile:@"level4.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level5Sprite =[CCSprite spriteWithFile:@"level5.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level6Sprite =[CCSprite spriteWithFile:@"level6.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level7Sprite =[CCSprite spriteWithFile:@"level7.png" rect:CGRectMake(0, 0, 100, 100)];
	CCSprite* level8Sprite =[CCSprite spriteWithFile:@"level8.png" rect:CGRectMake(0, 0, 100, 100)];
	if(1 > finish)  level1Sprite = lock;
	if(2 > finish)  level2Sprite = lock;
	if(3 > finish)  level3Sprite = lock;
	if(4 > finish)  level4Sprite = lock;
	if(5 > finish)  level5Sprite = lock;
	if(6 > finish)  level6Sprite = lock;
	if(7 > finish)  level7Sprite = lock;
	if(8 > finish)  level8Sprite = lock;

	CCMenuItem* level1 =[CCMenuItemSprite itemFromNormalSprite:level1Sprite selectedSprite:nil target:self selector:@selector(selectLevel1:)];
	CCMenuItem* level2 =[CCMenuItemSprite itemFromNormalSprite:level2Sprite selectedSprite:nil target:self selector:@selector(selectLevel2:)];
	CCMenuItem* level3 =[CCMenuItemSprite itemFromNormalSprite:level3Sprite selectedSprite:nil target:self selector:@selector(selectLevel3:)];
	CCMenuItem* level4 =[CCMenuItemSprite itemFromNormalSprite:level4Sprite selectedSprite:nil target:self selector:@selector(selectLevel4:)];
	CCMenuItem* level5 =[CCMenuItemSprite itemFromNormalSprite:level5Sprite selectedSprite:nil target:self selector:@selector(selectLevel5:)];
	CCMenuItem* level6 =[CCMenuItemSprite itemFromNormalSprite:level6Sprite selectedSprite:nil target:self selector:@selector(selectLevel6:)];
	CCMenuItem* level7 =[CCMenuItemSprite itemFromNormalSprite:level7Sprite selectedSprite:nil target:self selector:@selector(selectLevel7:)];
	CCMenuItem* level8 =[CCMenuItemSprite itemFromNormalSprite:level8Sprite selectedSprite:nil target:self selector:@selector(selectLevel8:)];
	

	CCMenu* levelMenu1 = [CCMenu menuWithItems:level1, level2, level3, level4, nil];
	levelMenu1.position = ccp(ipadWidth / 2, ipadLength / 2 + 100);
	[levelMenu1 alignItemsHorizontallyWithPadding: 20];
	[self addChild:levelMenu1 z:1];
	
	CCMenu* levelMenu2 = [CCMenu menuWithItems:level5, level6, level7, level8, nil];
	levelMenu2.position = ccp(ipadWidth / 2, ipadLength / 2 - 100);
	[levelMenu2 alignItemsHorizontallyWithPadding: 20];
	[self addChild:levelMenu2 z:1];
	
}

-(void)selectLevel1:(id)sender{
	if(1 > finish) return;
	Level = 1;
	[SelectLevel generateGame];	
}

-(void)selectLevel2:(id)sender{
	if(2 > finish) return;
	Level = 2;
	[SelectLevel generateGame];	
}

-(void)selectLevel3:(id)sender{
	if(3 > finish) return;
	Level = 3;
	[SelectLevel generateGame];	
}

-(void)selectLevel4:(id)sender{
	if(4 > finish) return;
	Level = 4;
	[SelectLevel generateGame];	
}

-(void)selectLevel5:(id)sender{
	if(5 > finish) return;
	Level = 5;
	[SelectLevel generateGame];	
}

-(void)selectLevel6:(id)sender{
	if(6 > finish) return;
	Level = 6;
	[SelectLevel generateGame];	
}

-(void)selectLevel7:(id)sender{
	if(7 > finish) return;
	Level = 7;
	[SelectLevel generateGame];	
}

-(void)selectLevel8:(id)sender{
	if(8 > finish) return;
	Level = 8;
	[SelectLevel generateGame];	
}


+(void)generateGame{
	CCDirector* director = [CCDirector sharedDirector];
	CCScene* newScene = [CCScene node];
	CCLayer* layer1 = [gameBackground node];
	CCLayer* layer2 = [gameLayer node];
	[newScene addChild:layer1 z:0];
	[newScene addChild:layer2 z:1];
	[director replaceScene:[CCTransitionJumpZoom transitionWithDuration:1.0f scene:newScene]];
}

-(void)setBackButton{
	CCSprite* BackButton = [CCSprite spriteWithFile:@"back.png" rect:CGRectMake(0, 0, 80, 80)];
	CCMenuItem *BackButtonItem = [CCMenuItemSprite itemFromNormalSprite:BackButton selectedSprite:nil target:self selector:@selector(BackToMenu:)];						  
	CCMenu* BackMenu = [CCMenu menuWithItems:BackButtonItem,nil];
	BackMenu.position = ccp(ipadWidth - 40, 40);
	[self addChild:BackMenu z: 5];
}

-(void)BackToMenu:(id)sender{
	[SceneManager goMenu:sender];
}

-(void)dealloc{
	[super dealloc];
}


@end