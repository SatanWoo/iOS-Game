//
//  GameBackgroundLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-13.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "GameBackgroundLayer.h"
#import "GameConfig.h"


@implementation GameBackgroundLayer

-(id)init
{
	self =[super init];
	if (self) {
		NSString* stringTemp=[NSString stringWithFormat:@"gameBack%d.png",level];
		CCSprite* background=[CCSprite spriteWithFile:stringTemp];
		background.position=ccp(ipadWidth/2,ipadLength/2);
		[self addChild:background z:0 tag:1];
	}
	return self;
}

-(void)dealloc
{
	[self removeChildByTag:1 cleanup:YES];
	[super dealloc];
}

@end
