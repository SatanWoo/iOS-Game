//
//  loseLayer.m
//  tapat
//
//  Created by Yu Dingsheng on 11-2-11.
//  Copyright 2011 Tongji. All rights reserved.
//

#import "loseLayer.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "SelectLevel.h"
#import "saveSetting.h"
#import "saveData.h"

@interface loseLayer()
-(void)setBackground;
-(void)setPropPicture;
-(void)setLoseBackground;
-(void)setButton;
-(void)showScore;
@end



@implementation loseLayer

-(id)init{
	self = [super init];
	if(self){
		[self setBackground];
		[self setPropPicture];
		[self setLoseBackground];
		[self setButton];
		[self showScore];
	}
	return self;
}


-(void)setBackground{
	int kind = [saveSetting getBackground];
	CCSprite* gameBackground = [CCSprite spriteWithFile:[NSString stringWithFormat: @"GameBackground%d.png", kind] rect:CGRectMake(0,0,ipadWidth,ipadLength)];
	gameBackground.position = ccp(ipadWidth / 2, ipadLength / 2);
	[self addChild:gameBackground z:0];		
}

-(void)setPropPicture{
	int fromBottom = 70, fromLeft = 70;
	int rowVal = 83, lineVal = 20; 
	
	CCSprite* mucus = [CCSprite spriteWithFile:@"Mucus.png" rect:CGRectMake(0,0, 100,85)];
	mucus.position = ccp(fromLeft + 4 * lineVal, fromBottom + 4 * rowVal);
	[self addChild:mucus];
	
	CCSprite* food = [CCSprite spriteWithFile:@"Food.png" rect:CGRectMake(0,0, 100,85)];
	food.position = ccp(fromLeft + 3 *lineVal, fromBottom + 3 * rowVal);
	[self addChild:food];
	
	CCSprite* net = [CCSprite spriteWithFile:@"Net.png" rect:CGRectMake(0,0, 100,85)];
	net.position = ccp(fromLeft + 2 * lineVal, fromBottom + 2 * rowVal);
	[self addChild:net];						
	
	CCSprite* toxic = [CCSprite spriteWithFile:@"Toxic.png" rect:CGRectMake(0,0, 100,85)];
	toxic.position = ccp(fromLeft + 1 * lineVal, fromBottom + 1 * rowVal);
	[self addChild:toxic];
	
	CCSprite* virus = [CCSprite spriteWithFile:@"Virus.png" rect:CGRectMake(0,0, 100,85)];
	virus.position = ccp(fromLeft, fromBottom);
	[self addChild:virus];
}

-(void)setLoseBackground{
	CCSprite* loseBackground = [CCSprite spriteWithFile:@"loseBackground.png" rect:CGRectMake(0, 0, ipadWidth, ipadLength)];
	loseBackground.position = ccp(ipadWidth / 2, ipadLength / 2);
	[self addChild:loseBackground];
}

-(void)setButton{
	CCSprite* menu = [CCSprite spriteWithFile:@"lose_back.png" rect:CGRectMake(0, 0, 50, 50)];
	CCMenuItem* menuItem = [CCMenuItemSprite itemFromNormalSprite:menu selectedSprite:nil target:self selector:@selector(goMenu:)];
	CCSprite* replay = [CCSprite spriteWithFile:@"lose_replay.png" rect:CGRectMake(0, 0, 50, 50)];
	CCMenuItem* replayItem = [CCMenuItemSprite itemFromNormalSprite:replay selectedSprite:nil target:self selector:@selector(goReplay:)];	
	CCMenu* buttonMenu = [CCMenu menuWithItems:menuItem, replayItem, nil];

	buttonMenu.position = ccp(ipadWidth / 2, ipadLength / 2 - 150);
	[buttonMenu alignItemsHorizontallyWithPadding:150.0];
	[self addChild:buttonMenu];
}

-(void)goMenu:(id)sender{
	[SceneManager goMenu:sender];
}

-(void)goReplay:(id)sender{
	[SelectLevel generateGame];
}

-(void)showScore{
	int best, your, win;
	best = [saveData getAdvenScore:Level-1];
	your = tempScore;
	win  = tempWinScore;
	
	if(your > best){
		[saveData saveAdvenScore:your level:Level-1];
		best = your;
	}

	CCLabelTTF* bestScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Best Score: %d",best]
								               fontName:@"nevis.ttf" fontSize:40.0f];
	bestScore.position=ccp(ipadWidth / 2, 450);
	[bestScore setColor:ccBLACK];
	[self addChild:bestScore z:8];
	
	
	
	CCLabelTTF* yourScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Your Score: %d",your]
								               fontName:@"nevis.ttf" fontSize:40.0f];
	yourScore.position=ccp(ipadWidth / 2, 400);
	[yourScore setColor:ccBLACK];
	[self addChild:yourScore z:8];

	
	CCLabelTTF* winScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Win Score: %d",win]											  
											  fontName:@"nevis.ttf" fontSize:40.0f];
	winScore.position=ccp(ipadWidth / 2, 350);
	[winScore setColor:ccBLACK];
	[self addChild:winScore z:8];
}

-(void)dealloc{
	[super dealloc];
}

@end
