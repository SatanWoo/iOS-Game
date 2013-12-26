	//
	//  AdventureLayer.m
	//  Fishero
	//
	//  Created by 吴 wuziqi on 11-3-7.
	//  Copyright 2011年 同济大学. All rights reserved.
	//

#import "AdventureLayer.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "LoseLayer.h"
#import "WinLayer.h"
#import "SelectLayer.h"
#import "PauseLayer.h"
#import "saveData.h"

@implementation AdventureLayer


-(id)init
{
    self =[super init];
    if (self){
		selectLayer=1;
		advenScore=0;
		isPause = false;
		
		CCSprite* backSprite=[CCSprite spriteWithFile:@"back.png"];
		CCMenuItemSprite* backMenu=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(goMini)];
		CCSprite* pauseSprite=[CCSprite spriteWithFile:@"pause_1.png"];
		CCMenuItemSprite* pauseMenu=[CCMenuItemSprite itemFromNormalSprite:pauseSprite selectedSprite:nil target:self selector:@selector(goPause)];
		CCMenu* menu=[CCMenu menuWithItems:backMenu,pauseMenu,nil];
		menu.position=ccp(500,100);
		[menu alignItemsHorizontally];
		[self addChild:menu z:1 tag:4];
		
		[self initData];
        [self initController];
        [self initEnemy];
        [self schedule:@selector(generateEnemy) interval:1.0f];
        [self schedule:@selector(checkForEat) interval:0.0f];
    }
    return self;
}

-(void)initData
{
	if(level == 1){
		maxOfEnemy = 5;
		speedOfEnemy = 150;
	}
	
	if(level == 2){
		maxOfEnemy = 7;
		speedOfEnemy = 250;
	}
	
	if(level == 3){
		maxOfEnemy = 10;
		speedOfEnemy = 350;
	}
	
	hero = [CCSprite spriteWithFile:@"newhero.png"];
	hero.position = ccp(ipadWidth / 2,ipadLength / 2);
	heroScale =  hero.scale = 0.3;
	[self addChild:hero z:2];
	heroScale = 1.0f;
}

-(void)initController
{
    controller=[CCJoyStick initWithBallRadius:25 MoveAreaRadius:65 isFollowTouch:NO isCanVisible:YES isAutoHide:NO hasAnimation:YES];
    [controller setBallTexture:@"Ball.png"];
    [controller setDockTexture:@"Dock.png"];
    [controller setStickTexture:@"Stick.jpg"];
    [controller setHitAreaWithRadius:100];
    
    controller.position=ccp(100,100);
    controller.delegate=self;
    [self addChild:controller z:1 tag:2];
}

#pragma mark -
#pragma mark Game Function

-(void)initEnemy{
	for(int i = 0; i < maxOfEnemy; i++){
		NSLog(@"%d", i);
		enemy[i] = [CCSprite spriteWithFile:[NSString stringWithFormat:@"fish%d.png",i + 1]];
		enemy[i].scale = 0.3 + 0.05 * i;
		enemy[i].opacity = 0;
		[self addChild:enemy[i]];
	}
}

-(void)generateEnemy{
    int i = arc4random() % maxOfEnemy;
	if (enemy[i].opacity == 0) {		
		int x = arc4random() % 2;
		int y = arc4random() % 668 + 50;
		int dist = 1624;
		enemy[i].position = ccp(- 200 + dist * x, y);
		reachPoint[i] = ccp(- 200 + dist * (x^1), y);
		if(x == 0){
			[enemy[i] runAction:[CCSequence actions:
								 [CCFlipX actionWithFlipX:NO],
								 [CCFadeIn actionWithDuration:0.0f],
								 [CCMoveTo actionWithDuration:dist / speedOfEnemy position:reachPoint[i]],
								 [CCFadeOut actionWithDuration:0.0f],
								 nil]];
		}else{
			[enemy[i] runAction:[CCSequence actions:
								 [CCFlipX actionWithFlipX:YES],
								 [CCFadeIn actionWithDuration:0.0f],
								 [CCMoveTo actionWithDuration:dist / speedOfEnemy position:reachPoint[i]],
								 [CCFadeOut actionWithDuration:0.0f],
								 nil]];
		}
    }
	
}

-(void)checkForEat{
	
    float temp = 100.0 * hero.scale;
	NSLog(@"%g", temp);
    for(int i = 0; i < maxOfEnemy; i++){
		if(enemy[i].opacity == 0) continue;
		if(ccpDistance(hero.position, enemy[i].position) >= temp + enemy[i].scale * 100) continue;
		
			//gameOver
		if(hero.scale < enemy[i].scale){
			[self removeChild:hero cleanup:YES];
			controller.delegate = nil;
			for (int i=0; i<maxOfEnemy; i++) {
				
				[enemy[i] stopAllActions];
			}
			[self unscheduleAllSelectors];
				//			[self unschedule:@selector(generateEnemy)];
			int scoreTemp=[saveData getScore];
			scoreTemp+=advenScore;
			[saveData setScore:scoreTemp];
			CCLayer* newLayer=[LoseLayer node];
			[self addChild:newLayer z:5];
			break;
			
		}
			//eatFish	
    	if(hero.scale >= enemy[i].scale){
			enemy[i].opacity = 0;
			[enemy[i] stopAllActions];
			CGPoint point = hero.position;
			heroScale = hero.scale;
			[self removeChild:hero cleanup:YES];
			advenScore++;
			if (advenScore>level*20) {
				for (int i=0; i<maxOfEnemy; i++) {
					[enemy[i] stopAllActions];
				}
				[self unschedule:@selector(generateEnemy)];
				CCLayer* newLayer=[WinLayer node];
				[self addChild:newLayer z:5];
				int scoreTemp=[saveData getScore];
				scoreTemp+=advenScore;
				[saveData setScore:scoreTemp];
			}
			
			hero = [CCSprite spriteWithFile:@"newheroEat.png"];
			hero.scale = heroScale;
			hero.position = point;
			[self addChild:hero z:0];
			[self scaleBack];
			
		}
	}
}

-(void)scaleBack{
    [hero runAction:[CCSequence actions:
					 [CCDelayTime actionWithDuration:0.5f],
					 [CCCallFuncN  actionWithTarget:self selector:@selector(backToNormal)],
					 nil]];
}

-(void)backToNormal{
	CGPoint point = hero.position;
	heroScale = hero.scale;
    [self removeChild:hero cleanup:YES];
    hero = [CCSprite spriteWithFile:@"newhero.png"];
	
	hero.scale = heroScale + 0.05;
	if(hero.scale > 1) hero.scale = 1;
	NSLog(@"%g", hero.scale);
    hero.position = point;
    [self addChild:hero z:0];
}

#pragma mark -
#pragma mark JoyStickDelegae

- (void) onCCJoyStickUpdate:(CCNode*)sender Angle:(float)angle Direction:(CGPoint)direction Power:(float)power
{
	if (sender==controller) {
		hero.rotation = -angle;
			//		NSLog(@"%f", hero.rotation);
		
		float nextx=hero.position.x;
		float nexty=hero.position.y;
		
		nextx+=direction.x * (power*8);
		nexty+=direction.y * (power*8);
        
        if (direction.x<0) {
            [hero runAction:[CCFlipY actionWithFlipY:YES]];
        }
        else
        {
            [hero runAction:[CCFlipY actionWithFlipY:NO]];
        }
        
		if(nexty>768){
			nexty=768-25;
		}
		if(nexty<0){
			nexty=0+25;
		}
		if(nextx<0){
			nextx=0+35;
		}
		if(nextx>1024){
			nextx=1024-35;
		}
		
		hero.position=ccp(nextx,nexty);
	}
}

- (void) onCCJoyStickActivated:(CCNode*)sender
{
	if (sender==controller) {
		[controller setBallTexture:@"Ball_hl.png"];
		[controller setDockTexture:@"Dock_hl.png"];
	}
}
- (void) onCCJoyStickDeactivated:(CCNode*)sender
{
	if (sender==controller) {
		[controller setBallTexture:@"Ball.png"];
		[controller setDockTexture:@"Dock.png"];
	}
}

-(void)buttonAClicked: (CCMenuItem  *) menuItem
{
	CCSprite *bullet=[CCSprite spriteWithFile:@"paopao.png"];
	
	bullet.position=hero.position;
	
	float ran=-hero.rotation*3.14159/180;
	float vx=cos(ran)*400;
	float vy=sin(ran)*400;
    
    [self addChild:bullet];
	
	id moveact=[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:.5 position:ccp(bullet.position.x+vx,bullet.position.y+vy)] rate:1];
	id movedone=[CCCallFuncND actionWithTarget:self selector:@selector(onBulletMoveDone:data:) data:bullet];
	[bullet runAction:[CCSequence actions:moveact,movedone,nil]];
	
	
}

-(void)onBulletMoveDone:(id)sender data:(CCSprite*)bullet
{
	[self removeChild:bullet cleanup:YES];
}

-(void)goMini
{
		//[MusicHandle stopEffect];
	[[CCDirector sharedDirector] resume];
	[SceneManager goSelect];
}

-(void)goPause
{
	if(isPause) return;
	isPause = true;
	CCLayer* newLayer=[PauseLayer node];
	[self addChild:newLayer z:5];
	[[CCDirector sharedDirector] pause];
}



-(void)dealloc
{
		//[self removeChildByTag:1 cleanup:YES];
    [self removeChildByTag:2 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
	[self removeChildByTag:4 cleanup:YES];
    [super dealloc];
}
@end
