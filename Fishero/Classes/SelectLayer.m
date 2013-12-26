//
//  SelectLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-11.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "SelectLayer.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "ActiveBGLayer.h"
#import "BubbleLayer.h"
#import "saveData.h"

@implementation SelectLayer

-(id)init
{
	self =[super init];
	if (self) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
		index=1;
		CCSprite* sprite1=[CCSprite spriteWithFile:@"seaport.png"];
		CCSprite* sprite2=[CCSprite spriteWithFile:@"ice.png"];
		CCSprite* sprite3=[CCSprite spriteWithFile:@"undersea.png"];
		CCSprite* sprite4=[CCSprite spriteWithFile:@"coming.png"];

		threeStage[0]=[CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:nil target:self selector:@selector(setLevelOne)];
		threeStage[1]=[CCMenuItemSprite itemFromNormalSprite:sprite2 selectedSprite:nil target:self selector:@selector(setLevelTwo)];
		threeStage[2]=[CCMenuItemSprite itemFromNormalSprite:sprite3 selectedSprite:nil target:self selector:@selector(setLevelThree)];
		threeStage[3]=[CCMenuItemSprite itemFromNormalSprite:sprite4 selectedSprite:nil];

		

		CCMenu* selectsStage=[CCMenu menuWithItems:threeStage[0],threeStage[1],threeStage[2],threeStage[3],nil];
		[selectsStage alignItemsHorizontallyWithPadding:300];
			//selectsStage.anchorPoint=CGPointMake(0,0);
		[self addChild:selectsStage z:1 tag:1];		
		
		CCLayer * activeBG = [ActiveBGLayer node];
		[self addChild:activeBG z:0 tag:100];
		
		CCLayer * bubbleLayer = [BubbleLayer node];
		[self addChild:bubbleLayer z:0 tag:101];
		
		[self addButton];
		
		NSString* tempString=[NSString stringWithFormat:@"%d",[saveData getScore]];
		CCLabelTTF * totalScore=[CCLabelTTF labelWithString:tempString fontName:@"BradyBunch.ttf" fontSize:80];
		[totalScore setColor:ccYELLOW];
		totalScore.position=ccp(ipadWidth/2-300,ipadLength/2+230);
		[self addChild:totalScore z:1 tag:102];
		
	}
	return self;
}

-(void)addButton
{
	
	CCSprite* backSprite=[CCSprite spriteWithFile:@"back.png"];
	CCMenuItemSprite* backButton=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(goMenu)];
	CCMenu* menu=[CCMenu menuWithItems:backButton,nil];
	menu.position=ccp(150,120);
	[self addChild:menu z:0 tag:2];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	startPoint=touchPoint;
	return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	CCMenu* temp=(CCMenu*)[self getChildByTag:1];
	if ((startPoint.x<touchPoint.x)&&(index>0)) {
		
		for (CCMenuItemSprite* child in [temp children] ) {
			[child runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(600,0)]];
		}
		index--;
	}
	else if((startPoint.x>touchPoint.x)&&(index<2)) {
		for (CCMenuItemSprite* child in [temp children] ) {
			[child runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-600,0)]];
		}
		index++;
	}
}

-(void)setLevelOne
{
	level=1;
	[SceneManager goAdventure];
}

-(void)setLevelTwo
{
	level=2;
	[SceneManager goAdventure];
}

-(void)setLevelThree
{
	level=3;
	[SceneManager goAdventure];
}

-(void)goMenu
{
	[SceneManager goMenu];
}

-(void)dealloc
{
	[self removeChildByTag:1 cleanup:YES];
	[self removeChildByTag:2 cleanup:YES];
	[super dealloc];
}

@end
