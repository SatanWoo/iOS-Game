//
//  miniGameBackLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "miniGameBackLayer.h"
#import "GameConfig.h"

@implementation miniGameBackLayer

-(id)init
{
	self =[super init];
	if (self) {
		CCSprite* background=[CCSprite spriteWithFile:@"miniGameBack.png"];
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
