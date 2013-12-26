//
//  classical.m
//  tapat
//
//  Created by Yu Dingsheng on 11-1-29.
//  Copyright 2011 Tongji. All rights reserved.
//

#import "classical.h"
#import "cocos2d.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "saveSetting.h"
#import "saveData.h"
#import "musiceHandle.h"

@interface classical()
-(void)initData;
-(void)setTheShowPosition;
-(void)setPropButton;
-(void)setPauseButton;
-(void)setBackButton;
-(void)testMice;
-(void)setLable;
-(void)newGame;
-(void)touchMiceWithX:(int)x Y:(int)y;
-(void)touchPropWithX:(int)x Y:(int)y;
-(bool)isFull;
-(void)gameOver;
-(void)snakeAction;
-(void)updateGameTime;
-(void)setStatu;
-(void)setCross;
-(void)crossRefresh;
-(void) showStartHint;
-(void) startHintCallback: (id) sender;

@end


@implementation classical


-(id)init{
	self = [super init];
	if (self) {
		self.isTouchEnabled = YES;
		[self setPauseButton];		
		[self setBackButton];
        [self initStatus];
		[self initData];
		[self setTheShowPosition];
		//		[self testMice];
		[self setLable];
		[self setPropButton];
		[self setStatu];
		[self setCross];
		readyIndex=0;
		startArray=[NSArray arrayWithObjects:@"Three chances",@"3",@"2",@"1",@"Start",nil];
		[startArray retain];
		//		[self newGame];
		
	}
	return self;
}

-(void)initStatus
{
    coldNowOfMucus=1;
    coldNowOfVirus=1;
    coldNowOfFood=1;
    coldNowOfNet=1;
    coldNowOfToxic=1;
    
    canBeUsedOfMucus=TRUE;
    canBeUsedOfVirus=TRUE;
    canBeUsedOfFood=TRUE;
    canBeUsedOfNet=TRUE;
    canBeUsedOfToxic=TRUE;
    
    isPause=FALSE;
}


-(void)initData{
	memset(isOn, 0, sizeof(isOn));
	memset(isUsed, 0, sizeof(isUsed));
	memset(miceBlood, 0, sizeof(miceBlood));
	memset(miceShowTime, 0, sizeof(miceShowTime));
	memset(propShowTime, 0, sizeof(propShowTime));
	
	//arguments of mice
	miceRefreshTime = miceLiveTime = 100;
	firstMice = secondMice = thirdMice = 0;
	blood_1 = blood_2 = blood_3 = 0;
	
	//arguments of prop
	propRefreshTime = propLiveTime = 100;
	
	//The probability of the prop show
    proMucus = proFood = proNet = proToxic =proVirus = 0;
	
	//the rest time that the prop's affection
	runMucusTime = runFoodTime = runToxicTime = runVirusTime = 0;
	
	//The total time that the prop's affection
	totMucusTime = totFoodTime = totToxicTime = totVirusTime = 100;
	
	
	gameRunTime = 0;
	escape = 0;
	tempForFood = 0;
	
	miceRefreshTime = 2;
	propRefreshTime = 2;
	state = 0;

}


-(void)setTheShowPosition{
	int rowVal = 73, lineVal = 120, rowDifVal = 22;
	
	showPosition[0][0].v = 390;
	showPosition[0][0].h = 250;
	
	for(int j = 1; j < MaxLine; j++){
		showPosition[0][j].v = showPosition[0][j - 1].v + lineVal;
		showPosition[0][j].h = showPosition[0][j - 1].h;
	}
	for(int i = 1; i < MaxRow; i++){
		showPosition[i][0].v = showPosition[i - 1][0].v + rowDifVal;
		showPosition[i][0].h = showPosition[i - 1][0].h + rowVal;
		for(int j = 1; j < MaxLine; j++){
			showPosition[i][j].v = showPosition[i][j - 1].v + lineVal;
			showPosition[i][j].h = showPosition[i - 1][j].h + rowVal;
		}	
	}
}


-(void)setPropButton{	
	int fromBottom = 70, fromLeft = 70;
	int rowVal = 83, lineVal = 20; 
	
    CCSprite* mucus = [CCSprite spriteWithFile:@"Mucus.png" rect:CGRectMake(0,0, 100,85)];
	//[saveArray addObject:mucus];
    CCMenuItem* mucusItem = [CCMenuItemSprite itemFromNormalSprite:mucus selectedSprite:nil target:self selector:@selector(mucusAction:)];
	CCMenu* mucusMenu = [CCMenu menuWithItems:mucusItem, nil];
	mucusMenu.position = ccp(fromLeft + 4 * lineVal, fromBottom + 4 * rowVal);
	[self addChild:mucusMenu ];
	
	CCSprite* food = [CCSprite spriteWithFile:@"Food.png" rect:CGRectMake(0,0, 100,85)];
    
	//[saveArray addObject:food];
    CCMenuItem* foodItem = [CCMenuItemSprite itemFromNormalSprite:food selectedSprite:nil target:self selector:@selector(foodAction:)];
	CCMenu* foodMenu = [CCMenu menuWithItems:foodItem, nil];
	foodMenu.position = ccp(fromLeft + 3 *lineVal, fromBottom + 3 * rowVal);
	[self addChild:foodMenu];
	
	CCSprite* net = [CCSprite spriteWithFile:@"Net.png" rect:CGRectMake(0,0, 100,85)];
	//[saveArray addObject:net];
    CCMenuItem* netItem = [CCMenuItemSprite itemFromNormalSprite:net selectedSprite:nil target:self selector:@selector(netAction:)];
	CCMenu* netMenu = [CCMenu menuWithItems:netItem, nil];
	netMenu.position = ccp(fromLeft + 2 * lineVal, fromBottom + 2 * rowVal);
	[self addChild:netMenu];						
	
	CCSprite* toxic = [CCSprite spriteWithFile:@"Toxic.png" rect:CGRectMake(0,0, 100,85)];
    //[saveArray addObject:toxic];
	CCMenuItem* toxicItem = [CCMenuItemSprite itemFromNormalSprite:toxic selectedSprite:nil target:self selector:@selector(toxicAction:)];
	CCMenu* toxicMenu = [CCMenu menuWithItems:toxicItem, nil];
	toxicMenu.position = ccp(fromLeft + 1 * lineVal, fromBottom + 1 * rowVal);
	[self addChild:toxicMenu];
	
	CCSprite* virus = [CCSprite spriteWithFile:@"Virus.png" rect:CGRectMake(0,0, 100,85)];
    //[saveArray addObject:virus];
	CCMenuItem* virusItem = [CCMenuItemSprite itemFromNormalSprite:virus selectedSprite:nil target:self selector:@selector(virusAction:)];
	CCMenu* virusMenu = [CCMenu menuWithItems:virusItem, nil];
	virusMenu.position = ccp(fromLeft, fromBottom);
	[self addChild:virusMenu];
	
}

-(void)setPauseButton{
	CCSprite* pauseButton = [CCSprite spriteWithFile:@"pause.png" rect:CGRectMake(0, 0, 80, 80)];
	CCMenuItem *pauseButtonItem = [CCMenuItemSprite itemFromNormalSprite:pauseButton selectedSprite:nil target:self selector:@selector(GamePause:)];						  
	CCMenu* pauseMenu = [CCMenu menuWithItems:pauseButtonItem,nil];
	pauseMenu.position = ccp(ipadWidth - 120, 40);
	[self addChild:pauseMenu z: 5];
}

-(void)GamePause:(id)sender{
    if(isPause) return;
    isPause = TRUE;    
    
    pauseView = [CCSprite spriteWithFile:@"pauseView.png" rect:CGRectMake(0, 0, ipadWidth, ipadLength)];
    pauseView.position = ccp(ipadWidth / 2, ipadLength / 2);
    [pauseView runAction:[CCFadeIn actionWithDuration:0.5f]];
    [self addChild:pauseView z: 10];
    CCMenuItem *resume = [CCMenuItemFont itemFromString: @"resume" target:self selector:@selector(GameResume:)];
    [resume setColor:ccORANGE];
    //[resume setFontSize:20];
    tempMenu = [CCMenu menuWithItems:resume,nil];
    tempMenu.position = ccp(ipadWidth/2+35, ipadLength/2+20);
    [self addChild:tempMenu z: 20];
                                            
    [[CCDirector sharedDirector] pause];
    
}


-(void)GameResume:(id)sender{
    if(!isPause) return;
    [self removeChild:tempMenu cleanup:YES];
    isPause = FALSE;
    [pauseView runAction:[CCFadeOut actionWithDuration:0.5f]];
    [[CCDirector sharedDirector] resume];
}



-(void)setBackButton{
	CCSprite* BackButton = [CCSprite spriteWithFile:@"back.png" rect:CGRectMake(0, 0, 80, 80)];
	CCMenuItem *BackButtonItem = [CCMenuItemSprite itemFromNormalSprite:BackButton selectedSprite:nil target:self selector:@selector(BackToMenu:)];						  
	CCMenu* BackMenu = [CCMenu menuWithItems:BackButtonItem,nil];
	BackMenu.position = ccp(ipadWidth - 40, 40);
	[self addChild:BackMenu z: 5];
}

-(void)BackToMenu:(id)sender{
	if(isPause)	[self GamePause:sender];
	[SceneManager goMenu:sender];
}



-(void)setLable{
	int ax,ay,bx,by,cx,cy,kind;
	kind = [saveSetting getBackground];
	switch (kind) {
		case 0:
			ax = 230; ay = 650; bx = 230; by = 610; cx = 180; cy = 490;
			break;
		case 1:
			ax = 230; ay = 650; bx = 230; by = 610; cx = 180; cy = 490;
			break;
		case 2:
			ax = 230; ay = 650; bx = 230; by = 610; cx = 180; cy = 490;
			break;
		default:
			break;
	}
	
	recordTime = [CCLabelTTF labelWithString:@"Time:" fontName:@"nevis.ttf" fontSize:40.0f];
	recordTime.anchorPoint=ccp(0, 0);
	recordTime.position=ccp(ax, ay);
	[self addChild:recordTime z:8 tag:timeTag];
	
	
	timeShow = [CCLabelTTF labelWithString:@"00:00" fontName:@"nevis.ttf" fontSize:40.0f];
	timeShow.anchorPoint=ccp(0, 0);
	timeShow.position=ccp(bx, by);
	[self addChild:timeShow z:8 tag:timeTag];
	[self updateGameTime];
	
	
	recordScore = [CCLabelTTF labelWithString:@"Score:0" fontName:@"nevis.ttf" fontSize:40.0f];
	recordScore.anchorPoint = ccp(0,0);
	recordScore.position = ccp(cx, cy);
	[self addChild:recordScore z:7 tag:scoreTag];
	
	
	int fromBottom = 50, fromLeft = 155;
	int rowVal = 80, lineVal = 20; 
	
	
	recordMucus=[CCLabelTTF labelWithString:@"x0" fontName:@"nevis.ttf" fontSize:36.0f];
	recordMucus.anchorPoint=ccp(0,0);
	recordMucus.position=ccp(fromLeft + 4 * lineVal, fromBottom + 4 * rowVal);
	[self addChild:recordMucus z:8];
	
	recordFood=[CCLabelTTF labelWithString:@"x0" fontName:@"nevis.ttf" fontSize:36.0f];
	recordFood.anchorPoint=ccp(0,0);
	recordFood.position=ccp(fromLeft + 3 * lineVal, fromBottom + 3 * rowVal);
	[self addChild:recordFood z:8];
	
	recordNet=[CCLabelTTF labelWithString:@"x0" fontName:@"nevis.ttf" fontSize:36.0f];
	recordNet.anchorPoint=ccp(0,0);
	recordNet.position=ccp(fromLeft + 2 * lineVal, fromBottom + 2 * rowVal);
	[self addChild:recordNet z:8];
	
	recordToxic=[CCLabelTTF labelWithString:@"x0" fontName:@"nevis.ttf" fontSize:36.0f];
	recordToxic.anchorPoint=ccp(0,0);
	recordToxic.position=ccp(fromLeft + 1 * lineVal, fromBottom + 1 * rowVal);
	[self addChild:recordToxic z:8];
	
	recordVirus=[CCLabelTTF labelWithString:@"x0" fontName:@"nevis.ttf" fontSize:36.0f];
	recordVirus.anchorPoint=ccp(0,0);
	recordVirus.position=ccp(fromLeft, fromBottom);
	[self addChild:recordVirus z:8];
}


-(void)testMice{
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++){
			int X = showPosition[i][j].v;
			int Y = showPosition[i][j].h;
			mice[i][j] = [CCSprite spriteWithFile:@"Virus.png" rect:CGRectMake(0, 0, 100, 85)];
			mice[i][j].position = ccp(X, Y);
			[self addChild:mice[i][j] z:0];
		}
}

-(void)setStatu{
	for(int i = 0; i < 4; i++){
		if(isOn[i]){
			isOn[i] = false;
			[self removeChild:statu[i] cleanup:YES];
			[self removeChild:statuProp[i] cleanup:YES];
		}
	}
	
	NSString* temp = [NSString stringWithFormat: @"statu%d.png", [saveSetting getBackground]];
	
	for(int i = 0; i < 4; i++)
		statu[i] = [CCSprite spriteWithFile: temp rect:CGRectMake(0, 0, 100, 100)];	
	statu[0].position = ccp(550, 710);
	statu[1].position = ccp(650, 710);
	statu[2].position = ccp(750, 710);
	statu[3].position = ccp(850, 710);
	
	int k = 0;
	if(isMucus){
		if(runMucusTime >= 30 || runMucusTime % 5 == 0)
			statuProp[k++] = [CCSprite spriteWithFile:@"MucusStatu.png" rect:CGRectMake(0, 0, 100, 100)];
		else
			statuProp[k++] = [CCSprite spriteWithFile:temp     		    rect:CGRectMake(0, 0, 100, 100)];	
	}
	if(isFood ){
		if(runFoodTime >= 30 ||  runFoodTime % 5 == 0)
			statuProp[k++] = [CCSprite spriteWithFile:@"FoodStatu.png" rect:CGRectMake(0, 0, 100, 100)];
		else
			statuProp[k++] = [CCSprite spriteWithFile:temp     		    rect:CGRectMake(0, 0, 100, 100)];	
	}
	if(isToxic){
		if(runToxicTime >= 30 || runToxicTime % 5 == 0)
		    statuProp[k++] = [CCSprite spriteWithFile:@"ToxicStatu.png" rect:CGRectMake(0, 0, 100, 100)];
		else
			statuProp[k++] = [CCSprite spriteWithFile:temp     		    rect:CGRectMake(0, 0, 100, 100)];	
	}
	
	if(isVirus){
		if(runVirusTime >= 30 || runVirusTime % 5 == 0)
    		statuProp[k++] = [CCSprite spriteWithFile:@"VirusStatu.png" rect:CGRectMake(0, 0, 100, 100)];
		else
			statuProp[k++] = [CCSprite spriteWithFile:temp     		    rect:CGRectMake(0, 0, 100, 100)];	
	}
	
	
	for(int i = 0; i < k; i++){
		isOn[i] = true;
		[self addChild:statu[i] z:5];
		statuProp[i].position = statu[i].position;
		[self addChild:statuProp[i] z:6];
	}
}


-(void)newGame{
	[self schedule:@selector(dataRefresh) interval: 0.1];
	[self schedule:@selector(gameTimeRun) interval: 0.1];
	[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
	[self schedule:@selector(miceDelete)  interval: 0.1];
	[self schedule:@selector(propRefresh) interval: propRefreshTime];
	[self schedule:@selector(propDelete)  interval: 0.1];	
}

-(void)dataRefresh{
	if(state == 0 && score >= 0){
		[self unschedule:@selector(miceRefresh)];
		[self unschedule:@selector(propRefresh)];
		state++;
		miceRefreshTime = 2;
		propRefreshTime = 2;
		miceLiveTime = 3;
		propLiveTime = 3;
		firstMice = 100; secondMice = 0; thirdMice = 0;
		blood_1 = 100;   blood_2 = 0;    blood_3 = 0;
		[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
		[self schedule:@selector(propRefresh) interval: propRefreshTime];
	}
	if(state == 1 && score >= 10){
		[self unschedule:@selector(miceRefresh)];
		[self unschedule:@selector(propRefresh)];
		state++;
		miceRefreshTime = 2;
		propRefreshTime = 2;
		miceLiveTime = 2;
		propLiveTime = 2;
		
		firstMice = 100; secondMice = 40; thirdMice = 0;
		blood_1 = 100;   blood_2 = 40;    blood_3 = 0;

		snakeNum = 1;
		proSnake = 30; 
		[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
		[self schedule:@selector(propRefresh) interval: propRefreshTime];
	}
	if(state == 2 && score >= 30){
		[self unschedule:@selector(miceRefresh)];
		[self unschedule:@selector(propRefresh)];
		state++;
		miceLiveTime = 1.8;
		propLiveTime = 1.8;
		
		firstMice = 100; secondMice = 60; thirdMice = 30;
		blood_1 = 100;   blood_2 = 60;    blood_3 = 30;
		
		snakeNum = 2;
		proSnake = 30; 
		proMucus = proFood = proNet = proToxic = proVirus = 30;
		[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
		[self schedule:@selector(propRefresh) interval: propRefreshTime];
	}
	if(state == 3 && score >= 60){
		[self unschedule:@selector(miceRefresh)];
		[self unschedule:@selector(propRefresh)];
		state++;
		miceRefreshTime = 1.8;
		propRefreshTime = 1.8;
		miceLiveTime = 1.5;
		propLiveTime = 1.5;
		
		firstMice = 100; secondMice = 60; thirdMice = 30;
		blood_1 = 100;   blood_2 = 60;    blood_3 = 30;
		
		snakeNum = 3;
		proSnake = 40; 
		proMucus = proFood = proNet = proToxic = proVirus = 30;
		[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
		[self schedule:@selector(propRefresh) interval: propRefreshTime];
	}	
	if(state == 4 && score >= 80){
		[self unschedule:@selector(miceRefresh)];
		[self unschedule:@selector(propRefresh)];
		state++;
		miceRefreshTime = 1.5;
		propRefreshTime = 1.5;
		miceLiveTime = 1.5;
		propLiveTime = 1.5;
		
		firstMice = 100; secondMice = 70; thirdMice = 40;
		blood_1 = 100;   blood_2 = 70;    blood_3 = 40;
		
		snakeNum = 4;
		proSnake = 30; 
		proMucus = proFood = proNet = proToxic = proVirus = 30;
		[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
		[self schedule:@selector(propRefresh) interval: propRefreshTime];
	}
	
	if(state == 5 && score >= 100){
		[self unschedule:@selector(miceRefresh)];
		[self unschedule:@selector(propRefresh)];
		state++;
		miceRefreshTime = 1.2;
		propRefreshTime = 1.2;
		miceLiveTime = 1.2;
		propLiveTime = 1.2;
		
		firstMice = 100; secondMice = 60; thirdMice = 30;
		blood_1 = 100;   blood_2 = 60;    blood_3 = 30;
		
		snakeNum = 4;
		proSnake = 30; 
		proMucus = proFood = proNet = proToxic = proVirus = 30;
		[self schedule:@selector(miceRefresh) interval: miceRefreshTime / 2];
		[self schedule:@selector(propRefresh) interval: propRefreshTime];
	}
	
	
	
	
	
}

-(void)gameTimeRun{
	gameRunTime += 0.1;
    [self updateGameTime];	
	if(isMucus){
		runMucusTime --;
		if(runMucusTime <= 0) isMucus = false;
	}
	if(isFood){
		runFoodTime --;
		if(runFoodTime <= 0) isFood = false;
	}
	if(isToxic){
		runToxicTime --;
		if(runToxicTime <= 0) isToxic = false;
	}
	if(isVirus){
		runVirusTime --;
		if(runVirusTime <= 0) isVirus = false;
	}
	[self setStatu];
}


-(void)miceRefresh{
	tempForFood = tempForFood ^ 1;
	if(tempForFood == 0 && !isFood) return;
	srand(time(NULL));
	int random = arc4random()%100;
	int num = 0;
	if(random < firstMice)  num = 1;
	if(random < secondMice) num = 2;
	if(random < thirdMice)  num = 3;
	int x, y;
	for(int i = 0; i < num; i++){
		if([self isFull]) return;
		do{
		    x = arc4random()%MaxRow;
			y = arc4random()%MaxLine;
		}while(isUsed[x][y] > 0);
		
		isUsed[x][y] = _MICE;
		miceShowTime[x][y] = gameRunTime;
		
		int randomMiceBlood = arc4random()%100;
		int blood = 1;
		if(randomMiceBlood < blood_1) blood = 1;
		if(randomMiceBlood < blood_2) blood = 2;
		if(randomMiceBlood < blood_3) blood = 3;		
		miceBlood[x][y] = blood;
		mice[x][y] = [CCSprite spriteWithFile:[NSString stringWithFormat:@"miceWith%dbloods.png",blood] rect: CGRectMake(0, 0, 100, 85)];
		mice[x][y].position = ccp(showPosition[x][y].v, showPosition[x][y].h);
		mice[x][y].opacity=0.4;
		mice[x][y].scale=0;
		[mice[x][y] runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.2f],[CCScaleTo actionWithDuration:0.2f scale:1],nil]];
		[self addChild:mice[x][y]];
		
	}
}


-(bool)isFull{
	int temp = 0;
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++)
			if(isUsed[i][j] != 0) temp++;
	if(temp == MaxRow * MaxLine) return true;
	return false;
}


-(void)miceDelete{
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++)
			// if Mucus is used, mice live more time (1s).
			if(isUsed[i][j] == _MICE && gameRunTime - miceShowTime[i][j] >= miceLiveTime + isMucus * 1.0){
					//[mice[i][j] runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.5f],nil]];

				[self removeChild:mice[i][j] cleanup:YES];
				escape++;
				isUsed[i][j] = 0;
				miceBlood[i][j] = 0;
			}
	[self crossRefresh];
	if(escape >= 3) [self gameOver];
}

-(void)setCross{
	for(int i = 0; i < 3; i++){
		cross[i] = [CCSprite spriteWithFile:@"cross_white.png" rect:CGRectMake(0, 0, 60, 60)];
		cross[i].position = ccp(70 , 700 - 80 * i);
		[self addChild:cross[i]];
	}
}

-(void)crossRefresh{
	for(int i = 0; i < 3; i++){
		[self removeChild:cross[i] cleanup:YES];
		if(i < escape) cross[i] = [CCSprite spriteWithFile:@"cross_red.png" rect:CGRectMake(0, 0, 60, 60)];
		else cross[i] = [CCSprite spriteWithFile:@"cross_white.png" rect:CGRectMake(0, 0, 60, 60)];
		cross[i].position = ccp(70 , 700 - 80 * i);
		[self addChild:cross[i]];
	}
}



-(void)propRefresh{	
	double random, proTemp;
	int x, y;
	for(int i = 1; i <= 5 + snakeNum; i++){
		random = (arc4random()%10000) / 100;
		if(i == 1) proTemp = proMucus;
		if(i == 2) proTemp = proFood;
		if(i == 3) proTemp = proNet;
		if(i == 4) proTemp = proToxic;
		if(i == 5) proTemp = proVirus;
		if(i >= 6) proTemp = proSnake;
		if(i >= 6 && isToxic) continue;
		if(random < proTemp){
			if([self isFull]) return;
			do{
				x = arc4random()%MaxRow;
				y = arc4random()%MaxLine;
			}while(isUsed[x][y] > 0);
			isUsed[x][y] = _PROP;
			propShowTime[x][y] = gameRunTime;			
			
			propKind[x][y] = i;
			if(i == 1) prop[x][y] = [CCSprite spriteWithFile:@"Mucus.png" rect:CGRectMake(0, 0, 100, 85)];
			if(i == 2) prop[x][y] = [CCSprite spriteWithFile:@"Food.png"  rect:CGRectMake(0, 0, 100, 85)];
			if(i == 3) prop[x][y] = [CCSprite spriteWithFile:@"Net.png"   rect:CGRectMake(0, 0, 100, 85)];
			if(i == 4) prop[x][y] = [CCSprite spriteWithFile:@"Toxic.png" rect:CGRectMake(0, 0, 100, 85)];
			if(i == 5) prop[x][y] = [CCSprite spriteWithFile:@"Virus.png" rect:CGRectMake(0, 0, 100, 85)];
			if(i >= 6) prop[x][y] = [CCSprite spriteWithFile:@"Snake.png" rect:CGRectMake(0, 0, 100, 85)];
			
			prop[x][y].position = ccp(showPosition[x][y].v, showPosition[x][y].h);
			prop[x][y].scale=0;
			prop[x][y].opacity=0.4;
			[prop[x][y] runAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.2f],[CCScaleTo actionWithDuration:0.2f scale:1],nil]];
			
			[self addChild:prop[x][y]];
		}
	}
}


-(void)propDelete{
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++)
			// if Mucus is used, prop live more time (1s).
			if(isUsed[i][j] == _PROP && gameRunTime - propShowTime[i][j] >= propLiveTime + isMucus * 1.0){
				[self removeChild:prop[i][j] cleanup:YES];
				isUsed[i][j] = 0;			
				propKind[i][j] = 0;
			}
}


-(void)ccTouchesBegan :(NSSet *)touches withEvent:(UIEvent *)event{
    if(isPause==TRUE)return;
	NSSet *allTouches = [event allTouches];
	int num = [allTouches count];
	
	for(int i = 0; i < num; i++){
		UITouch* touch =[[allTouches allObjects] objectAtIndex:i];
		CGPoint location = [touch locationInView: [touch view]];
		CGPoint point = [[CCDirector sharedDirector] convertToGL:location];//转换成gl视窗
		
		int X = -1, Y = -1;
		for(int i = 0; i < MaxRow; i++)
			for(int j = 0; j < MaxLine; j++){
				int mx = showPosition[i][j].v;
				int my = showPosition[i][j].h;
				if(mx - 50 <= point.x && point.x < mx + 50 &&my - 35 <= point.y && point.y < my + 35){
					X = i;
					Y = j;
			    }
			}				   
		if(X == -1 || Y == -1) continue;
		if(isUsed[X][Y] == 0) continue;
		if(isUsed[X][Y] == _MICE) [self touchMiceWithX:X Y:Y];
		if(isUsed[X][Y] == _PROP) [self touchPropWithX:X Y:Y];
	}
}


-(void)touchMiceWithX:(int)x Y:(int)y{
	[musiceHandle notifySoundOfMice];
    //[mice[x][y] runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.5f],nil]];
	
	[self removeChild:mice[x][y] cleanup:YES];
	
	if(isVirus){
        miceBlood[x][y] = 0;
        mice[x][y]=[CCSprite spriteWithFile:@"dishuHit.png" rect:CGRectMake(0,0,100,85)];
        mice[x][y].position = ccp(showPosition[x][y].v, showPosition[x][y].h);
        [self addChild:mice[x][y]];
        [mice[x][y] runAction:[CCFadeOut actionWithDuration:0.8f]];
		
		isUsed[x][y] = 0;
		score++;
		NSString* updateScore =[NSString stringWithFormat:@"Score: %d",score];
		[recordScore setString:updateScore];			
		return;
	}
	int blood = miceBlood[x][y];
	if(blood == 1){
		miceBlood[x][y] = 0;
        mice[x][y]=[CCSprite spriteWithFile:@"dishuHit.png" rect:CGRectMake(0,0,100,85)];
        mice[x][y].position = ccp(showPosition[x][y].v, showPosition[x][y].h);
        [self addChild:mice[x][y]];
        [mice[x][y] runAction:[CCFadeOut actionWithDuration:0.8f]];
		score++;
		NSString* updateScore =[NSString stringWithFormat:@"Score: %d",score];
		[recordScore setString:updateScore];
        isUsed[x][y] = 0;
		
		return;
	}
	miceBlood[x][y] = blood - 1;
	mice[x][y] = [CCSprite spriteWithFile:[NSString stringWithFormat:@"miceWith%dbloods.png",blood - 1] 
								     rect: CGRectMake(0, 0, 100, 85)];
	mice[x][y].position = ccp(showPosition[x][y].v, showPosition[x][y].h);
	[self addChild:mice[x][y]];
}


-(void)touchPropWithX:(int)x Y:(int)y{
	isUsed[x][y] = 0;
	switch (propKind[x][y]) {
		case 1:		ownMucusNum++;
            [prop[x][y] runAction:[CCMoveTo actionWithDuration: 0.8f position: ccp(150,402)]];	
            break;
		case 2:		ownFoodNum++;		
            [prop[x][y] runAction:[CCMoveTo actionWithDuration: 0.8f position: ccp(130,319)]];	
            break;
		case 3:		ownNetNum++;	
            [prop[x][y] runAction:[CCMoveTo actionWithDuration: 0.8f position: ccp(110,236)]];	
            break;
		case 4:		ownToxicNum++;
            [prop[x][y] runAction:[CCMoveTo actionWithDuration: 0.8f position: ccp(90,153)]];	
            break;
		case 5:		ownVirusNum++;
            [prop[x][y] runAction:[CCMoveTo actionWithDuration: 0.8f position: ccp(70,70)]];	
            break;
		default:    [self snakeAction];
                    [musiceHandle notifySoundOfSnake]; 
                    [self removeChild:prop[x][y] cleanup:YES];
                    break;
	}
	
    
	NSString* updateMucus =[NSString stringWithFormat:@"x%d",ownMucusNum];
	[recordMucus setString:updateMucus];			
	
	NSString* updateFood =[NSString stringWithFormat:@"x%d",ownFoodNum];
	[recordFood setString:updateFood];			
	
	NSString* updateNet =[NSString stringWithFormat:@"x%d",ownNetNum];
	[recordNet setString:updateNet];			
	
	NSString* updateToxic =[NSString stringWithFormat:@"x%d",ownToxicNum];
	[recordToxic setString:updateToxic];			
	
	NSString* updateVirus =[NSString stringWithFormat:@"x%d",ownVirusNum];
	[recordVirus setString:updateVirus];			
}



-(void)mucusAction:(id)sender{
	if((ownMucusNum == 0)||(canBeUsedOfMucus==FALSE)||(isPause==TRUE)) return;
    
    canBeUsedOfMucus=FALSE;
	ownMucusNum--;
	//[sender runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.0f],[CCFadeIn actionWithDuration:1.5f],nil]];
	NSString* update =[NSString stringWithFormat:@"x%d",ownMucusNum];
	
	[recordMucus setString:update];		
	
	isMucus = true;
	runMucusTime = totMucusTime;
    
    [self schedule:@selector(showColdEffectOfMucus) interval:0.5];
    
}


-(void)foodAction:(id)sender{
	if((ownFoodNum == 0)||(canBeUsedOfFood==FALSE)||(isPause==TRUE)) return;
    
    canBeUsedOfFood=FALSE;
	ownFoodNum--;
	//[sender runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.0f],[CCFadeIn actionWithDuration:1.5f],nil]];
	NSString* update =[NSString stringWithFormat:@"x%d",ownFoodNum];
	[recordFood setString:update];			
	
	isFood = true;
	runFoodTime = totFoodTime;
    [self schedule:@selector(showColdEffectOfFood) interval:0.2];
    
}


-(void)netAction:(id)sender{
	if((ownNetNum == 0) ||(canBeUsedOfNet==FALSE)||(isPause==TRUE))return;
    
    canBeUsedOfNet=FALSE;
	ownNetNum--;
    //[sender runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.0f],[CCFadeIn actionWithDuration:1.5f],nil]];
    
	NSString* update =[NSString stringWithFormat:@"x%d",ownNetNum];
	[recordNet setString:update];			
	
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++)
			if(isUsed[i][j]==_MICE){
				isUsed[i][j] = 0;
				miceBlood[i][j] = 0;
				score++;
				NSString* updateScore =[NSString stringWithFormat:@"Score: %d",score];
				[recordScore setString:updateScore];	
				[self removeChild:mice[i][j] cleanup:YES];
			}
    [self schedule:@selector(showColdEffectOfNet) interval:0.8];
}


-(void)toxicAction:(id)sender{
	if((ownToxicNum == 0)||(canBeUsedOfToxic==FALSE)||(isPause==TRUE)) return;
    
    canBeUsedOfToxic=FALSE;
	ownToxicNum--;
    //[sender runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.0f],[CCFadeIn actionWithDuration:1.5f],nil]];
    NSString* update =[NSString stringWithFormat:@"x%d",ownToxicNum];
	[recordToxic setString:update];			
	
	isToxic = true;
	runToxicTime = totToxicTime;
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++)
			// if Mucus is used, prop live more time (1s).
			if(isUsed[i][j] == _PROP && propKind[i][j] >= 6){
				[self removeChild:prop[i][j] cleanup:YES];
				isUsed[i][j] = 0;			
				propKind[i][j] = 0;
			}
    [self schedule:@selector(showColdEffectOfToxic) interval:0.8];
    
}


-(void)virusAction:(id)sender{
	if((ownVirusNum == 0)||(canBeUsedOfVirus==FALSE)||(isPause==TRUE)) return;
    
    canBeUsedOfVirus=FALSE;
	ownVirusNum--;
    // [sender runAction:[CCSequence actions:[CCBlink actionWithDuration:1.0f blinks:3],[CCFadeOut actionWithDuration:0.0f],[CCFadeIn actionWithDuration:1.5f],nil]];
	NSString* update =[NSString stringWithFormat:@"x%d",ownVirusNum];
	[recordVirus setString:update];
	isVirus = true;
	runVirusTime = totVirusTime;
    [self schedule:@selector(showColdEffectOfVirus) interval:1.0];
    
}


-(void)snakeAction{
	escape++;
    [self crossRefresh];
    if(escape >= 3) [self gameOver];
}


-(void)updateGameTime{	
	int sec,min;
	sec = (int) (gameRunTime);
	min = sec / 60; 
	sec = sec % 60;
	NSString* updateTime;
	if(min < 10){
		if(sec < 10) updateTime =[NSString stringWithFormat:@"0%d:0%d", min, sec];
		else updateTime =[NSString stringWithFormat:@"0%d:%d", min, sec];
	}
	else {
		if(sec < 10) updateTime =[NSString stringWithFormat:@"%d:0%d", min, sec];
		else updateTime =[NSString stringWithFormat:@"%d:%d", min, sec];
		
	}
	[timeShow setString:updateTime];	
}

-(void)gameOver{
	[self unscheduleAllSelectors];
	for(int i = 0; i < MaxRow; i++)
		for(int j = 0; j < MaxLine; j++){
			if(isUsed[i][j] == _MICE){
				[self removeChild:mice[i][j] cleanup:YES];
			}
			if(isUsed[i][j] == _PROP){
				[self removeChild:prop[i][j] cleanup:YES];
			}
		}
	tempScore = score;
	[SceneManager goGameOver:nil];
}


-(void)dealloc{
	[super dealloc];
}

#pragma mark -
#pragma mark FunctionForReady
-(void) onEnterTransitionDidFinish{
	[super onEnterTransitionDidFinish];
	if(startArray){
		[self showStartHint];
	}
}

-(void) showStartHint{
	if (readyIndex >= [startArray count]) {
		[startArray release];
		startArray = nil;
	    self.isTouchEnabled = YES;
		[self newGame];
		
	}
	else {
		NSString *readyText = [startArray objectAtIndex:readyIndex];		
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:readyText fontName:@"nevis.ttf" fontSize:60.0f];
		label.position=ccp(ipadWidth/2,ipadLength/2);
		label.opacity = 170;
		CCAction *action = [CCSequence actions:
							[CCSpawn actions:
							 [CCScaleTo actionWithDuration:0.8f scaleX:2.5f scaleY:2.5f],
							 [CCSequence actions: 
							  [CCFadeTo actionWithDuration: 0.6f opacity:255],
							  [CCFadeTo actionWithDuration: 0.2f opacity:128],
							  nil],
							 nil],
							[CCCallFuncN actionWithTarget:self  selector:@selector(startHintCallback:)],
							nil
							];
		[self addChild:label z:5];
		[label runAction: action];		
		readyIndex++;
	}
}

-(void) startHintCallback: (id) sender{
	[self removeChild:sender cleanup:YES];
	[self showStartHint];
}

#pragma mark -
#pragma mark Cold Effect

-(void)showColdEffectOfMucus
{
    NSString* coldString = [NSString stringWithFormat:@"cold%d.png",coldNowOfMucus];
    if(coldNowOfMucus>=2)
    {
        [self removeChild:coldEffectOfMucus cleanup:YES];
    }
    coldEffectOfMucus=[CCSprite spriteWithFile:coldString rect:CGRectMake(0,0,240,234)];
    coldEffectOfMucus.position=ccp(157.5,401.3);
    [self addChild:coldEffectOfMucus z:3];
    coldNowOfMucus++;
    if (coldNowOfMucus>=10) {
        [self removeChild:coldEffectOfMucus cleanup:YES];
        [self unschedule:@selector(showColdEffectOfMucus)];
        coldNowOfMucus=1;
        canBeUsedOfMucus=TRUE;
        return ;
    }
}

-(void)showColdEffectOfVirus
{
    NSString* coldString = [NSString stringWithFormat:@"cold%d.png",coldNowOfVirus];
    if(coldNowOfVirus>=2)
    {
        [self removeChild:coldEffectOfVirus cleanup:YES];
    }
    coldEffectOfVirus=[CCSprite spriteWithFile:coldString rect:CGRectMake(0,0,240,234)];
    coldEffectOfVirus.position=ccp(76.5,69);
    [self addChild:coldEffectOfVirus z:3];
    coldNowOfVirus++;
    if (coldNowOfVirus>=10) {
        [self removeChild:coldEffectOfVirus cleanup:YES];
        [self unschedule:@selector(showColdEffectOfVirus)];
        coldNowOfVirus=1;
        canBeUsedOfVirus=TRUE;
        return ;
    }
}

-(void)showColdEffectOfToxic
{
    NSString* coldString = [NSString stringWithFormat:@"cold%d.png",coldNowOfToxic];
    if(coldNowOfToxic>=2)
    {
        [self removeChild:coldEffectOfToxic cleanup:YES];
    }
    coldEffectOfToxic=[CCSprite spriteWithFile:coldString rect:CGRectMake(0,0,240,234)];
    coldEffectOfToxic.position=ccp(96.5,151.9);
    [self addChild:coldEffectOfToxic z:3];
    coldNowOfToxic++;
    if (coldNowOfToxic>=10) {
        [self removeChild:coldEffectOfToxic cleanup:YES];
        [self unschedule:@selector(showColdEffectOfToxic)];
        coldNowOfToxic=1;
        canBeUsedOfToxic=TRUE;
        return ;
    }
}

-(void)showColdEffectOfFood
{
    NSString* coldString = [NSString stringWithFormat:@"cold%d.png",coldNowOfFood];
    if(coldNowOfFood>=2)
    {
        [self removeChild:coldEffectOfFood cleanup:YES];
    }
    coldEffectOfFood=[CCSprite spriteWithFile:coldString rect:CGRectMake(0,0,240,234)];
    coldEffectOfFood.position=ccp(136.4,315.6);
    [self addChild:coldEffectOfFood z:3];
    coldNowOfFood++;
    if (coldNowOfFood>=10) {
        [self removeChild:coldEffectOfFood cleanup:YES];
        [self unschedule:@selector(showColdEffectOfFood)];
        coldNowOfFood=1;
        canBeUsedOfFood=TRUE;
        return ;
    }
}

-(void)showColdEffectOfNet
{
    NSString* coldString = [NSString stringWithFormat:@"cold%d.png",coldNowOfNet];
    if(coldNowOfNet>=2)
    {
        [self removeChild:coldEffectOfNet cleanup:YES];
    }
    coldEffectOfNet=[CCSprite spriteWithFile:coldString rect:CGRectMake(0,0,240,234)];
    coldEffectOfNet.position=ccp(116.5,235);
    [self addChild:coldEffectOfNet z:3];
    coldNowOfNet++;
    if (coldNowOfNet>=10) {
        [self removeChild:coldEffectOfNet cleanup:YES];
        [self unschedule:@selector(showColdEffectOfNet)];
        coldNowOfNet=1;
        canBeUsedOfNet=TRUE;
        return ;
    }
}



@end