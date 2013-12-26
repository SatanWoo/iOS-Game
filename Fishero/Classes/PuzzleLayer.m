//
//  PuzzleLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "PuzzleLayer.h"
#import "BubbleLayer.h"
#import "ActiveBGLayer.h"

@interface PuzzleLayer()
-(void)initData;
-(void)setBackground;
-(void)setButton;
-(void)setPre;
-(void)setShowAndBlock;
-(void)randomGame;
-(void)gameStart;
@end

@implementation PuzzleLayer

-(id)init{
	self = [super init];
	if(self){
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];//允许触控
		[self setBackground];
		[self setButton];
		[self setPre];
		[self setShowAndBlock];
 		[self gameStart];
		
		
		//The active background and bubbles are added to self
		CCLayer * activeBG = [ActiveBGLayer node];
		[self addChild:activeBG z:0 tag:100];
		
		CCLayer * bubbleLayer = [BubbleLayer node];
		[self addChild:bubbleLayer z:0 tag:101];
	}
	return self;
}

-(void)initData{
	touchStatu = 0;
	viewStatu = 0;
	memset(num, 0, sizeof(num));
	memset(isUsed, 0, sizeof(isUsed));
}

-(void)setBackground{
	CCSprite* back = [CCSprite spriteWithFile:@"background_match.png"];
	back.position = ccp(ipadWidth	/ 2, ipadLength / 2);
	[self addChild:back z:0];
}

-(void)setButton{
	CCSprite* view = [CCSprite spriteWithFile:@"view.png"];
	CCMenuItemSprite* viewItem = [CCMenuItemSprite itemFromNormalSprite:view selectedSprite:nil	target:self selector:@selector(viewAction:)];
	CCMenu* mainMenu = [CCMenu menuWithItems:viewItem, nil];
	mainMenu.position = ccp(100, 700);
	[self addChild:mainMenu];
	
	
	CCSprite* back = [CCSprite spriteWithFile:@"backButton.png"];
	CCSprite* replay = [CCSprite spriteWithFile:@"replay.png"];
	
		// set the back and replay
	CCMenuItemSprite* backItem = [CCMenuItemSprite itemFromNormalSprite:back selectedSprite:nil	target:self selector:@selector(backAction:)];
	CCMenuItemSprite* replayItem = [CCMenuItemSprite itemFromNormalSprite:replay selectedSprite:nil	target:self selector:@selector(replayAction:)];
	CCMenu* menu = [CCMenu menuWithItems:backItem, replayItem, nil];
	menu.position = ccp(ipadWidth / 2, 50);
	[menu alignItemsHorizontallyWithPadding:200.0f];
	[self addChild:menu z:3];
}


-(void)backAction:(id)sender{
	[SceneManager goMiniGame];
	
}

-(void)replayAction:(id)sender{
	if( viewStatu == 1) return;
	[self gameStart];
}

-(void)viewAction:(id)sender{
	if(viewStatu == 1){
		CCAction *go   = [CCSequence actions:
						  [CCJumpTo	actionWithDuration:0.5f position:ccp(ipadWidth / 2 + ipadWidth, ipadLength / 2) height:60.0f jumps:3],
						  [CCFadeOut actionWithDuration:0.0f],
						  nil];
		[complete runAction: go];
	}
	else{
		CCAction *jump = [CCSequence actions:
						  [CCFadeIn actionWithDuration:0.0f],
						  [CCJumpTo	actionWithDuration:0.2f position:ccp(ipadWidth / 2, ipadLength / 2) height:40.0f jumps:1],
						  [CCJumpTo	actionWithDuration:0.2f position:ccp(ipadWidth / 2, ipadLength / 2) height:20.0f jumps:1],
						  [CCJumpTo	actionWithDuration:0.3f position:ccp(ipadWidth / 2, ipadLength / 2) height:10.0f jumps:2],
						  nil];
		complete.position = ccp(ipadWidth / 2, ipadLength / 2);
		[complete runAction: jump];
	}
	viewStatu = viewStatu ^ 1;
}

-(void)setShowAndBlock{
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++){
			show[i][j].x = 162 + j * blockSize;
			show[i][j].y = 584  - i * blockSize;
		}
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++){
			frame[i][j] = [CCSprite spriteWithFile:@"frame.png"];
			frame[i][j].position = show[i][j];
			frame[i][j].opacity = 0;
			[self addChild:frame[i][j] z:1];
		}
	
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++){
			block[i][j] = [CCSprite spriteWithFile:@"puzzlePic.png" rect:CGRectMake(j * blockSize, i * blockSize, blockSize, blockSize)];
			block[i][j].opacity = 0;
			[self addChild:block[i][j]];
		}
}

-(void)setPre{
	complete = [CCSprite spriteWithFile:@"puzzlePic.png" rect:CGRectMake(0, 0, picWidthPuz, picLengthPuz)];
	complete.position = ccp(ipadWidth / 2, ipadLength / 2);
	complete.opacity = 0;
	[self addChild:complete z:3];
}

-(void)randomGame{
	int temp;
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++){
			frame[i][j].opacity = 0;
			do{
			    temp = arc4random() % (puzzleRow * puzzleLine);
			}while(isUsed[temp]);
			isUsed[temp] = true;
			num[i][j] = temp;
		}
	int x, y;
	CCAction *apper;
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++){
			x = num[i][j] / puzzleLine;
			y = num[i][j] % puzzleLine;
			block[x][y].position = show[i][j];
			block[x][y].opacity = 0;
			apper = [CCSequence actions:
					 [CCDelayTime actionWithDuration:(i + j) * 0.1f],
				     [CCFadeIn actionWithDuration:0.1f],
					 nil];
			[block[x][y] runAction:apper];
		}
}

-(void)gameStart{
	[self initData];
	[self randomGame];
}

-(void)touchWithX:(int)x Y:(int)y{
    int sx, sy, ex, ey, tempNum;
	
	if(touchStatu){
		frame[x][y].opacity = 255;
	}else {
		for(int i = 0; i < puzzleRow; i++)
			for(int j = 0; j < puzzleLine; j++)
				if(frame[i][j].opacity > 0){
					frame[i][j].opacity = 0;
					sx = num[i][j] / puzzleLine; 
					sy = num[i][j] % puzzleLine;
					ex = num[x][y] / puzzleLine;
					ey = num[x][y] % puzzleLine;
					tempNum = num[i][j]; num[i][j] = num[x][y]; num[x][y] = tempNum;
					[block[sx][sy] runAction:[CCMoveTo actionWithDuration:0.2f position:show[x][y]]];
					[block[ex][ey] runAction:[CCMoveTo actionWithDuration:0.2f position:show[i][j]]];
				}
	}
	touchStatu = touchStatu ^ 1;
}


-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	if( viewStatu == 1) return YES;
	begin = [touch locationInView:[touch view]];
	begin = [[CCDirector sharedDirector] convertToGL:begin];
	x1 = y1 = -1;
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++)
			if(show[i][j].x - 50 <= begin.x && begin.x < show[i][j].x + 50 &&
			   show[i][j].y - 50 <= begin.y && begin.y < show[i][j].y + 50){
				x1 = i;
				y1 = j;
			}
	if(x1 != -1 && y1 != -1)[self touchWithX:x1 Y:y1];
	return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
	if(viewStatu == 1) return;
	end = [touch locationInView:[touch view]];
	end = [[CCDirector sharedDirector] convertToGL:end];
	x2 = y2 = -1;
	for(int i = 0; i < puzzleRow; i++)
		for(int j = 0; j < puzzleLine; j++)
			if(show[i][j].x - 50 <= end.x && end.x < show[i][j].x + 50 &&
			   show[i][j].y - 50 <= end.y && end.y < show[i][j].y + 50){
				x2 = i;
				y2 = j;
			}
	if(x1 != -1 && y1 != -1 && x2 != -1 && y2 != -1){
		if(x1 != x2 || y1 != y2) [self touchWithX:x2 Y:y2];
	}
}

-(void)dealloc{
	[super dealloc];
}

@end
