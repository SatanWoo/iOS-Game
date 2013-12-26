//
//  MatchLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "MatchLayer.h"
#import "BubbleLayer.h"
#import "ActiveBGLayer.h"
#import "saveData.h"

@interface MatchLayer()

-(void)initData;
-(void)setBackground;
-(void)setButton;
-(void)setNum;
-(void)setTime;
-(void)setScore;
-(void)setPre;
-(void)initShow;
-(void)testShow;
-(void)clearGame;
-(void)randomGame;
-(void)addBeanWithColor:(int)color;
-(void)removeWithX:(int)x Y:(int)y;
-(bool)checkWithX:(int)x Y:(int)y;
-(void)refreshScore;
-(void)refreshTime;
-(void)refreshNum;
-(void)gameStart;
-(void)gameOver;
-(bool)canSolve;

-(void)backAction:(id)sender;
-(void)replayAction:(id)sender;
-(void)clockAction:(id)sender;
-(void)refreshAction:(id)sender;
@end

int dx[4] = {-1, 0, 0, 1};
int dy[4] = {0 ,-1, 1, 0};

@implementation MatchLayer

-(id)init{
	self = [super init];
	if(self){
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:NO];//允许触控
		[self initShow];
		[self setBackground];
		[self setButton];
		[self setNum];
		[self setTime];
		[self setScore];
		[self setPre];
			//[self testShow];
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
	isGameOver = false;
	isFirstTouch = true;
	clockNum = refreshNum = comboNum = 0;
	score = 0;
	gameTime = 60;
	lastTime = runTime = 0;
	memset(isUsed, -1, sizeof(isUsed));
}

-(void)gameStart{
	[self clearGame];
	[self initData];
	[self refreshTime];
	[self refreshScore];
	[self refreshNum];
	[self randomGame];
	[self unscheduleAllSelectors];	
}

-(void)setBackground{
	CCSprite* back = [CCSprite spriteWithFile:@"background_match.png"];
	back.position = ccp(ipadWidth	/ 2, ipadLength / 2);
	[self addChild:back z:0];
	CCSprite* background = [CCSprite spriteWithFile:@"gameBackground_without_black.png"];
	background.position = ccp(ipadWidth	/ 2, ipadLength / 2);
	[self addChild:background z:1];
}

-(void)setButton{
	CCSprite* back = [CCSprite spriteWithFile:@"backButton.png"];
	CCSprite* replay = [CCSprite spriteWithFile:@"replay.png"];
	CCSprite* clock = [CCSprite spriteWithFile:@"clock.png"];
	CCSprite* refresh = [CCSprite spriteWithFile:@"refresh.png"];
	
		// set the back and replay
	CCMenuItemSprite* backItem = [CCMenuItemSprite itemFromNormalSprite:back selectedSprite:nil	target:self selector:@selector(backAction:)];
	CCMenuItemSprite* replayItem = [CCMenuItemSprite itemFromNormalSprite:replay selectedSprite:nil	target:self selector:@selector(replayAction:)];
	CCMenu* menu = [CCMenu menuWithItems:backItem, replayItem, nil];
	menu.position = ccp(ipadWidth / 2, 50);
	[menu alignItemsHorizontallyWithPadding:200.0f];
	[self addChild:menu z:3];
	
	
		// set the prop
	CCMenuItemSprite* clockItem = [CCMenuItemSprite itemFromNormalSprite:clock selectedSprite:nil target:self selector:@selector(clockAction:)];
	CCMenuItemSprite* refreshItem = [CCMenuItemSprite itemFromNormalSprite:refresh selectedSprite:nil target:self selector:@selector(refreshAction:)];
	CCMenu* clockMenu = [CCMenu menuWithItems:clockItem, nil];
	CCMenu* refreshMenu = [CCMenu menuWithItems:refreshItem, nil];
	clockMenu.position = ccp(70, ipadLength / 2 - 100);
	refreshMenu.position = ccp(70, ipadLength / 2 + 100);
	[self addChild:clockMenu];
	[self addChild:refreshMenu];
}

-(void)setNum{
	recordClock = [CCLabelTTF labelWithString:@"x0" fontName:@"Marker Felt" fontSize:50];
	[recordClock setColor:ccWHITE];
		//	recordClock.anchorPoint = ccp(0, 0);
	recordClock.position = ccp(150, ipadLength / 2 - 100);
	[self addChild:recordClock];
	
	recordRefresh = [CCLabelTTF labelWithString:@"x0" fontName:@"Marker Felt" fontSize:50];
	[recordRefresh setColor:ccWHITE];
		//	recordRefresh.anchorPoint = ccp(0, 0);
	recordRefresh.position = ccp(150, ipadLength / 2 + 100);
	[self addChild:recordRefresh];	
}

-(void)refreshNum{
	NSString* updateClock =[NSString stringWithFormat:@"x%d",clockNum];
	[recordClock setString:updateClock];
	NSString* updateRefresh =[NSString stringWithFormat:@"x%d",refreshNum];
	[recordRefresh setString:updateRefresh];
	NSLog(@"%d %d",clockNum, refreshNum);
}

-(void)initShow{
		// set the position of the beans
	for(int i = 0; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++){
			show[i][j].x = 245 + j * 35;
			show[i][j].y = 208 + i * 35;
		}
}

-(void)setTime{
	CCSprite* timeFrame = [CCSprite spriteWithFile:@"fullTime.png"];
	timeFrame.anchorPoint = ccp(0, 0);
	timeFrame.position = ccp(100, 700);
	[self addChild:timeFrame z:3];
	left = [CCSprite spriteWithFile:@"timeLeft.png"];
	left.anchorPoint = ccp(0, 0);
	left.position = ccp(100, 700);
	[self addChild:left z:1];
}

-(void)refreshTime{
	runTime += 0.1;
	if(runTime >= gameTime) runTime = gameTime;
	[self removeChild:left cleanup:YES];
	int length = 673 * (gameTime - runTime) / gameTime;
	left = [CCSprite spriteWithFile:@"timeLeft.png" rect:CGRectMake(0, 0, length, 27)];
	left.anchorPoint = ccp(0, 0);
	left.position = ccp(100, 700);
	[self addChild:left z:1];
	
	
	if(runTime >= gameTime) [self gameOver];
}

-(void)setScore{
	recordScore = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:64];
	[recordScore setColor:ccWHITE];
	recordScore.position = ccp(900, 700);
	[self addChild:recordScore];
}

-(void)refreshScore{
	NSString* updateScore =[NSString stringWithFormat:@"%d",score];
	[recordScore setString:updateScore];
}

-(void)refreshComboWithPoint:(CGPoint)fromPoint{
	CGPoint endPoint;
	fromPoint.x += 100;
	fromPoint.y += 100;
	
	endPoint.x = fromPoint.x;
	endPoint.y = fromPoint.y + 100;
	
	NSString* updateCombo =[NSString stringWithFormat:@"Combo x%d",comboNum];
	[combo setString:updateCombo];
	
	combo.position = fromPoint;
	
	
	CCAction* comboShow = [CCSequence actions:
						   [CCFadeIn actionWithDuration:0.0f],
						   [CCMoveTo actionWithDuration:0.5f position:endPoint],
						   [CCFadeOut actionWithDuration:0.0f],
						   nil];
	if(comboNum > 1) [combo runAction:comboShow];	
}

-(void)setPre{
	gameOverPicture = [CCSprite spriteWithFile:@"showScore.png"];
	gameOverPicture.position = ccp(ipadWidth / 2, ipadLength / 2);
	gameOverPicture.opacity = 0;
	[self addChild:gameOverPicture z:2];
	
	
	yourScore = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:80];
	[yourScore setColor:ccc3(255, 0, 0)];
	yourScore.position = ccp(ipadWidth / 2, ipadLength / 2);
	yourScore.opacity = 0;
	[self addChild:yourScore z:2];
	
	
	combo =[CCLabelTTF labelWithString:@"Combe x 0" fontName:@"Marker Felt" fontSize:40];
	[combo setColor:ccWHITE];
	combo.position = ccp(ipadWidth / 2, ipadLength / 2);
	combo.opacity = 0;
	[self addChild:combo z:2];
	
}

-(void)testShow{
	for(int i = 0; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++){
			beans[i][j] = [CCSprite spriteWithFile:@"1.png"];
			beans[i][j].position = show[i][j];
			[self addChild:beans[i][j] z:1];
		}
}

-(void)randomGame{
	srand(time(NULL));
	for(int k = 0; k < beansNum; k++){
		int color = k % maxColor, x, y;
		for(int i = 0; i < 2; i++){
		    do{
			    x = arc4random() % maxRow;
			    y = arc4random() % maxLine;
     		}while(isUsed[x][y] != -1);
	    	isUsed[x][y] = color;
		}
	}
	
	for(int k = 0; k < propsNum; k++){
		int color = maxColor + k % 2, x, y;
		for(int i = 0; i < 2; i++){
		    do{
			    x = arc4random() % maxRow;
			    y = arc4random() % maxLine;
     		}while(isUsed[x][y] != -1);
	    	isUsed[x][y] = color;
		}		
	}
	
	for(int i = 0; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++){
			if(isUsed[i][j] == -1) continue;
			NSString* temp = [NSString stringWithFormat:@"%d.png",isUsed[i][j]];
			beans[i][j] = [CCSprite spriteWithFile:temp];
			
			int rx = arc4random() % 1024;
			int ry = arc4random() % 768;
			
			beans[i][j].position = ccp(rx, ry);
			beans[i][j].scale = (arc4random()% 20 + 80 ) / 100.0;
			
		    [self addChild:beans[i][j] z:1];
			CCAction* beansShow =   [CCSequence actions:
									 [CCMoveTo actionWithDuration:0.5 position:show[i][j]],
									 nil];
			[beans[i][j] runAction:beansShow];
		}
}

-(void)clearGame{
	for(int i = 0; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++)
			if(isUsed[i][j] != -1){
				[self removeChild:beans[i][j] cleanup:YES];
				isUsed[i][j] = -1;
			}
}

-(void)addBeanWithColor:(int)color{
	int x, y;
	do{
		x = arc4random() % maxRow;
		y = arc4random() % maxLine;
	}while(isUsed[x][y] != -1);
	isUsed[x][y] = color;
	NSString* temp = [NSString stringWithFormat:@"%d.png",isUsed[x][y]];
	beans[x][y] = [CCSprite spriteWithFile:temp];	
	beans[x][y].position = show[x][y];
	[self addChild:beans[x][y]];
	[beans[x][y] runAction:[CCFadeIn actionWithDuration:0.3f]];
}

-(bool)canSolve{
	for(int x = 0; x < maxRow; x++)
		for(int y = 0; y < maxLine; y++)
			if([self checkWithX:x Y:y]) return true;
	return false;
}

-(void)removeWithX:(int)x Y:(int)y{
	if(runTime - lastTime > 2.0) comboNum = 0;
		comboNum++;
	[self refreshComboWithPoint:show[x][y]];
	
	lastTime = runTime;
	CCAction* delayDelete;
	int tx, ty;
	for(int i = 0; i < 4; i++){
		tx = x; ty = y;
		do{
			tx += dx[i];
			ty += dy[i];
		}while(0 <= tx && tx < maxRow && 0 <= ty && ty < maxLine && isUsed[tx][ty] == -1);
		
		if(0 <= tx && tx < maxRow && 0 <= ty && ty < maxLine && colorCount[isUsed[tx][ty]] >= 2){
			CCAction *jump = [CCSequence actions:
							  [CCJumpTo	actionWithDuration:0.2f position:beans[tx][ty].position height:14.0f jumps:1],
							  [CCJumpTo	actionWithDuration:0.2f position:beans[tx][ty].position height: 7.0f jumps:1],
							  [CCJumpTo	actionWithDuration:0.3f position:beans[tx][ty].position height: 3.0f jumps:2],
							  [CCFadeOut actionWithDuration:0.2f],
  						      nil];
			[beans[tx][ty] runAction:jump];
	        isUsed[tx][ty] = -1;
			double dist = fabs(tx - x) + fabs(ty - y);
			double delayTime;
			int k = 0;
			do{
				k++;
				delayTime = 0.3 / dist * (dist - k);
				tx -= dx[i];
				ty -= dy[i];
				if(tx == x && ty == y) break;
				point[tx][ty] = [CCSprite spriteWithFile:@"point.png"];
				point[tx][ty].position = show[tx][ty];
				point[tx][ty].opacity = 0;
				delayDelete = [CCSequence actions:
							   [CCDelayTime actionWithDuration:delayTime],
							   [CCFadeIn actionWithDuration:0.0f],
							   [CCDelayTime actionWithDuration:0.1f],
							   [CCFadeOut actionWithDuration:0.0f],
							   nil];
				[point[tx][ty] runAction:delayDelete];
				[self addChild:point[tx][ty]];
			}while (true);
		}
		
	}
	for(int i = 0; i < maxColor + maxProp; i++){
		if(colorCount[i] == 3) [self addBeanWithColor:i];
		if(colorCount[i] >= 2) score += colorCount[i] * comboNum;
	}
	refreshNum += colorCount[9] / 2;
	clockNum += colorCount[10] / 2;
	[self refreshScore];
	[self refreshNum];
	if(![self canSolve]) [self refreshAction:nil];
	for(int i = 0; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++)
			if(isUsed[i][j] != -1) return;
	[self gameOver];
}

-(bool)checkWithX:(int)x Y:(int)y{
	if(isUsed[x][y] != -1) return false;
	memset(colorCount, 0, sizeof(colorCount));
	int tx, ty;
	for(int i = 0; i < 4; i++){
		tx = x; ty = y;
		do{
			tx += dx[i];
			ty += dy[i];
		}while(0 <= tx && tx < maxRow && 0 <= ty && ty < maxLine && isUsed[tx][ty] == -1);
		
		if(0 <= tx && tx < maxRow && 0 <= ty && ty < maxLine){
			colorCount[isUsed[tx][ty]]++;
		}
	}
	for(int i = 0; i < maxColor + maxProp; i++)
		if(colorCount[i] >= 2) return true;
	return false;
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	if(isGameOver) return YES;	
	if(isFirstTouch){
		[self schedule:@selector(refreshTime) interval: 0.1];
		isFirstTouch = false;
	}
	CGPoint begin = [touch locationInView:[touch view]];
	begin = [[CCDirector sharedDirector] convertToGL:begin];
	int x = -1; 
	int y = -1;
	for(int i = 0 ; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++)
			if(show[i][j].x - 17 <= begin.x && begin.x <= show[i][j].x + 17 &&
			   show[i][j].y - 17 <= begin.y && begin.y <= show[i][j].y + 17){
				x = i;
				y = j;
			}
	if (x != -1 && y != -1){
		if([self checkWithX:x Y:y]) [self removeWithX:x Y:y];
		else{
			runTime += 5.0;
			[self refreshTime];
		}
	}
	return YES;
}

-(void)backAction:(id)sender{

	[SceneManager goMiniGame];
}

-(void)replayAction:(id)sender{
	if(gameOverPicture.opacity != 0){
	    [gameOverPicture runAction:[CCFadeOut actionWithDuration:0.5f]];
    	[yourScore runAction:[CCFadeOut actionWithDuration:0.5f]];
	}
	[self gameStart];
}

-(void)clockAction:(id)sender{
	if(isGameOver || !clockNum) return;
	clockNum --;
	[self refreshNum];
	runTime -= 5.0;
	if(runTime < 0 ) runTime = 0;
		}

-(void)refreshAction:(id)sender{
	if(isGameOver || !refreshNum) return;
	refreshNum --;
	[self refreshNum];
	
	
	memset(colorCount, 0, sizeof(colorCount));
	for(int i = 0; i < maxRow; i++)
		for(int j = 0 ; j < maxLine; j++)
			if(isUsed[i][j] != -1){
				[self removeChild:beans[i][j] cleanup:YES];
				colorCount[isUsed[i][j]]++;
			}
	memset(isUsed, -1, sizeof(isUsed));
	for(int color = 0; color < maxColor + maxProp; color++)
		for(int i = 0; i < colorCount[color]; i++){
			int x, y;
			do{
				x = arc4random() % maxRow;
				y = arc4random() % maxLine;
			}while(isUsed[x][y] != -1);
			isUsed[x][y] = color;
		}
	
	for(int i = 0; i < maxRow; i++)
		for(int j = 0; j < maxLine; j++){
			if(isUsed[i][j] == -1) continue;
			NSString* temp = [NSString stringWithFormat:@"%d.png",isUsed[i][j]];
			beans[i][j] = [CCSprite spriteWithFile:temp];
			beans[i][j].position = show[i][j];
			beans[i][j].scale = (arc4random()% 20 + 80 ) / 100.0;
		    [self addChild:beans[i][j]];
		}		
}

-(void)gameOver{
	isGameOver = true;
	[gameOverPicture runAction:[CCFadeIn actionWithDuration:0.5f]];
	[yourScore setString:[NSString stringWithFormat:@"%d",score]];
	int scoreTemp=[saveData getScore];
	scoreTemp+=score/10;
	[saveData setScore:scoreTemp];
	[yourScore runAction:[CCFadeIn actionWithDuration:0.5f]];
	[self unscheduleAllSelectors];
}

-(void)dealloc{
	[super dealloc];
}

@end
