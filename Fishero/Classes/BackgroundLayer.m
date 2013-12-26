//
//  BackgroundLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-13.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "BackgroundLayer.h"
#import "GameConfig.h"

@implementation BackgroundLayer

+(id)scene
{
		// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
		// 'layer' is an autorelease object.
	CCScene *layer = [BackgroundLayer node];
		// add layer as a child to scene
	[scene addChild: layer];
		// return the scene
	return scene;
}

-(id)init
{
	self =[super init];
	if (self) {
		CCSprite* back=[CCSprite spriteWithFile:@"sysMenu.png"];
		back.position=ccp(ipadWidth/2,ipadLength/2);
		[self addChild:back z:0 tag:1];
	}
	return self;
}

-(void)dealloc{
	
	[self removeChildByTag:1 cleanup:YES];

	[super dealloc];
}



@end
