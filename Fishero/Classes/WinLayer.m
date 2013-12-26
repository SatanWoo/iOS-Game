//
//  WinLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-13.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "WinLayer.h"
#import "GameConfig.h"
#import "MusicHandle.h"
#import "SceneManager.h"


@implementation WinLayer

-(id)init
{
	self =[super init];
	if (self) {
		CCSprite* background=[CCSprite spriteWithFile:@"win.png"];
		background.position=ccp(ipadWidth/2,ipadLength/2);
		[self addChild:background z:0 tag:1];
		
		CCSprite* backSprite=[CCSprite spriteWithFile:@"back.png"];
		CCMenuItemSprite* backButton=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(goMenu)];
		CCMenu* backMenu=[CCMenu menuWithItems:backButton,nil];
		backMenu.position=ccp(350,270);
		[self addChild:backMenu z:1 tag:2];
		
		CCSprite* againSprite=[CCSprite spriteWithFile:@"again.png"];
		CCMenuItemSprite* againButton=[CCMenuItemSprite itemFromNormalSprite:againSprite selectedSprite:nil target:self selector:@selector(goAgain)];
		CCMenu* againMenu=[CCMenu menuWithItems:againButton,nil];
		againMenu.position=ccp(680,270);
		[self addChild:againMenu z:1 tag:3];
		
		
	}
	return self;
}

-(void)dealloc
{
	[self removeChildByTag:1 cleanup:YES ];
	[super dealloc];
}

-(void)goMenu
{
	[MusicHandle stopSound];
	[MusicHandle notifyMenuMusic];
	[SceneManager goMenu];
}

-(void)goAgain
{
	if (selectLayer==0) {
		[SceneManager goEndless];
	}
	else 
	{
		[SceneManager goAdventure];
	}	
}

@end
