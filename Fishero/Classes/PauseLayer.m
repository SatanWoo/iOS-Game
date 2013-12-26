//
//  PauseLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-15.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "PauseLayer.h"
#import "GameConfig.h"


@implementation PauseLayer


-(id)init
{
	self=[super init];
	if (self) {
			//CCSprite* pauseButton=[CCSprite spriteWithFile:@"pause_1.png"];
		CCSprite* resumeButton=[CCSprite spriteWithFile:@"pause_3.png"];
		
			//CCMenuItemSprite* pauseMenu=[CCMenuItemSprite itemFromNormalSprite:pauseButton selectedSprite:nil target:self selector:nil];
		CCMenuItemSprite* resumeMenu=[CCMenuItemSprite itemFromNormalSprite:resumeButton selectedSprite:nil target:self selector:@selector(goResume)];
		
		CCMenu* menu=[CCMenu menuWithItems:resumeMenu,nil];
			//[menu alignItemsVertically];
		menu.position=ccp(ipadWidth/2,ipadLength/2);
		[self addChild:menu z:0 tag:1];
	}
	return self;
}

-(void)dealloc
{
	if ([self getChildByTag:1]!=nil) {
		[self removeChildByTag:1 cleanup:YES];
	}
	
	[super dealloc];
}

-(void)goResume
{
	if(!isPause) return;
	isPause = false;
	[self removeChildByTag:1 cleanup:YES];
	[[CCDirector sharedDirector]resume];
}

@end
