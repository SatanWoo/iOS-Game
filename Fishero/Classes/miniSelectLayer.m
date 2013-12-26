//
//  miniSelectLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "miniSelectLayer.h"
#import "SceneManager.h"
#import "saveData.h"
#import "BubbleLayer.h"
#import "ActiveBGLayer.h"

@implementation miniSelectLayer

-(id)init
{
	self =[super init];
	if (self) {
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];
		
		index=1;
		CCSprite* sprite1=[CCSprite spriteWithFile:@"fishing.png"];
		CCSprite* sprite2=[CCSprite spriteWithFile:@"match.png"];
		CCSprite* sprite3=[CCSprite spriteWithFile:@"puzzle.png"];
				
		threeStage[0]=[CCMenuItemSprite itemFromNormalSprite:sprite1 selectedSprite:nil target:self selector:@selector(goMiniTwo)];
		threeStage[1]=[CCMenuItemSprite itemFromNormalSprite:sprite2 selectedSprite:nil target:self selector:@selector(goMiniOne)];
		threeStage[2]=[CCMenuItemSprite itemFromNormalSprite:sprite3 selectedSprite:nil target:self selector:@selector(goMiniThree)];
		
		for (int i=0; i<3; i++) {
			if ([saveData getMini:i+1]==0) {
				threeLock[i]=[CCSprite spriteWithFile:@"lock.png"];
				cannotUse[i]=0;
			}
			else
			{
				threeLock[i]=[CCSprite spriteWithFile:@"lock.png"];
				cannotUse[i]=1;
			}
			
		}
		
		
		CCMenu* selectsStage=[CCMenu menuWithItems:threeStage[0],threeStage[1],threeStage[2],nil];
		[selectsStage alignItemsHorizontallyWithPadding:300];
			//selectsStage.anchorPoint=CGPointMake(0,0);
		[self addChild:selectsStage z:1 tag:1];
		
		CCSprite* backSprite=[CCSprite spriteWithFile:@"back.png"];
		CCMenuItemSprite* backButton=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(goMenu)];
		CCMenu* menu=[CCMenu menuWithItems:backButton,nil];
		menu.position=ccp(150,120);
		[self addChild:menu z:1 tag:2];
		int tempIndex=0;
		
		CCMenu* temp=(CCMenu*)[self getChildByTag:1];
		{
			for (CCMenuItemSprite* child in [temp children] ) {
				if (cannotUse[tempIndex]!=1) {
					threeLock[tempIndex].position=ccp(child.position.x+580,340);
					[self addChild:threeLock[tempIndex] z:2];
				}
				tempIndex++;
				
			}
		}
		
		
		
		//The active background and bubbles are added to self
		CCLayer * activeBG = [ActiveBGLayer node];
		[self addChild:activeBG z:0 tag:100];
		
		CCLayer * bubbleLayer = [BubbleLayer node];
		[self addChild:bubbleLayer z:0 tag:101];
		
		
	}
	return self;
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
	int tempIndex=0;
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	CCMenu* temp=(CCMenu*)[self getChildByTag:1];
	if ((startPoint.x<touchPoint.x)&&(index>0)) {
		
		for (CCMenuItemSprite* child in [temp children] ) {
			if (cannotUse[tempIndex]!=1) {
				[threeLock[tempIndex] runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(600,0)]];
				[child runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(600,0)]];
			}
			[child runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(600,0)]];

			tempIndex++;
		}
		index--;
	}
	else if((startPoint.x>touchPoint.x)&&(index<2)) {
		for (CCMenuItemSprite* child in [temp children] ) {
			if (cannotUse[tempIndex]!=1) {
				[threeLock[tempIndex] runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-600,0)]];
				[child runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-600,0)]];
			}
			[child runAction:[CCMoveBy actionWithDuration:0.5f position:ccp(-600,0)]];
			tempIndex++;
		}
		index++;
	}
}

-(void)dealloc
{
	[self removeChildByTag:1 cleanup:YES];
	[self removeChildByTag:2 cleanup:YES];
	[super dealloc];
}

-(void)goMenu
{
	[SceneManager goMenu];
}

-(void)goMiniOne
{
	if (cannotUse[1	]==0) {
		return;
	}
	[SceneManager goMatch];
}

-(void)goMiniThree
{
	if (cannotUse[2]==0) {
		return;
	}
	[SceneManager goPuzzle];
}

-(void)goMiniTwo
{
	if (cannotUse[0]==0) {
		return;
	}
	[SceneManager goFishing];
}

@end
