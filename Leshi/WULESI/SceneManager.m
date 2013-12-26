//
//  SceneManager.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-11.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import "SceneManager.h"
#import "MenuLayer.h"
#import "PickLayer.h"
#import "ScoreScene.h"
#import "Boat.h"
#import "Boatbackground.h"
#import "ItemLayer.h"
#import "LoadingLesi.h"
#import "LoadingPepsi.h"

@implementation SceneManager

+(void)goMenu
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
	CCLayer* newNode=[MenuLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:newScene];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goPickGame
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
	CCLayer* newNode=[PickLayer node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:newScene];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+(void)goshowScore
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
	CCLayer* newNode=[ScoreScene node];
	[newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:newScene];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+ (void)goShip
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
    CCLayer* gameNode = [Boat node];
    CCLayer* itemNode = [ItemLayer node];
	CCLayer* newNode=[Boatbackground node];
	[newScene addChild:newNode z:0];
    [newScene addChild:itemNode z:2];
    [newScene addChild:gameNode z:1];
	if ([director runningScene]) {
        [director replaceScene:newScene];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+ (void)goLoadingPepsi
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
    CCLayer* newNode = [LoadingPepsi node];
    [newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:newScene];
	}
	else {
		[director runWithScene:newScene];		
	}
}

+ (void)goLoadingLesi
{
    CCDirector* director=[CCDirector sharedDirector];
	CCScene* newScene=[CCScene node];
    CCLayer* newNode = [LoadingLesi node];
    [newScene addChild:newNode];
	if ([director runningScene]) {
        [director replaceScene:newScene];
	}
	else {
		[director runWithScene:newScene];		
	}
}

@end
