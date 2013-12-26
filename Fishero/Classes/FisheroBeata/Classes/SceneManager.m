//
//  SceneManager.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-6.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "SceneManager.h"
#import "cocos2d.h"
#import "MenuLayer.h"
#import "EndlessLayer.h"
#import "AdventureLayer.h"
#import "SelectLayer.h"
#import "BackgroundLayer.h"
#import "GameBackgroundLayer.h"
#import "MiniGameFishing.h"
#import "miniGameBackLayer.h"
#import "miniSelectLayer.h"
#import "MatchLayer.h"
#import "StoreLayer.h"
#import "PuzzleLayer.h"
#import "HelpLayer.h"


@implementation SceneManager

+(void)goMenu
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[BackgroundLayer node];
	CCScene* newNode=[MenuLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 1 scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goEndless
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
	CCScene* newNode=[EndlessLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}

}

+(void)goAdventure
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[GameBackgroundLayer node];
	CCScene* newNode=[AdventureLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goSelect
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[BackgroundLayer node];
	CCScene* newNode=[SelectLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
	
}

+(void)goBackground
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
	CCScene* newNode=[BackgroundLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
		[director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goMiniGame{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene * newScene =[miniGameBackLayer node];
	CCScene * newNode =[miniSelectLayer node];
		//CCScene * newNode=[MiniGameFishing node];
	[newScene addChild:newNode];
	
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goMatch
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene * newScene =[miniGameBackLayer node];
	CCScene * newNode =[MatchLayer node];
		//CCScene * newNode=[MiniGameFishing node];
	[newScene addChild:newNode];
	
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
	
}

+(void)goStore
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene * newScene =[CCScene node];
	CCScene * newNode =[StoreLayer node];
		//CCScene * newNode=[MiniGameFishing node];
	[newScene addChild:newNode];
	
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goPuzzle
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene * newScene =[BackgroundLayer node];
	CCScene * newNode =[PuzzleLayer node];
		//CCScene * newNode=[MiniGameFishing node];
	[newScene addChild:newNode];
	
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goFishing
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene * newScene=[MiniGameFishing node];
	
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
		//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goHelp
{
	CCDirector* director=[CCDirector sharedDirector];
	CCScene * newScene =[CCScene node];
	CCScene * newNode =[HelpLayer node];
	[newScene addChild:newNode];
	
	if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 1 scene: newScene]];
			//[director replaceScene:[CCTransitionFlipX transitionWithDuration: 0.3f scene: newScene]];
	}
	else {
		[director runWithScene:newScene];		
	}
	
}


@end
