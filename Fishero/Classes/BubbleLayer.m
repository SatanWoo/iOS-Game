//
//  BubbleLayer.m
//  Fishero
//
//  Created by Ye Gabriel on 11-3-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BubbleLayer.h"

@interface BubbleLayer (PrivateMethods)

-(void) bubbleArrived:(id)sender;
-(void) runBubbleMoveSequence:(CCSprite *)bubble and:(CCSprite *)bubble2;
-(void) resetBubbles;
-(void) BubbleUpdate:(ccTime)delta;
@end

@implementation BubbleLayer

-(id) init{
	if ((self = [super init])) {
		Bubbles = [[CCArray alloc] initWithCapacity:BUBBLE_NUM];
		for (int i = 0; i < BUBBLE_NUM; i++) {
			CCSprite * bubble = [CCSprite spriteWithFile:@"paopao1.png"];
			[self addChild:bubble z:2 tag:11];
		
			[Bubbles addObject:bubble];
		}
		
		[self resetBubbles];
	}

	
	return self;
}

-(void) BubbleUpdate:(ccTime)delta{
	
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	for (int i = 0; i < 10; i++) {
		CCSprite * bubble = nil;
		
		int num = CCRANDOM_0_1() * BUBBLE_NUM / 2;
		bubble = [Bubbles objectAtIndex:num];
		if([bubble numberOfRunningActions] != 0)
		{
			continue;
		}
		
		CCSprite * bubble2 = nil;
		bubble2 = [Bubbles objectAtIndex:num + BUBBLE_NUM / 2];
		
		CGPoint pos = CGPointMake(CCRANDOM_0_1() * screenSize.width, -20);
		bubble.position = CGPointMake(pos.x, pos.y);
		bubble2.position = CGPointMake(pos.x + (CCRANDOM_0_1() - .5f) * 20, pos.y - 150);
		
		[self runBubbleMoveSequence:bubble and:bubble2];
		
		CCLOG(@"%d",i);
		break;
	}
}

-(void) runBubbleMoveSequence:(CCSprite *)bubble and:(CCSprite *)bubble2
{
	CGPoint pos = CGPointMake(bubble.position.x, bubble.position.y + CCRANDOM_0_1() * 200 + 600);
	CCMoveBy * move = [CCMoveBy actionWithDuration:8 position:pos];
	
	CCCallFuncN * call = [CCCallFuncN actionWithTarget:self selector:@selector(bubbleArrived:)];
	CCSequence * sequence = [CCSequence actions:move, call, nil];
	
	[bubble runAction:sequence];
	[bubble2 runAction:[[sequence copy] autorelease]];
}

-(void) bubbleArrived:(id)sender{
	NSAssert([sender isKindOfClass:[CCSprite class]], @"sender is not of class CCSprite!");
	CCSprite * bubble = (CCSprite*) sender;
	[bubble stopAllActions];
	bubble.position = CGPointMake(0, -20);
}

-(void) resetBubbles{
	
	for (int i = 0; i < BUBBLE_NUM; i++) {
		CCSprite * bubble = [Bubbles objectAtIndex:i];
		
		bubble.position = CGPointMake(0, -20);
		[bubble stopAllActions];
	}
	
	[self unschedule:@selector(BubbleUpdate:)];
	
	[self schedule:@selector(BubbleUpdate:) interval:.8f];
	
}

@end
