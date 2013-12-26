//
//  MGFishingUILayer.m
//  MiniGame
//
//  Created by Ye Gabriel on 11-3-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGFishingUILayer.h"
#import "MiniGameFishing.h"
#import "SceneManager.h"
#import "CCMenuItem.h"
#import "PauseLayer.h"
#import "MusicHandle.h"
#import "saveData.h"
#import "GameConfig.h"

@interface MGFishingUILayer (PrivateMethods)

-(void) initContinueOrQuit;
-(void) restartGame:(id)sender;
-(void) quitGame:(id)sender;

@end


@implementation MGFishingUILayer

-(id) init
{
	if ((self = [super init]))
	{	
		isPause = false;
		CCSprite* backSprite1=[CCSprite spriteWithFile:@"back.png"];
		CCMenuItemSprite* backButton1=[CCMenuItemSprite itemFromNormalSprite:backSprite1 selectedSprite:nil target:self selector:@selector(goMenu)];
		CCMenu* menu=[CCMenu menuWithItems:backButton1,nil];
		menu.position=ccp(70,700);
		[self addChild:menu z:2 tag:300];
		
		CCSprite* pauseButton=[CCSprite spriteWithFile:@"pause_1.png"];
		CCMenuItemSprite* pauseMenu=[CCMenuItemSprite itemFromNormalSprite:pauseButton selectedSprite:nil target:self selector:@selector(goPause)];
		CCMenu* menuTwo=[CCMenu menuWithItems:pauseMenu,nil];
		menuTwo.position=ccp(230,700);
		[self addChild:menuTwo z:2
				   tag:301];
	}
	return self;
}

-(void) initContinueOrQuit{
	
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	
	CCSprite * backGroundSprite = [CCSprite spriteWithFile:@"timeup.png"];
	backGroundSprite.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
	[self addChild:backGroundSprite z:0 tag:backgroundTag];
	
	CCSprite * againSprite = [CCSprite spriteWithFile:@"again.png"];
	CCMenuItemSprite * againButton = [CCMenuItemSprite itemFromNormalSprite:againSprite selectedSprite:nil target:self selector:@selector(restartGame:)];	
	CCMenu * againMenu=[CCMenu menuWithItems:againButton,nil];
	againMenu.position=ccp(385,270);
	[self addChild:againMenu z:2 tag:againButtonTag];

	
	CCSprite * backSprite=[CCSprite spriteWithFile:@"back.png"];
	CCMenuItemSprite * backButton=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(quitGame:)];
	CCMenu * backMenu=[CCMenu menuWithItems:backButton,nil];
	backMenu.position=ccp(625,270);
	[self addChild:backMenu z:2 tag:backButtonTag];
	
	int score = [[[MiniGameFishing sharedLayer] gameLayer] getScore];
	int scoreTemp=[saveData getScore];
	scoreTemp+=score;
	[saveData setScore:scoreTemp];
	CCLabelTTF * scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", score]  fontName:@"nevis.ttf" fontSize:25];
	[scoreLabel setColor:ccc3(255, 255, 255)];
	scoreLabel.position = CGPointMake(480, 600);
	scoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
	[self addChild:scoreLabel z:3 tag:scorelabelTag];
	
	

	
	
	self.isTouchEnabled = YES;
	
}

-(void) restartGame:(id)sender{

//	[self cleanup];
	
		//	[self removeAllChildrenWithCleanup:YES];
	
	[self removeChildByTag:scorelabelTag cleanup:YES];
	[self removeChildByTag:backgroundTag cleanup:YES];
	[self removeChildByTag:againButtonTag cleanup:YES];
	[self removeChildByTag:backButtonTag cleanup:YES];
	
	self.isTouchEnabled = FALSE;
	
	[[[MiniGameFishing sharedLayer] gameLayer] resetGame];

}

-(void) quitGame:(id)sender{
	
	[self removeAllChildrenWithCleanup:YES];
	
	//[[[MiniGameFishing sharedLayer] gameLayer] destroyScene];
	
	[SceneManager goMenu];
}

-(void)goMenu
{
	[MusicHandle stopEffect];
	[[CCDirector sharedDirector] resume];
	[SceneManager goMiniGame];
}

-(void)goPause
{
	if(isPause) return;
	isPause = true;
	CCLayer* newLayer=[PauseLayer node];
	[self addChild:newLayer z:5];
	[[CCDirector sharedDirector] pause];
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{	
	return YES;
}

@end
