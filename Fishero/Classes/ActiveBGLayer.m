//
//  ActiveBGLayer.m
//  Fishero
//
//  Created by Ye Gabriel on 11-3-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 
#import "ActiveBGLayer.h"

@interface ActiveBGLayer (PrivateMethods)

-(void) resetFishes;
-(void) FishOutScreen:(id)sender;
-(void) update:(ccTime)delta;
-(void) runFishesMoveSequence:(CCSprite *)fish withDuration:(float)duration andDirection:(FishDirection)direction;

@end


@implementation ActiveBGLayer

-(id) init{
	if ((self = [super init])) {
		MovingFishes = [[CCArray alloc] initWithCapacity:10];
		
		CCSprite * fish1;
		CCSprite * fish2;
		CCSprite * fish3;
		CCSprite * fish4;
		CCSprite * fish5;
		CCSprite * fish6;
		CCSprite * fish7;
		CCSprite * fish8;
		CCSprite * fish9;
		CCSprite * fish10;
		
		fish1 = [CCSprite spriteWithFile:@"fish1.png"];
		fish2 = [CCSprite spriteWithFile:@"fish2.png"];
		fish3 = [CCSprite spriteWithFile:@"fish3.png"];
		fish4 = [CCSprite spriteWithFile:@"fish4.png"];
		fish5 = [CCSprite spriteWithFile:@"fish5.png"];
		fish6 = [CCSprite spriteWithFile:@"fish6.png"];
		fish7 = [CCSprite spriteWithFile:@"fish7.png"];
		fish8 = [CCSprite spriteWithFile:@"fish8.png"];
		fish9 = [CCSprite spriteWithFile:@"fish9.png"];
		fish10 = [CCSprite spriteWithFile:@"fish10.png"];
		
		[self addChild:fish1 z:0 tag:1];
		[self addChild:fish2 z:0 tag:2];
		[self addChild:fish3 z:0 tag:3];
		[self addChild:fish4 z:0 tag:4];
		[self addChild:fish5 z:0 tag:5];
		[self addChild:fish6 z:0 tag:6];
		[self addChild:fish7 z:0 tag:7];
		[self addChild:fish8 z:0 tag:8];
		[self addChild:fish9 z:0 tag:9];
		[self addChild:fish10 z:0 tag:10];
		
		[MovingFishes addObject:fish1];
		[MovingFishes addObject:fish2];
		[MovingFishes addObject:fish3];
		[MovingFishes addObject:fish4];
		[MovingFishes addObject:fish5];
		[MovingFishes addObject:fish6];
		[MovingFishes addObject:fish7];
		[MovingFishes addObject:fish8];
		[MovingFishes addObject:fish9];
		[MovingFishes addObject:fish10];

		[self resetFishes];
		
		[self schedule:@selector(update:) interval:1];
	}
	return self;
}

-(void) update:(ccTime)delta{
	
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	for (int i = 0; i < 10; i++) {
		CCSprite * fish = nil;
		FishDirection direction;
		
		fish = [MovingFishes objectAtIndex:CCRANDOM_0_1() * 10];
		if ([fish numberOfRunningActions] != 0) {
			continue;
		}
		
		float duration = (CCRANDOM_0_1() - .5) * 10 + 10;
		
		CGSize imageSize = [fish texture].contentSize;
		
		if (CCRANDOM_0_1() > .5) {
			fish.position = CGPointMake(-imageSize.width, CCRANDOM_0_1() * 500 + 100);
			fish.scaleX = .4;
			fish.scaleY = .4;
			direction = right;
		}
		else {
			fish.position = CGPointMake(screenSize.width + imageSize.width, CCRANDOM_0_1() * 500 + 100);
			fish.scaleX = -.4;
			fish.scaleY = .4;
			direction = left;
		}
		
		[self runFishesMoveSequence:fish withDuration:duration andDirection:direction];
		
		break;
		
	}

}

-(void) runFishesMoveSequence:(CCSprite *)fish withDuration:(float)duration andDirection:(FishDirection)direction{
	CGPoint outScreenPosition;
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	
	if (direction == right) {
		outScreenPosition = CGPointMake(screenSize.width + [fish texture].contentSize.width, fish.position.y);
	}
	else {
		outScreenPosition = CGPointMake(-[fish texture].contentSize.width, fish.position.y);
	}
	
	CCMoveTo * move = [CCMoveTo actionWithDuration:duration position:outScreenPosition];
	CCCallFuncN * call = [CCCallFuncN actionWithTarget:self selector:@selector(FishOutScreen:)];
	CCSequence * sequence = [CCSequence actions:move, call, nil];
	
	[fish runAction:sequence];
}

-(void) resetFishes{
	for (int i = 0; i < 10; i++) {
		CCSprite * fish = [MovingFishes objectAtIndex:i];
		fish.position = CGPointMake(-200,-200);
		[fish stopAllActions];
	}
}

-(void) FishOutScreen:(id)sender{
	NSAssert([sender isKindOfClass:[CCSprite class]], @"sender is not of class CCSprite!");
	CCSprite * fish = (CCSprite*) sender;
	
	[fish stopAllActions];
	
	fish.position = CGPointMake(-100, 0);
}

-(void) dealloc{
	
	[super dealloc];
}

@end
