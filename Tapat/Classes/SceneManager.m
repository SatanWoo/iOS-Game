//
//  SceneManager.m
//  tapat
//
//  Created by 吴 wuziqi on 11-1-24.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "SceneManager.h"
#import "about.h"
#import "setting.h"
#import "gameLayer.h"
#import "gameBackground.h"
#import "classical.h"
#import "sysMenu.h"
#import "highScore.h"
#import "SelectLevel.h"
#import "winLayer.h"
#import "loseLayer.h"
#import "gameOver.h"
#import "cocos2d.h"
#import "loadingLayer.h"
#import "musiceHandle.h"

@implementation SceneManager

+(void)goMenu:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
	CCScene* newNode=[sysMenu node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
			[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goAbout:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director =[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[about node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionShrinkGrow transitionWithDuration:0.3f scene:newScene]];
	}
	else {
		[director runWithScene:newScene];
	}
}

+(void)goOptions:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director =[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[setting node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionMoveInR transitionWithDuration:1.0f scene:newScene]];
	}
	else {
		[director runWithScene:newScene];
	}
}

+(void)goAdventure:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director =[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[SelectLevel node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionJumpZoom transitionWithDuration:0.8f scene:newScene]];
	}
	else {
		[director runWithScene:newScene];
	}
}

+(void)goClassical:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director =[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* background = [gameBackground node];
	CCScene* gamelayer = [classical node];
	[newScene addChild:background];
	[newScene addChild:gamelayer];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionJumpZoom transitionWithDuration:0.8f scene:newScene]];
	}
	else {
		[director runWithScene:newScene];
	}
}

+(void)goHighScore:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[highScore node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionSlideInR transitionWithDuration:1.0f scene:newScene]];
	}
	else
	{
		[director runWithScene:newScene];
	}
}

+(void)goWin:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[winLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionSlideInR transitionWithDuration:1.0f scene:newScene]];
	}
	else
	{
		[director runWithScene:newScene];
	}
}

+(void)goLose:(id)sender
{
	[musiceHandle notifySoundOfMice];
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[loseLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionSlideInR transitionWithDuration:1.0f scene:newScene]];
	}
	else
	{
		[director runWithScene:newScene];
	}
}

+(void)goGameOver:(id)sender
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene =[CCScene node];
	CCScene* newNode=[gameOver node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionSlideInR transitionWithDuration:1.0f scene:newScene]];
	}
	else
	{
		[director runWithScene:newScene];
	}
}

+(void)goLoading:(id)sender
{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene=[CCScene node];
    CCScene* newNode=[loadingLayer node];
    [newScene addChild:newNode];
    if([director runningScene])
    {
        [director replaceScene:[CCTransitionFadeUp transitionWithDuration:1.0f scene:newScene]];
    }
    else
    {
        [director runWithScene:newScene];
    }
    
}


@end
