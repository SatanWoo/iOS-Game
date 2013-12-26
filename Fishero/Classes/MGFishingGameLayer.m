//
//  MGFishingGameLayer.m
//  MiniGame
//
//  Created by Ye Gabriel on 11-3-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "MGFishingGameLayer.h"
#import "MiniGameFishing.h"
#import "SimpleAudioEngine.h"
#import "MusicHandle.h"
#import "Math.h"

@interface MGFishingGameLayer (PrivateMethods)
-(void) addRandomThings;

-(void) initFishes;
-(void) resetFishes;
-(void) FishesUpdate:(ccTime)delta;
-(void) runFishesMoveSequence:(CCSprite*) fish withDuration:(float)duration andDirection:(FishDirection)direction;
-(void) FishOutScreen:(id)sender;
-(void) CatchedFishRefresh:(id)sender;
-(void) checkForCollision;
-(void) showGameOver;
-(void) resetGame;
-(void) pauseGame;
-(void) endGame;
-(void) retrieveHook;
-(void) retrieveFish;
-(bool) checkOutBound;
-(void) hookRetrieved:(id)sender;
-(void) hookReadyAnimation;
-(void) setFishPosition:(CCSprite *) fish;
-(void) destroyScene;
-(void) autoClean;
-(int) getScore;
-(void) initBubbles;
-(void) resetBubbles;
-(void) BubbleUpdate:(ccTime)delta;
-(void) runBubbleMoveSequence:(CCSprite *)bubble and:(CCSprite *)bubble2;
-(void) bubbleArrived:(id)sender;
-(void) initBombs;
-(void) resetBombs;
-(void) initRubbish;
-(void) resetRubbish;
@end


@implementation MGFishingGameLayer

-(id) init{
	if ((self = [super init])){
		self.isTouchEnabled = YES;
		hookReady = TRUE;
		hookLaunched = FALSE;
		
		curScore = 0;
		lastScore = 0;
		
		fishCatchedOrNot = uncatched;
		
		gameLayerPosition = self.position;
		

		screenSize = [[CCDirector sharedDirector] winSize];
		playerPos = CGPointMake(screenSize.width / 2 - 40, screenSize.height - 30);
		
		gameBackground = [CCSprite spriteWithFile:@"MGFbackground.png"];
		gameBackground.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
		[self addChild:gameBackground z:-1 tag:bgTag];
		
		
		hookSprite = [CCSprite spriteWithFile:@"MGHook.png"];
		hookSprite.anchorPoint = CGPointMake(.5f, .8f);
		hookCollisionRadius = [hookSprite texture].contentSize.width * COLLISION_SCALE;
		
		[self addChild:hookSprite z:1 tag:hookTag];
		
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"FishingSound1.mp3"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"tick.mp3"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"explosion.mp3"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:@"badsmile.mp3"];
		
		
		[self hookReadyAnimation];
		
		scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", curScore] fontName:@"nevis.ttf" fontSize:25];
		[scoreLabel setColor:ccc3(0, 0, 0)];
		scoreLabel.position = CGPointMake(760, 720);
		scoreLabel.anchorPoint = CGPointMake(0.5f, 1.0f);
		[self addChild:scoreLabel z:labelTag];
		
		[self initFishes];
		
		[self initBubbles];
		
		[self initBombs];
		
		[self initRubbish];
		
		[self scheduleUpdate];

	}
	
	return self;
}

-(void) update:(ccTime)delta
{	
	if(hookReady)
	{
		if ([self checkOutBound]) {
		
			hookReady = FALSE;

			[self retrieveHook];
		}	
	}
	
	if (fishCatchedOrNot == catched) {
		[self retrieveFish];
	}
	else if(fishCatchedOrNot == uncatched && hookSprite.position.y < playerPos.y){
		[self checkForCollision];
	}

	totalTime += delta;
	
	CCLOG(@"%f",totalTime);
	
	if(totalTime - timeTemp * 10 > 0)
	{
		timeTemp++;
		if (CCRANDOM_0_1() > .30f) {
			for (int i = 0; i < RUBBISH_NUM; i++) {
				CCSprite * litter = [Rubbish objectAtIndex:i];
				if ([litter numberOfRunningActions] == 0) {
					litter.position = CGPointMake(CCRANDOM_0_1() * 800, CCRANDOM_0_1() * 600);
					CCMoveBy * move = [CCMoveBy actionWithDuration:80 position:ccp((CCRANDOM_0_1() - .5) * 1500 + 750 , (CCRANDOM_0_1() - .5) * 1500 - 750)];
					[litter runAction:move];
					break;
				}	
			}
		}
	}
	
	if (totalTime >= TIME_LIMIT) {
		
	
		[self pauseGame];
		
		//[self resetGame];
	}
	else if((totalTime > TIME_LIMIT * 2 / 3 && totalTime <= TIME_LIMIT * 2 / 3 + delta) || (totalTime > TIME_LIMIT / 3 && totalTime <= TIME_LIMIT / 3 + delta) 
			|| (totalTime > TIME_LIMIT - 5 && totalTime <= TIME_LIMIT - 5 + delta)){
		
		CCSprite * timeSprite;
		
		if(totalTime < TIME_LIMIT * 2 / 3){
			timeSprite = [CCSprite spriteWithFile:@"1min.png"];
			[self addChild:timeSprite z:5 tag:timewarning1];
		}
		else if(totalTime < TIME_LIMIT - 5){
			
			timeSprite = [CCSprite spriteWithFile:@"30secs.png"];
			[self addChild:timeSprite z:5 tag:timewarning2];
		}
		else {
			 [[SimpleAudioEngine sharedEngine]playEffect:@"tick.mp3"];
			
			timeSprite = [CCSprite spriteWithFile:@"5secs.png"];				//需要换成还剩5秒！！！！！！！！！！！！！！！！！！！！！！！！！！！
			[self addChild:timeSprite z:5 tag:timewarning2];
		}
		
		timeSprite.position = CGPointMake(screenSize.width + timeSprite.contentSize.width / 2, screenSize.height / 2);
		
		id delay = [CCDelayTime actionWithDuration:1];
		id move = [CCMoveTo actionWithDuration:1 position:ccp(screenSize.width / 2, screenSize.height / 2)];
		id move2 = [CCMoveTo actionWithDuration:1 position:ccp(- timeSprite.contentSize.width / 2, screenSize.height / 2)];
		id move_ease1 = [CCEaseBounceInOut actionWithAction:[[move copy] autorelease]];
		
		CCCallFuncN * call = [CCCallFuncN actionWithTarget:self selector:@selector(autoClean)];
		id seq = [CCSequence actions:move_ease1,delay,move2,call,nil];
		
		[timeSprite runAction:seq];
		
	}
}

-(void) autoClean{
	[self removeChildByTag:timewarning1 cleanup:YES];
	[self removeChildByTag:timewarning2 cleanup:YES];
}

-(bool) checkOutBound{
	
	CGPoint pos = hookSprite.position;
	if (pos.x < 20 || pos.y < 20 || pos.x > screenSize.width - 20) {
		return TRUE;
	}
	return FALSE;
}

-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	[super dealloc];
}

-(void) initFishes{
	
	NSAssert(SFishes == nil, @"%@: Fishes array is already initialized!", NSStringFromSelector(_cmd));
	SFishes = [[CCArray alloc] initWithCapacity:SF_NUM];
	MFishes = [[CCArray alloc] initWithCapacity:MF_NUM];
	LFishes = [[CCArray alloc] initWithCapacity:LF_NUM];
	
	
	for (int i = 0; i < SF_NUM; i++) {
		CCSprite * fish;
		if (CCRANDOM_0_1() > .5) {
			fish = [CCSprite spriteWithFile:@"MGFish1.png"];
		}
		else {
			fish = [CCSprite spriteWithFile:@"MGFish5.png"];
		}
		
		[self addChild:fish z:4 tag:smallfishTag];
		
		sfCollisionRadius = [fish texture].contentSize.width * COLLISION_SCALE;
		
		[SFishes addObject:fish];
	}
	
	for (int i = 0; i < MF_NUM; i++) {
		CCSprite * fish;
		if (CCRANDOM_0_1() > .5) {
			fish = [CCSprite spriteWithFile:@"MGFish2.png"];
		}
		else {
			fish = [CCSprite spriteWithFile:@"MGFish4.png"];
		}
		
		//CCSprite * fish = [CCSprite spriteWithFile:@"MGFish2.png"];
		[self addChild:fish z:3 tag:midfishTag];
		
		mfCollisionRadius = [fish texture].contentSize.width * COLLISION_SCALE;
		
		[MFishes addObject:fish];
	}
	
	for (int i = 0; i < LF_NUM; i++) {
		CCSprite * fish;
		if (CCRANDOM_0_1() > .5) {
			fish = [CCSprite spriteWithFile:@"MGFish3.png"];
		}
		else {
			fish = [CCSprite spriteWithFile:@"MGFish6.png"];
		}
		
		//CCSprite * fish = [CCSprite spriteWithFile:@"MGFish3.png"];
		[self addChild:fish z:1 tag:largefishTag];
		
		lfCollisionRadius = [fish texture].contentSize.width * COLLISION_SCALE;
		
		[LFishes addObject:fish];
	}
	
	[self resetFishes];
}

-(void) initBubbles{
	NSAssert(Bubbles == nil, @"%@: Fishes array is already initialized!", NSStringFromSelector(_cmd));
	Bubbles = [[CCArray alloc] initWithCapacity:BUBBLE_NUM];
	
	for (int i = 0; i < BUBBLE_NUM; i++) {
		CCSprite * bubble = [CCSprite spriteWithFile:@"paopao1.png"];
		[self addChild:bubble z:2 tag:bubbleTag];
		
		[Bubbles addObject:bubble];
		
	}
	
	[self resetBubbles];
}

-(void) initBombs{
	NSAssert(Bombs == nil, @"%@: Fishes array is already initialized!", NSStringFromSelector(_cmd));
	Bombs = [[CCArray alloc] initWithCapacity:BOMB_NUM];
	
	for (int i = 0; i < BOMB_NUM; i++) {
		CCSprite * bomb = [CCSprite spriteWithFile:@"MGbomb.png"];
		[self addChild:bomb z:1 tag:bombTag];
		
		bombCollisionRadius = [bomb texture].contentSize.width * COLLISION_SCALE;
		
		bomb.position = CGPointMake(-40, -40);
		[Bombs addObject:bomb];
	}
}

-(void) initRubbish{
	NSAssert(Rubbish == nil, @"%@: Fishes array is already initialized!", NSStringFromSelector(_cmd));
	Rubbish = [[CCArray alloc] initWithCapacity:RUBBISH_NUM];
	
	for (int i = 0; i < RUBBISH_NUM; i++) {
		CCSprite * litter;
		if (i % 4 == 0) {
			litter = [CCSprite spriteWithFile:@"MGR1.png"];
		}
		else if(i % 4 == 1){
			litter = [CCSprite spriteWithFile:@"MGR2.png"];
		}
		else if(i % 4 == 2){
			litter = [CCSprite spriteWithFile:@"MGR3.png"];
		}
		else {
			litter = [CCSprite spriteWithFile:@"MGR4.png"];
		}

		
		[self addChild:litter z:1 tag:rubbishTag];
		
		rubbishCollisionRadius = [litter texture].contentSize.width * COLLISION_SCALE;
		
		litter.position = CGPointMake(-40, -40);
		[Rubbish addObject:litter];
	}
}

-(void) resetRubbish{
	for (int i = 0; i < RUBBISH_NUM; i++) {
		CCSprite * litter = [Rubbish objectAtIndex:i];
		
		litter.position = CGPointMake(-40, -40);
		[litter stopAllActions];		
	}
}


-(void) resetBombs{
	for (int i = 0; i < BOMB_NUM; i++) {
		CCSprite * bomb = [Bombs objectAtIndex:i];
		
		bomb.position = CGPointMake(-40, -40);
		[bomb stopAllActions];
		
	}
}

-(void) resetBubbles{

	for (int i = 0; i < BUBBLE_NUM; i++) {
		CCSprite * bubble = [Bubbles objectAtIndex:i];

		bubble.position = CGPointMake(0,-20);
		[bubble stopAllActions];
	}
	
	[self unschedule:@selector(BubbleUpdate:)];
	
	[self schedule:@selector(BubbleUpdate:) interval:1];
	
}

-(void) BubbleUpdate:(ccTime)delta{
	
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
		bubble2.position = CGPointMake(pos.x + (CCRANDOM_0_1() - .5f) * 20, pos.y - 50);
		
		[self runBubbleMoveSequence:bubble and:bubble2];
	}
}


-(void) runBubbleMoveSequence:(CCSprite *)bubble and:(CCSprite *)bubble2
{
	CGPoint pos = CGPointMake(bubble.position.x, bubble.position.y + CCRANDOM_0_1() * 200 + 400);
	CCMoveBy * move = [CCMoveBy actionWithDuration:7 position:pos];
	
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

-(void) resetFishes{
	for (int i = 0; i < SF_NUM; i++) {
		CCSprite * fish = [SFishes objectAtIndex:i];
		fish.position = CGPointMake(-100, 0);
		[fish stopAllActions];
	}
	
	for (int i = 0; i < MF_NUM; i++) {
		CCSprite * fish = [MFishes objectAtIndex:i];
		fish.position = CGPointMake(-100, 0);
		[fish stopAllActions];
	}
	
	for (int i = 0; i < LF_NUM; i++) {
		CCSprite * fish = [LFishes objectAtIndex:i];
		fish.position = CGPointMake(-100, 0);
		[fish stopAllActions];
	}
	
	[self unschedule:@selector(FishesUpdate:)];
	
	[self schedule:@selector(FishesUpdate:) interval:0.6f];
	
}

-(void) FishesUpdate:(ccTime)delta{
	for(int i = 0; i < 10; i++){
		
		CCSprite * fish = nil;
		float duration;
		
		FishDirection direction;
		
		if (i % 3 == 0) {
			
			fish = [SFishes objectAtIndex:CCRANDOM_0_1() * SF_NUM];
			if ([fish numberOfRunningActions] != 0) {
				continue;
			}
			
			duration = SF_DURATION;
			
			CGSize imageSize = [fish texture].contentSize;
			
			if (CCRANDOM_0_1() > .5) {
				fish.position = CGPointMake(-imageSize.width, CCRANDOM_0_1() * 300 + 300);
				fish.scaleX = -1.3;
				fish.scaleY = 1.3;
				direction = right;
			}
			else {
				fish.position = CGPointMake(screenSize.width + imageSize.width, CCRANDOM_0_1() * 300 + 250);
				fish.scaleX = 1.3;
				fish.scaleY = 1.3;
				direction = left;
			}
		}
		else if(i % 3 == 1){
			fish = [MFishes objectAtIndex:CCRANDOM_0_1() * MF_NUM];
			if ([fish numberOfRunningActions] != 0) {
				continue;
			}
			
			duration = MF_DURATION;
			
			CGSize imageSize = [fish texture].contentSize;
			
			if (CCRANDOM_0_1() > .5) {
				fish.position = CGPointMake(-imageSize.width, CCRANDOM_0_1() * 200 + 100);
				fish.scaleX = 1.5;
				fish.scaleY = 1.5;
				direction = right;
			}
			else {
				fish.position = CGPointMake(screenSize.width + imageSize.width, CCRANDOM_0_1() * 200 + 150);
				fish.scaleX = -1.5;
				fish.scaleY = 1.5;
				direction = left;
			}
		}
		else {
			fish = [LFishes objectAtIndex:CCRANDOM_0_1() * LF_NUM];
			if ([fish numberOfRunningActions] != 0) {
				continue;
			}
			
			duration = LF_DURATION;
			
			CGSize imageSize = [fish texture].contentSize;
			
			if (CCRANDOM_0_1() > .5) {
				fish.position = CGPointMake(-imageSize.width, CCRANDOM_0_1() * 100 + 50);
				fish.scaleX = -2.3;
				fish.scaleY = 2.3;
				direction = right;
			}
			else {
				fish.position = CGPointMake(screenSize.width + imageSize.width, CCRANDOM_0_1() * 200 + 50);
				fish.scaleX = 2.3;
				fish.scaleY = 2.3;
				direction = left;
			}
		}
		
		CCLOG(@"Dropping a Fish after %i retries.", i);
			
		[self runFishesMoveSequence:fish withDuration:duration andDirection:direction];
			
		break;
	}
}

-(void) runFishesMoveSequence:(CCSprite *)fish withDuration:(float)duration andDirection:(FishDirection)direction{
	
	CGPoint outScreenPosition;
	
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

-(void) FishOutScreen:(id)sender{
	NSAssert([sender isKindOfClass:[CCSprite class]], @"sender is not of class CCSprite!");
	CCSprite * fish = (CCSprite*) sender;
	
	[fish stopAllActions];
	
	fish.position = CGPointMake(-100, 0);
	
//	[self setFishPosition:fish];
}

-(void) CatchedFishRefresh:(id)sender{
	NSAssert([sender isKindOfClass:[CCSprite class]], @"sender is not of class CCSprite!");
	CCSprite * fish = (CCSprite*) sender;
	
	if ([SFishes containsObject:fish]) {
		curScore += SSCORE;
		[[SimpleAudioEngine sharedEngine] playEffect:@"FishingSound1.mp3"];
	}
	else if([MFishes containsObject:fish]){
		curScore += MSCORE;
		[[SimpleAudioEngine sharedEngine] playEffect:@"FishingSound1.mp3"];
	}
	else if([LFishes containsObject:fish]){
		curScore += LSCORE;
		[[SimpleAudioEngine sharedEngine] playEffect:@"FishingSound1.mp3"];
	}
	else if([Bombs containsObject:fish]){
		curScore -= 10;
		lastScore -= 10;
		if (curScore < 0) {
			curScore = 0;
		}
		[[SimpleAudioEngine sharedEngine] playEffect:@"explosion.mp3"];
	}
	else if([Rubbish containsObject:fish]){
		[[SimpleAudioEngine sharedEngine] playEffect:@"badsmile.mp3"];
	}

	
	[scoreLabel setString:[NSString stringWithFormat:@"%d", curScore]];
	
	
	[fish stopAllActions];
	
	fish.position = CGPointMake(-100, 0);
	
	if(curScore > lastScore + 6){
		lastScore = curScore;
		for (int i = 0; i < BOMB_NUM; i++) {
			CCSprite * bomb = [Bombs objectAtIndex:i];
			if ([bomb numberOfRunningActions] == 0) {
				bomb.position = CGPointMake(CCRANDOM_0_1() * 600 + 200, CCRANDOM_0_1() * 400 + 200);
				CCMoveBy * move = [CCMoveBy actionWithDuration:80 position:ccp((CCRANDOM_0_1() - .5) * 1500 + 750 , (CCRANDOM_0_1() - .5) * 1500 - 750)];
				[bomb runAction:move];
				break;
			}	
		}
	}
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch*)touch withEvent:(UIEvent *)event
{	
	return YES;
}

-(void) ccTouchEnded:(UITouch*)touch withEvent:(UIEvent *)event
{
	if (!hookLaunched) {
		hookLaunched = TRUE;
		
		[hookSprite stopAllActions];
		
		float curRotation = hookSprite.rotation;
		
		double degreesToRadians = 2 * M_PI / 360 * curRotation;
		
		float dx = sin(degreesToRadians);
		float dy = cos(degreesToRadians);
		
		CGPoint temp = CGPointMake(- dx * DOWN_SPEED, - dy * DOWN_SPEED);
		CCMoveBy * move = [CCMoveBy actionWithDuration:HOOKDOWN_DURATION position:temp];
		[hookSprite runAction:move];
		CCLOG(@"TOUCHED AND LAUNCHED!!!");
	}
}


-(void) checkForCollision{
	
	CCSprite * fish;
	CGPoint startPosition = [hookSprite position];
	CGPoint endPosition = playerPos;
	
	float maxCollisionDistance = hookCollisionRadius + bombCollisionRadius;
	
	for(int i = 0;i < BOMB_NUM;++i)
	{
		fish = [Bombs objectAtIndex:i];
		
		if([fish numberOfRunningActions] == 0)
		{
			continue;
		}
		
		float actualDistance = ccpDistance(hookSprite.position, fish.position);
		if (actualDistance < maxCollisionDistance )
		{
			goto NORMAL;
		}
	}
	
	maxCollisionDistance = hookCollisionRadius + rubbishCollisionRadius;
	
	for(int i = 0;i < RUBBISH_NUM;++i)
	{
		fish = [Rubbish objectAtIndex:i];
		
		if([fish numberOfRunningActions] == 0)
		{
			continue;
		}
		
		float actualDistance = ccpDistance(hookSprite.position, fish.position);
		if (actualDistance < maxCollisionDistance )
		{
			goto SLOW;
		}
	}
	
	maxCollisionDistance = hookCollisionRadius + sfCollisionRadius;
	
	for (int i = 0; i < SF_NUM; i++)
	{
		fish = [SFishes objectAtIndex:i];
		
		if ([fish numberOfRunningActions] == 0)
		{
			continue;
		}
		
		float actualDistance = ccpDistance(hookSprite.position, fish.position);
		
		if (actualDistance < maxCollisionDistance )
		{
			goto NORMAL;
		}
	}
	
	maxCollisionDistance = hookCollisionRadius + mfCollisionRadius;
	
	for (int i = 0; i < MF_NUM; i++)
	{
		fish = [MFishes objectAtIndex:i];
		
		if ([fish numberOfRunningActions] == 0)
		{
			continue;
		}
		
		float actualDistance = ccpDistance(hookSprite.position, fish.position);
		
		if (actualDistance < maxCollisionDistance )
		{
			goto NORMAL;
		}
	}
	
	maxCollisionDistance = hookCollisionRadius + lfCollisionRadius;
	
	for (int i = 0; i < LF_NUM; i++)
	{
		fish = [LFishes objectAtIndex:i];
		
		if ([fish numberOfRunningActions] == 0)
		{
			continue;
		}
		
		float actualDistance = ccpDistance(hookSprite.position, fish.position);
		
		if (actualDistance < maxCollisionDistance )
		{
			goto NORMAL;
		}
	}
	
	return;
	
NORMAL:
	retrieveSpeed = ccpDistance(startPosition, endPosition) / UP_SPEED;
	goto ANIMATION;
SLOW:
	retrieveSpeed = ccpDistance(startPosition, endPosition) / DRAGGED_UPSPEED;
	goto ANIMATION;

ANIMATION:
	fishCatchedOrNot = catched;
	
	[fish stopAllActions];
	CCMoveTo * move = [CCMoveTo actionWithDuration:retrieveSpeed position:playerPos];
	CCJumpTo * jump = [CCJumpTo actionWithDuration:.6f position:ccp(playerPos.x + 150, playerPos.y - 30) height:50 jumps:1];
	CCCallFuncN * call = [CCCallFuncN actionWithTarget:self selector:@selector(CatchedFishRefresh:)];
	CCSequence * sequence = [CCSequence actions:move, jump, call, nil];
	[fish runAction:sequence];
	
	return;
}

-(void) hookRetrieved:(id)sender{
	
	NSAssert([sender isKindOfClass:[CCSprite class]], @"sender is not of class CCSprite!");
	hookReady = TRUE;
	hookLaunched = FALSE;
	fishCatchedOrNot = uncatched;
	[self hookReadyAnimation];
}

-(void) retrieveHook{
	fishCatchedOrNot = retrieving;
	
	[hookSprite stopAllActions];
	CCMoveTo * move = [CCMoveTo actionWithDuration:FISHUP_DURATION position:playerPos];
	CCCallFuncN * call = [CCCallFuncN actionWithTarget:self selector:@selector(hookRetrieved:)];
	CCSequence * sequence = [CCSequence actions:move ,call , nil];
	[hookSprite runAction:sequence];
}

-(void) retrieveFish{
	
	fishCatchedOrNot = retrieving;
	
	[hookSprite stopAllActions];
	CCMoveTo * move = [CCMoveTo actionWithDuration:retrieveSpeed position:playerPos];
	CCCallFuncN * call = [CCCallFuncN actionWithTarget:self selector:@selector(hookRetrieved:)];
	CCSequence * sequence = [CCSequence actions:move ,call , nil];
	[hookSprite runAction:sequence];
}

-(void) hookReadyAnimation{
	
	[hookSprite stopAllActions];
	
	hookSprite.position = playerPos;
	
	id actionTo = [CCRotateTo actionWithDuration: 1 angle:60];
	id actionTo2 = [CCRotateTo actionWithDuration: 1 angle:-60];
	id actionTo0 = [CCRotateTo actionWithDuration: 1  angle:0];
	CCSequence * seq = [CCSequence actions: actionTo, actionTo0 ,actionTo2, actionTo0, nil];
	id hookAnimation = [CCRepeatForever actionWithAction: seq];
	
	[hookSprite runAction:hookAnimation];
}



-(void) setScreenSaverEnabled:(bool)enabled
{
	UIApplication *thisApp = [UIApplication sharedApplication];
	thisApp.idleTimerDisabled = !enabled;
}



-(void) pauseGame{
	CCNode* node;
	CCARRAY_FOREACH([self children], node)
	{
		[node stopAllActions];
	}

	[self unscheduleUpdate];
	[self unschedule:@selector(FishesUpdate:)];
	[self unschedule:@selector(BubbleUpdate:)];
	
	self.isTouchEnabled = FALSE;
	
	[[[MiniGameFishing sharedLayer] uiLayer] initContinueOrQuit];
}

-(void) resetGame
{
	[self setScreenSaverEnabled:NO];
	
	self.isTouchEnabled = YES;
	
	hookReady = TRUE;
	hookLaunched = FALSE;
	fishCatchedOrNot = uncatched;
	curScore = 0;
	lastScore = 0;
	timeTemp = 0;
	
	[self hookReadyAnimation];
	[self resetFishes];
	[self resetBubbles];
	[self resetBombs];
	[self resetRubbish];
	[self scheduleUpdate];
	[self schedule:@selector(FishesUpdate:) interval:0.6f];
	[self schedule:@selector(BubbleUpdate:) interval:1];

	totalTime = 0;
	[scoreLabel setString:[NSString stringWithFormat:@"%d", curScore]];
}

-(void) destroyScene{
	
	[self unscheduleAllSelectors];
	
	CCNode * node;
	CCARRAY_FOREACH([self children], node)
	{
		[node stopAllActions];
	}
	
	[self removeAllChildrenWithCleanup:YES];
}

-(int) getScore{
	return curScore;
}

-(void) draw
{
	glColor4f(1, 1, 1, 1);
	ccDrawLine(hookSprite.position, playerPos);
}


@end
