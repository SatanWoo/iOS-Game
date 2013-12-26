//
//  MiniGameFishing.m
//  MiniGame
//
//  Created by Ye Gabriel on 11-3-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MiniGameFishing.h"
#import "MGFishingGameLayer.h"
#import "MGFishingUILayer.h"


@implementation MiniGameFishing

static MiniGameFishing * MiniGameFishingInstance;

+(MiniGameFishing *) sharedLayer{
	NSAssert(MiniGameFishingInstance != nil, @"MiniGameFishing not available!");
	return MiniGameFishingInstance;
}

-(MGFishingGameLayer*) gameLayer{
	CCNode* layer = [self getChildByTag:LayerTagGameLayer];
	NSAssert([layer isKindOfClass:[MGFishingGameLayer class]], @"%@: not a GameLayer!", NSStringFromSelector(_cmd));
	return (MGFishingGameLayer*)layer;
}

-(MGFishingUILayer*) uiLayer{
	CCNode* layer = [[MiniGameFishing sharedLayer] getChildByTag:LayerTagUILayer];
	NSAssert([layer isKindOfClass:[MGFishingUILayer class]], @"%@: not a UserInterfaceLayer!", NSStringFromSelector(_cmd));
	return (MGFishingUILayer*)layer;
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

+(id) scene{
	CCScene* scene = [CCScene node];
	MiniGameFishing* layer = [MiniGameFishing node];
	[scene addChild:layer];
	return scene;
}

-(id) init{
	if ((self = [super init])) {
		NSAssert(MiniGameFishingInstance == nil, @"another MiniGameFishing is already in use!");
		MiniGameFishingInstance = self;
		
		MGFishingGameLayer * game = [MGFishingGameLayer node];
		[self addChild:game z:1 tag:LayerTagGameLayer];
		
		MGFishingUILayer * ui = [MGFishingUILayer node];
		[self addChild:ui z:2 tag:LayerTagUILayer];
	}
	
	return self;
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	MiniGameFishingInstance = nil;
	
	[super dealloc];
}

@end
