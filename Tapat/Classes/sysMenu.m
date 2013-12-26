//
//  sysMenu.m
//  tapat
//
//  Created by 吴 wuziqi on 10-11-11.
//  Copyright 2010 同济大学. All rights reserved.
//

#import "sysMenu.h"
#import "cocos2d.h"
#import "SceneManager.h"
#import "GameConfig.h"
#import "saveSetting.h"
#import "musiceHandle.h"

@implementation sysMenu
/*+(id)scene
{
	CCScene* scene =[CCScene node];
	
	CCScene* layer =[sysMenu node];
	
	[scene addChild:layer];
	
	return  scene;
}*/

-(id)init
{
	self =[super init];
	
	if (self) {
		
		
		self.isTouchEnabled = YES;
		//[self gameCenterFunction];
		
		CCSprite* background =[CCSprite spriteWithFile:@"caidan.png" rect:CGRectMake(0, 0, ipadWidth, ipadLength)];
		background.position=ccp(ipadWidth/2,ipadLength/2);
		[self addChild:background z:0  ];
        
        CCSprite* classDe=[CCSprite spriteWithFile:@"classical.png" rect:CGRectMake(0, 0, 252, 82)];
		CCSprite* classSe=[CCSprite spriteWithFile:@"classicalSe.png" rect:CGRectMake(0, 0, 248, 155)];
		CCMenuItem* classButton=[CCMenuItemSprite itemFromNormalSprite:classDe selectedSprite:classSe target:self selector:@selector(classical:)];
		classButton.scale=1;
		CCMenu* classMenu=[CCMenu menuWithItems:classButton,nil];
		classMenu.position=ccp(ipadWidth/2-275,ipadLength/2);
		[self addChild:classMenu z:1];

		
		
		
		CCSprite* advenDe =[CCSprite spriteWithFile:@"adventure.png" rect:CGRectMake(0, 0, 252, 83)];
		CCSprite* advenSe=[CCSprite spriteWithFile:@"adventureSe.png" rect:CGRectMake(0, 0,248, 155)];
		CCMenuItem* advenButton=[CCMenuItemSprite itemFromNormalSprite:advenDe selectedSprite:advenSe target:self selector:@selector(adventure:)];
		advenButton.scale=1;
		CCMenu* advenMenu =[CCMenu menuWithItems:advenButton,nil];
		advenMenu.position=ccp(ipadWidth/2-215,ipadLength/2-100);
		[self addChild:advenMenu z:1];
		
		
		CCSprite* optionDe=[CCSprite spriteWithFile:@"option.png" rect:CGRectMake(0, 0, 253, 83)];
		CCSprite* optionSe=[CCSprite spriteWithFile:@"optionSe.png" rect:CGRectMake(0, 0, 248, 155)];
		CCMenuItem* options=[CCMenuItemSprite itemFromNormalSprite:optionDe selectedSprite:optionSe target:self selector:@selector(setting:)];
		options.scale=1;
		CCMenu* optionMenu=[CCMenu menuWithItems:options,nil];
		optionMenu.position=ccp(ipadWidth/2-180,ipadLength/2-210);
		[self  addChild:optionMenu z:1];
        
        CCSprite* aboutDe = [CCSprite spriteWithFile:@"about.png" rect:CGRectMake(0, 0, 253, 81)];
		CCSprite* aboutSe=[CCSprite spriteWithFile:@"aboutSe.png" rect:CGRectMake(0, 0, 248, 155)];
		CCMenuItem* aboutGame =[CCMenuItemSprite itemFromNormalSprite:aboutDe selectedSprite:aboutSe target:self selector:@selector(about:)];
		aboutGame.scale=1;
		CCMenu* aboutMenu =[CCMenu menuWithItems:aboutGame ,nil];
		aboutMenu.position=ccp(ipadWidth/2-120,ipadLength/2-310);
		[self addChild:aboutMenu z:1];
		
		
		
		CCSprite* finger =[CCSprite spriteWithFile:@"press.png" rect:CGRectMake(0, 0, 80, 80)];
		finger.position=ccp(900,430);
		id action =[CCRepeatForever actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:1.0f scale:1.5],[CCScaleTo actionWithDuration:1.0f scale:1],nil]];
		[finger runAction:action];
		[self addChild:finger z:0];
		
		
		
		[self schedule:@selector(checkForState)];
		
		}
	
	    	
	return self;
	
}




-(void)adventure:(id)sender
{
	[SceneManager goAdventure:sender];
}

-(void)classical:(id)sender
{
	[SceneManager goClassical:sender];
}

-(void)setting:(id)sender
{
	[SceneManager goOptions:sender];
	
}

-(void)about:(id)sender
{
	[SceneManager goAbout:sender];
}

-(void)checkForState
{
	if ([saveSetting getMusicPlay]==0) {
		[musiceHandle notifyMusic];
	}
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	
	UITouch* touch =[touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint point = [[CCDirector sharedDirector] convertToGL:location];//转换成gl视窗
	if ((point.x>500)&&(point.x<ipadWidth)&&(point.y>300)&&(point.y<500)) {
		
		[SceneManager goHighScore:nil];
	}
}

-(void)dealloc
{
	
	[super dealloc];
}




@end
