	//
	//  EndlessLayer.m
	//  Fishero
	//
	//  Created by 吴 wuziqi on 11-3-6.
	//  Copyright 2011年 同济大学. All rights reserved.
	//

#import "EndlessLayer.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "LoseLayer.h"
#import "WinLayer.h"
#import "saveData.h"
#import "PauseLayer.h"

@implementation EndlessLayer

-(id)init
{
    self=[super init];
    if(self)
    {
		selectLayer=0;
		enemyLevel = 1;
		
	    endlessScore=0;
		isPause = false;
		
		
		CCSprite* backSprite=[CCSprite spriteWithFile:@"back.png"];
		CCMenuItemSprite* backMenu=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(goMenu)];
		CCSprite* pauseSprite=[CCSprite spriteWithFile:@"pause_1.png"];
		CCMenuItemSprite* pauseMenu=[CCMenuItemSprite itemFromNormalSprite:pauseSprite selectedSprite:nil target:self selector:@selector(goPause)];
		CCMenu* menu=[CCMenu menuWithItems:backMenu,pauseMenu,nil];
		menu.position=ccp(500,100);
		[menu alignItemsHorizontally];
		[self addChild:menu z:1 tag:9];
		
		
		[self initSprit];
        [self initBoss];
        [self addChild:enemy z:0 tag:1];
        [self addChild:hero z:0 tag:2];
        [self initController];
		[self moveItself];
        [self schedule:@selector(moveItself) interval:moveInterval];
        [self schedule:@selector(shootToHero) interval:attackInterval];
    }
    
    return self;
}

-(void)initSprit{
	CCSprite* background=[CCSprite spriteWithFile:@"endlessBackground.png"];
	background.position=ccp(ipadWidth/2,ipadLength/2);
	[self addChild:background z:0 tag:5];
	CCSprite* vsText=[CCSprite spriteWithFile:@"vsText.png"];
	vsText.position=ccp(ipadWidth/2,ipadLength/2+300);
	[self addChild:vsText z:0 tag:6];
	
	rightBlood=[CCSprite spriteWithFile:@"leftBlood9.png"];
	rightBlood.position=ccp(ipadWidth/2+278,ipadLength/2+295);
	[self addChild:rightBlood z:1 tag:7];
	
	
	leftBlood=[CCSprite spriteWithFile:@"rightBlood9.png"];
	leftBlood.position=ccp(ipadWidth/2-278,ipadLength/2+295);
	[self addChild:leftBlood z:1 tag:8];

	if([saveData getShelter] == 1){
		isShelter = true;
 		hero=[CCSprite spriteWithFile:@"newheroShelter.png"];
	}
	else{
		isShelter = false;
		hero=[CCSprite spriteWithFile:@"newhero.png"];
	}
	hero.position=ccp(ipadWidth/2 - 300,ipadLength/2);
	hero.scale = 0.3;
	heroBlood = 9;
}

-(void)initBoss{
	enemy=[CCSprite spriteWithFile:@"fish1.png"];
	enemy.position = ccp(ipadWidth / 2 + 300,ipadLength / 2);
	enemy.scale = 0.6;

	enemyBlood = 9;
	enemySpeed = 100;
	moveInterval = 3.0;
	attackInterval = 1.0;
	
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
    [self addChild:controller z:1 tag:3];
    
    CCMenuItemImage * menuItem1 = [CCMenuItemImage itemFromNormalImage:@"button_a1.png"
                                                         selectedImage: @"button_a2.png"
                                                                target:self
                                                              selector:@selector(buttonAClicked:)];
    
    
		// Create a menu and add your menu items to it
    CCMenu * myMenu = [CCMenu menuWithItems:menuItem1, nil];
    
    [myMenu alignItemsVertically];
    
    myMenu.position=ccp(900,100);
    [self addChild:myMenu z:1 tag:4];
	
}

#pragma mark -
#pragma mark JoyStickDelegae

- (void) onCCJoyStickUpdate:(CCNode*)sender Angle:(float)angle Direction:(CGPoint)direction Power:(float)power
{
	if (sender==controller) {
		hero.rotation = -angle;
		
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
	NSString* string=[NSString stringWithFormat:@"paopao%d.png",[saveData getPower]];
	CCSprite *bullet=[CCSprite spriteWithFile:string];
	
	bullet.position=hero.position;
	
	float ran = -hero.rotation * 3.14159 / 180;
	float vx = cos(ran) * 400;
	float vy = sin(ran) * 400;
    [self addChild:bullet];
	[self checkEnemyCollision:bullet.position towards:enemy.position];
	id moveact=[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(bullet.position.x+vx,bullet.position.y+vy)] rate:1];
	id movedone=[CCCallFuncND actionWithTarget:self selector:@selector(onBulletMoveDone:data:) data:bullet ];
	[bullet runAction:[CCSequence actions:moveact, movedone, nil]];
}

-(void)onBulletMoveDone:(id)sender data:(CCSprite*)bullet{
    [self checkEnemyCollision:bullet.position towards:enemy.position];
	[self removeChild:bullet cleanup:YES];
}

	// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
		// in case you have something to dealloc, do it in this method
		// in this particular example nothing needs to be released.
		// cocos2d will automatically release all the children (Label)
	
		// don't forget to call "super dealloc"
    
    [self removeChildByTag:1 cleanup:YES ];
    [self removeChildByTag:2 cleanup:YES ];
    [self removeChildByTag:3 cleanup:YES ];
    [self removeChildByTag:4 cleanup:YES ];
    [self removeChildByTag:5 cleanup:YES ];
    [self removeChildByTag:6 cleanup:YES ];
    [self removeChildByTag:7 cleanup:YES ];
    [self removeChildByTag:8 cleanup:YES ];
	[self removeChildByTag:9 cleanup:YES ];
    
	[super dealloc];
}

#pragma mark -
#pragma mark enemy action

-(void)moveItself
{
    CGPoint reach;
    reach.x = arc4random() % 1024;
    reach.y = arc4random() % 768;
	
	reach = hero.position;
	enemy.rotation =  -atan2(reach.y - enemy.position.y, reach.x - enemy.position.x)/(3.14159/180);
	double dist = ccpDistance(enemy.position, reach);
	
	[enemy stopAllActions];
	if(fabs(enemy.rotation) >= 90){
		[enemy runAction:[CCSequence actions:
						  [CCFlipY actionWithFlipY:YES],
						  [CCMoveTo actionWithDuration:dist / enemySpeed position:reach],
						  nil]];
	}
	else {
		[enemy runAction:[CCSequence actions:
						  [CCFlipY actionWithFlipY:NO],
						  [CCMoveTo actionWithDuration:dist / enemySpeed position:reach],
						  nil]];
	}
	
}

-(void)shootToHero
{
	CCSprite *bullet=[CCSprite spriteWithFile:@"paopao1.png"];
	bullet.position = enemy.position;
	float ran = -enemy.rotation * 3.14159 / 180;
	float vx = cos(ran) * 400;
	float vy = sin(ran) * 400;
    
    [self addChild:bullet];
    [self checkHeroCollision:bullet.position towards:hero.position];
	id moveact=[CCEaseIn actionWithAction:[CCMoveTo actionWithDuration:0.5 position:ccp(bullet.position.x+vx,bullet.position.y+vy)] rate:1];
	id movedone=[CCCallFuncND actionWithTarget:self selector:@selector(onShootEnded:data:) data:bullet ];
	[bullet runAction:[CCSequence actions:moveact, movedone, nil]];
}

-(void)onShootEnded:(id)sender data:(CCSprite*)bullet
{
    [self checkHeroCollision:bullet.position towards:hero.position];
    [self removeChild:bullet cleanup:YES];
    
}

#pragma mark -
#pragma mark check&&update

-(void)checkEnemyCollision:(CGPoint)bullet towards:(CGPoint)opponent
{
    if ((bullet.x>opponent.x-200)&&(bullet.x<opponent.x+200)&&(bullet.y>opponent.y-200)&&(bullet.y<opponent.y+200)) {
        enemyBlood--;
        if (enemyBlood==0) {
			[self unschedule:@selector(moveItself) ];
			[self unschedule:@selector(shootToHero)];
			endlessScore+=enemyLevel*10;
			[self bossRefresh];
        }
		else if(enemyBlood > 0){
			NSString* stringBlppd=[NSString stringWithFormat:@"leftBlood%d.png",enemyBlood];
			[self removeChild:rightBlood cleanup:YES];
			rightBlood=[CCSprite spriteWithFile:stringBlppd];
			rightBlood.position=ccp(ipadWidth/2+278,ipadLength/2+295);
			[self addChild:rightBlood z:1 tag:7];
		}
	}
}

-(void)checkHeroCollision:(CGPoint)bullet towards:(CGPoint)temp
{
    if ((bullet.x>temp.x-100)&&(bullet.x<temp.x+100)&&(bullet.y>temp.y-100)&&(bullet.y<temp.y+100)) {
		if(isShelter){
			NSLog(@"temp");
			isShelter = false;
			CGPoint tempPoint = hero.position;
			int tempRotation = hero.rotation;
			[self removeChild:hero cleanup:YES];
			
			hero = [CCSprite spriteWithFile:@"newhero.png"];
			hero.position = tempPoint;
			hero.rotation = tempRotation;
			hero.scale = 0.3;
			[self addChild:hero];

			return;
		}
		heroBlood--;
        if (heroBlood == 0) {
			[self unschedule:@selector(moveItself) ];
			[self unschedule:@selector(shootToHero)];
			controller.delegate=nil;
			int scoreTemp=[saveData getScore];
			scoreTemp+=endlessScore;
			[saveData setScore:scoreTemp];
			[self unscheduleAllSelectors];
			enemy.position = ccp(-1000, -1000);
			[enemy stopAllActions];
			[self goLose];
        }
		else  if(heroBlood>0){
			NSString* stringBlppd=[NSString stringWithFormat:@"rightBlood%d.png",heroBlood];
			[self removeChild:leftBlood cleanup:YES];
			leftBlood=[CCSprite spriteWithFile:stringBlppd];
			leftBlood.position=ccp(ipadWidth/2-278,ipadLength/2+295);
			[self addChild:leftBlood z:1 tag:8];
		}
	}
}

-(void)goLose
{
	CCLayer* loseLayer=[LoseLayer node];
	[self addChild:loseLayer z:4 tag:10];
		//[SceneManager goMenu];
}


-(void)startSelector:(id)sender
{
	[self moveItself];
	[self schedule:@selector(moveItself) interval:moveInterval];
	[self schedule:@selector(shootToHero) interval:attackInterval];
	enemyBlood = 9;
	NSString* stringBlood=[NSString stringWithFormat:@"leftBlood%d.png",enemyBlood];
	[self removeChild:rightBlood cleanup:YES];
	rightBlood=[CCSprite spriteWithFile:stringBlood];
	rightBlood.position=ccp(ipadWidth/2+278,ipadLength/2+295);
	[self addChild:rightBlood z:1 tag:7];
}

-(void)bossRefresh{
	[self unschedule:@selector(moveItself) ];
	[self unschedule:@selector(shootToHero)];
	
	if(enemyLevel < 10)	enemyLevel++;
	
	if(enemyLevel == 2){		
		moveInterval = 2.0;
		attackInterval = 0.8;
		enemySpeed = 400;
	}
	if(enemyLevel == 3){
		moveInterval = 1.5;
		attackInterval = 0.6;
		enemySpeed = 450;
		
	}
	if(enemyLevel >= 4){
		moveInterval = 1.0;
		attackInterval = 0.3;
		enemySpeed = 500;		
	}

	[enemy stopAllActions];
	[self removeChild:enemy cleanup:YES];

	enemy=[CCSprite spriteWithFile: [NSString stringWithFormat:@"fish%d.png", enemyLevel]];
	enemy.scale = 0.6;
	enemy.position = ccp((arc4random() % 900) + 100, (arc4random() % 600) + 100);
	[self addChild:enemy];
	[enemy runAction: [CCSequence actions:
					   [CCBlink actionWithDuration:1.0f blinks:5],
					   [CCCallFunc actionWithTarget:self selector:@selector(startSelector:)],
					   nil]];
}

-(void)goMenu
{
	int tempScore=[saveData getScore];
	tempScore+=endlessScore;
	[saveData setScore:tempScore];
	[[CCDirector sharedDirector] resume];
	[SceneManager goMenu];
}

-(void)goPause
{
	if(isPause) return;
	isPause = true;
	CCLayer* newLayer=[PauseLayer node];
	[self addChild:newLayer z:5];
	[[CCDirector sharedDirector] pause];
}


@end
