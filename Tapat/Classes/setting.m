	//
	//  setting.m
	//  tapat
	//
	//  Created by 吴 wuziqi on 10-11-15.
	//  Copyright 2010 同济大学. All rights reserved.
	//

#import "setting.h"
#import "saveSetting.h"
#import "cocos2d.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "musiceHandle.h"


@implementation setting

-(id)init
{
	self = [super init];
	if (self) {
		
		[self initButton];
		
		[self initBackground];
		
		
		
	}
	return self;
}

-(void)initBackground
{
	
	CCSprite* backSetting =[CCSprite spriteWithFile:@"background.png" rect:CGRectMake(0, 0, 346, 64)];
	backSetting.position=ccp(200,ipadLength/2+200);
	[self addChild:backSetting z:2];
	
	
	CCSprite* fireDe=[CCSprite spriteWithFile:@"backFireDefault.png" rect:CGRectMake(0, 0, 150, 100)];
	CCSprite* fireSe=[CCSprite spriteWithFile:@"backFireSelect.png" rect:CGRectMake(0, 0, 150, 100)];
	CCSprite* iceDe=[CCSprite spriteWithFile:@"backIceDefault.png" rect:CGRectMake(0, 0, 150, 100)];
	CCSprite* iceSe=[CCSprite spriteWithFile:@"backIceSelect.png" rect:CGRectMake(0, 0, 150, 100)];
	CCSprite* grassDe=[CCSprite spriteWithFile:@"backGrassDefault.png" rect:CGRectMake(0, 0, 150, 100)];
	CCSprite* grassSe=[CCSprite spriteWithFile:@"backGrassSelect.png" rect:CGRectMake(0, 0, 150, 100)];
	
	
	CCMenuItemToggle* chooseBackground=[CCMenuItemToggle itemWithTarget:self selector:@selector(chooseBack:) items:[CCMenuItemSprite itemFromNormalSprite:grassDe selectedSprite:grassSe],nil];
	NSArray* arrayMore=[NSArray arrayWithObjects:[CCMenuItemSprite itemFromNormalSprite:iceDe selectedSprite:iceSe],[CCMenuItemSprite itemFromNormalSprite:fireDe selectedSprite:fireSe],nil];
	[chooseBackground.subItems addObjectsFromArray:arrayMore];
	[chooseBackground setSelectedIndex:[saveSetting getBackground]];
	CCMenu* backMenu=[CCMenu menuWithItems:chooseBackground,nil];
	backMenu.position=ccp(ipadWidth/2+100,ipadLength/2+200);
	[self addChild:backMenu z:2];
	
}

-(void)initButton
{
	CCSprite* optionBack=[CCSprite spriteWithFile:@"optionBack.png" rect:CGRectMake(0, 0, 1024, 768)];
	optionBack.position=ccp(ipadWidth/2,ipadLength/2);
	[self addChild:optionBack z:0];
	
	CCSprite* menuPicture=[CCSprite spriteWithFile:@"back.png" rect:CGRectMake(0, 0, 80, 80)];
	
	CCMenuItem* backButton =[CCMenuItemSprite itemFromNormalSprite:menuPicture selectedSprite:nil target:self selector:@selector(back:)];
	CCMenu* backMenu=[CCMenu menuWithItems:backButton,nil];
	backMenu.position=ccp(200,100);
	[self addChild:backMenu z:1 ];
	
		///////choose the preference
	CCSprite* soundPicture=[CCSprite spriteWithFile:@"sound.png" rect:CGRectMake(0, 0, 220, 60)];
	soundPicture.position=ccp(260,ipadLength/2-100);
	[self addChild:soundPicture z:2];
	
	CCSprite* yesPicture=[CCSprite spriteWithFile:@"yes.png" rect:CGRectMake(0, 0, 95, 56)];
	CCSprite* noPicture=[CCSprite spriteWithFile:@"no.png" rect:CGRectMake(0, 0, 94, 60)];
	CCMenuItemToggle* soundToggle =[CCMenuItemToggle itemWithTarget:self selector:@selector(playSound:) items:[CCMenuItemSprite itemFromNormalSprite:yesPicture selectedSprite:yesPicture],
									[CCMenuItemSprite itemFromNormalSprite:noPicture selectedSprite:noPicture],nil];
	[soundToggle setSelectedIndex:[saveSetting getSoundPlay]];
	
	CCMenu* soundMenu =[CCMenu menuWithItems:soundToggle,nil];
	soundMenu.position=ccp(ipadWidth/2+100,ipadLength/2-100);
	[self addChild:soundMenu z:1];
	
		//set the sound effect
	CCSprite* musicPicture=[CCSprite spriteWithFile:@"music.png" rect:CGRectMake(0, 0, 224, 55)];
	musicPicture.position=ccp(260,ipadLength/2+20);
	[self addChild:musicPicture z:2];
	
	CCMenuItemToggle* musicToggle =[CCMenuItemToggle itemWithTarget:self selector:@selector(playMusic:) items:[CCMenuItemSprite itemFromNormalSprite:yesPicture selectedSprite:yesPicture],
									[CCMenuItemSprite itemFromNormalSprite:noPicture selectedSprite:noPicture],nil];
	[musicToggle setSelectedIndex:[saveSetting getMusicPlay]];
	CCMenu* musicMenu =[CCMenu menuWithItems:musicToggle,nil];
	musicMenu.position=ccp(ipadWidth/2+100,ipadLength/2+20);
	[self addChild:musicMenu z:1];
	
}



-(void)dealloc
{
	[super dealloc];
}

-(void)playMusic:(id)sender
{
	if ([sender selectedIndex]==0) {
		[saveSetting saveMusicPlay:0];//表示播放
		[musiceHandle notifyMusic];
	}
	else
	{
		[saveSetting saveMusicPlay:1];//表示不播放
		[musiceHandle stopSound];

	}
}

-(void)playSound:(id)sender
{
	if ([sender selectedIndex]==0) {
		[saveSetting saveSoundPlay:0];//表示播放
		[musiceHandle notifySoundOfMice];
	}
	else
	{
		[saveSetting saveSoundPlay:1];//表示不播放
	}
	
}

-(void)chooseBack:(id)sender
{
	[saveSetting saveChoiceBackground:[sender selectedIndex]];
}


-(void)back:(id)sender
{
	[SceneManager goMenu:sender];
}



@end
