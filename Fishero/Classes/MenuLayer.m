//
//  MenuLayer.m
//  T01
//
//  Created by 吴 wuziqi on 11-3-6.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "MenuLayer.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "OptionLayer.h"
#import "InfoLayer.h"
#import "MusicHandle.h"
#import "SaveSetting.h"
#import "saveData.h"
#import "ActiveBGLayer.h"
#import "BubbleLayer.h"

@interface MenuLayer (PrivateMethods)


-(void) startingAnimation;

@end


@implementation MenuLayer

+(id)scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	CCScene *layer = [MenuLayer node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(id)init
{
    self = [super init];
    if(self)
    {
			//NSLog(@"%d",[saveData getCost:1]);
		[MusicHandle notifyMenuMusic];
        /*CCSprite* menuBackground=[CCSprite spriteWithFile:@"sysMenu.png" rect:CGRectMake(0,0,1024,768)];
        menuBackground.position=ccp(ipadWidth/2,ipadLength/2);
        
        [self addChild:menuBackground z:0 tag:1];*/
		
		
		
		
		
		CCLayer * activeBG = [ActiveBGLayer node];
		[self addChild:activeBG z:0 tag:100];
		
		CCLayer * bubbleLayer = [BubbleLayer node];
		[self addChild:bubbleLayer z:0 tag:101];
		
		[self startingAnimation];
		
        [self addButton];
		
		
        optionUsed=FALSE;
        infoUsed=FALSE;
		[self schedule:@selector(checkState)];
    }
    return self;
}

-(void) startingAnimation{
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	
	CCSprite* adventureSprite=[CCSprite spriteWithFile:@"adventure.png"];
	[self addChild:adventureSprite z:1 tag:201];
	//adventureSprite.position = CGPointMake(screenSize.width + adventureSprite.contentSize.width / 2, ipadLength/2+100);
	//adventureSprite.position = CGPointMake(screenSize.width + adventureSprite.contentSize.width / 2, screenSize.height +  ipadLength/2+100);
	
	startPos1 = CGPointMake(ipadWidth / 2 - 350, screenSize.height +  adventureSprite.contentSize.height / 2);
	endPos1 = ccp(ipadWidth / 2 - 350,ipadLength / 2+100);
	
	adventureSprite.position = startPos1;
	id move1 = [CCMoveTo actionWithDuration:2 position:endPos1];
	id move_ease1 = [CCEaseElasticOut actionWithAction:[[move1 copy] autorelease] period:3];
	CCCallFuncN * call1 = [CCCallFuncN actionWithTarget:self selector:@selector(addButton1)];
	id seq1 = [CCSequence actions:move_ease1,call1,nil];	
	[adventureSprite runAction:seq1];
	
	
	
	
	CCSprite* endlessSprite=[CCSprite spriteWithFile:@"Endless.png" rect:CGRectMake(0, 0, 274, 95)];
	[self addChild:endlessSprite z:1 tag:202];
	//endlessSprite.position = CGPointMake(screenSize.width + endlessSprite.contentSize.width / 2, ipadLength/2);
	
	startPos2 = CGPointMake(screenSize.width + endlessSprite.contentSize.width / 2, screenSize.height + endlessSprite.contentSize.height / 2);
	endPos2 = ccp(ipadWidth / 2 - 100,ipadLength / 2);
	
	endlessSprite.position = startPos2;
	id move2 = [CCMoveTo actionWithDuration:2 position:endPos2];
	id move_ease2 = [CCEaseElasticOut actionWithAction:[[move2 copy] autorelease] period:3];
	CCCallFuncN * call2 = [CCCallFuncN actionWithTarget:self selector:@selector(addButton2)];
	id seq2 = [CCSequence actions:move_ease2,call2,nil];
	[endlessSprite runAction:seq2];

	
	
	
	CCSprite* miniGameSprite=[CCSprite spriteWithFile:@"miniGame.png"];
	[self addChild:miniGameSprite z:1 tag:203];
	//miniGameSprite.position = CGPointMake(screenSize.width + miniGameSprite.contentSize.width / 2, ipadLength/2-150);
	//miniGameSprite.position = CGPointMake(- screenSize.width, ipadLength/2-150);
	
	startPos3 = CGPointMake(screenSize.width + miniGameSprite.contentSize.width / 2, ipadLength / 2 - 100);
	endPos3 = ccp(ipadWidth / 2 - 350, ipadLength/2 - 100);
	
	miniGameSprite.position = startPos3;
	id move3 = [CCMoveTo actionWithDuration:2 position:endPos3];
	id move_ease3 = [CCEaseElasticOut actionWithAction:[[move3 copy] autorelease] period:3];
	CCCallFuncN * call3 = [CCCallFuncN actionWithTarget:self selector:@selector(addButton3)];
	id seq3 = [CCSequence actions:move_ease3,call3,nil];
	[miniGameSprite runAction:seq3];
	
	
	
	
	
	CCSprite* storeGameSprite=[CCSprite spriteWithFile:@"storeButton.png"];
	[self addChild:storeGameSprite z:1 tag:204];
	//storeGameSprite.position = CGPointMake(screenSize.width + storeGameSprite.contentSize.width / 2, ipadLength/2-250);
	//storeGameSprite.position = CGPointMake(screenSize.width + storeGameSprite.contentSize.width / 2, -100);
	
	startPos4 = CGPointMake(screenSize.width + storeGameSprite.contentSize.width / 2, -storeGameSprite.contentSize.height / 2);
	endPos4 = ccp(ipadWidth / 2 - 100 ,ipadLength / 2 - 200);
	
	storeGameSprite.position = startPos4;
	id move4 = [CCMoveTo actionWithDuration:2 position:endPos4];
	id move_ease4 = [CCEaseElasticOut actionWithAction:[[move4 copy] autorelease] period:3];
	CCCallFuncN * call4 = [CCCallFuncN actionWithTarget:self selector:@selector(addButton4)];
	id seq4 = [CCSequence actions:move_ease4,call4,nil];
	[storeGameSprite runAction:seq4];
	
	
	CCSprite* helpGameSprite=[CCSprite spriteWithFile:@"help.png"];
	[self addChild:helpGameSprite z:1 tag:205];
	
	startPos5 = CGPointMake(ipadWidth / 2 - 350, -helpGameSprite.contentSize.height / 2);
	endPos5 = ccp(ipadWidth / 2 - 350,ipadLength / 2 - 300);
	
	helpGameSprite.position = startPos5;
	id move5 = [CCMoveTo actionWithDuration:2 position:endPos5];
	id move_ease5 = [CCEaseElasticOut actionWithAction:[[move5 copy] autorelease] period:3];
	CCCallFuncN * call5 = [CCCallFuncN actionWithTarget:self selector:@selector(addButton5)];
	id seq5 = [CCSequence actions:move_ease5,call5,nil];
	[helpGameSprite runAction:seq5];
}


-(void) leavingAnimation{
//	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	[self removeChildByTag:2 cleanup:YES];
	[self removeChildByTag:5 cleanup:YES];
	[self removeChildByTag:6 cleanup:YES];
	[self removeChildByTag:7 cleanup:YES];
	[self removeChildByTag:8 cleanup:YES];
	
	CCSprite* adventureSprite=[CCSprite spriteWithFile:@"adventure.png"];
	[self addChild:adventureSprite z:1 tag:201];
	adventureSprite.position = endPos1;
	id move1 = [CCMoveTo actionWithDuration:2 position:startPos1];
	id move_ease1 = [CCEaseElasticOut actionWithAction:[[move1 copy] autorelease] period:3];
	CCCallFuncN * call1 = [CCCallFuncN actionWithTarget:self selector:nil];
	id seq1 = [CCSequence actions:move_ease1,call1,nil];	
	[adventureSprite runAction:seq1];
	
	CCSprite* endlessSprite=[CCSprite spriteWithFile:@"Endless.png" rect:CGRectMake(0, 0, 274, 95)];
	[self addChild:endlessSprite z:1 tag:202];
	//startPos2 = CGPointMake(screenSize.width + endlessSprite.contentSize.width / 2, ipadLength/2);
	endlessSprite.position = endPos2;
	id move2 = [CCMoveTo actionWithDuration:3 position:startPos2];
	id move_ease2 = [CCEaseElasticOut actionWithAction:[[move2 copy] autorelease] period:3];
	CCCallFuncN * call2 = [CCCallFuncN actionWithTarget:self selector:nil];
	id seq2 = [CCSequence actions:move_ease2,call2,nil];
	[endlessSprite runAction:seq2];
	
	CCSprite* miniGameSprite=[CCSprite spriteWithFile:@"miniGame.png"];
	[self addChild:miniGameSprite z:1 tag:203];
	//startPos3 = CGPointMake(-screenSize.width, ipadLength/2-150);
	miniGameSprite.position = endPos3;
	id move3 = [CCMoveTo actionWithDuration:2 position:startPos3];
	id move_ease3 = [CCEaseElasticOut actionWithAction:[[move3 copy] autorelease] period:3];
	CCCallFuncN * call3 = [CCCallFuncN actionWithTarget:self selector:nil];
	id seq3 = [CCSequence actions:move_ease3,call3,nil];
	[miniGameSprite runAction:seq3];
	
	CCSprite* storeGameSprite=[CCSprite spriteWithFile:@"storeButton.png"];
	[self addChild:storeGameSprite z:1 tag:204];
	//startPos4 = CGPointMake(screenSize.width + storeGameSprite.contentSize.width / 2, -100);
	storeGameSprite.position = endPos4;
	id move4 = [CCMoveTo actionWithDuration:2 position:startPos4];
	id move_ease4 = [CCEaseElasticOut actionWithAction:[[move4 copy] autorelease] period:3];
	CCCallFuncN * call4 = [CCCallFuncN actionWithTarget:self selector:nil];
	id seq4 = [CCSequence actions:move_ease4,call4,nil];
	[storeGameSprite runAction:seq4];
	
	
	CCSprite* helpGameSprite=[CCSprite spriteWithFile:@"help.png"];
	[self addChild:helpGameSprite z:1 tag:205];
	//startPos5 = CGPointMake(screenSize.width + helpGameSprite.contentSize.width / 2, -100);
	helpGameSprite.position = endPos5;
	id move5 = [CCMoveTo actionWithDuration:2 position:startPos5];
	id move_ease5 = [CCEaseElasticOut actionWithAction:[[move5 copy] autorelease] period:3];
	CCCallFuncN * call5 = [CCCallFuncN actionWithTarget:self selector:nil];
	id seq5 = [CCSequence actions:move_ease5,call5,nil];
	[helpGameSprite runAction:seq5];
	
}

-(void)addButton
{
    
//    CCSprite* adventureSprite=[CCSprite spriteWithFile:@"adventure.png"];
//    CCMenuItem* advenButton=[CCMenuItemSprite itemFromNormalSprite:adventureSprite selectedSprite:nil target:self selector:@selector(goAdventure)];
//    CCMenu* advenMenu=[CCMenu menuWithItems:advenButton, nil];
//    advenMenu.position=ccp(ipadWidth/2-350,ipadLength/2+100);
//    [self addChild:advenMenu z:1 tag:5];
//    
//    CCSprite* endlessSprite=[CCSprite spriteWithFile:@"Endless.png" rect:CGRectMake(0, 0, 274, 95)];
//    CCMenuItem* endlessButton=[CCMenuItemSprite itemFromNormalSprite:endlessSprite selectedSprite:nil target:self selector:@selector(goEndless)];
//    CCMenu* endlessMenu=[CCMenu menuWithItems:endlessButton,nil ];
//    endlessMenu.position=ccp(ipadWidth/2-100,ipadLength/2);
//    [self addChild:endlessMenu z:1 tag:2];
    
    CCSprite* optionSprite=[CCSprite spriteWithFile:@"option.png" rect:CGRectMake(0, 0,53, 54)];
    CCMenuItem* optionButton=[CCMenuItemSprite itemFromNormalSprite:optionSprite selectedSprite:nil target:self selector:@selector(addOption)];
    CCMenu* optionMenu=[CCMenu menuWithItems:optionButton, nil];
    optionMenu.position=ccp(ipadWidth/2+280,140);
    [self addChild:optionMenu z:1 tag:3];
    
    CCSprite* infoSprite=[CCSprite spriteWithFile:@"info.png" rect:CGRectMake(0, 0, 48, 49)];
    CCMenuItem* infoButton=[CCMenuItemSprite itemFromNormalSprite:infoSprite selectedSprite:nil target:self selector:@selector(addInfo)];
    CCMenu* infoMenu=[CCMenu menuWithItems:infoButton, nil];
    infoMenu.position=ccp(ipadWidth/2+390,140);
    [self addChild:infoMenu z:1 tag:4];
	
//	CCSprite* miniGameSprite=[CCSprite spriteWithFile:@"miniGame.png"];
//	CCMenuItemSprite* miniButton=[CCMenuItemSprite itemFromNormalSprite:miniGameSprite selectedSprite:nil target:self selector:@selector(goMiniGame)];
//	CCMenu* miniMenu=[CCMenu menuWithItems:miniButton,nil];
//	miniMenu.position=ccp(ipadWidth/2-350,ipadLength/2-150);
//	[self addChild:miniMenu z:1 tag:6];
//	
//	CCSprite* storeGameSprite=[CCSprite spriteWithFile:@"storeButton.png"];
//	CCMenuItemSprite* storeButton=[CCMenuItemSprite itemFromNormalSprite:storeGameSprite selectedSprite:nil target:self selector:@selector(goStore)];
//	CCMenu* storeMenu=[CCMenu menuWithItems:storeButton,nil];
//	storeMenu.position=ccp(ipadWidth/2-350,ipadLength/2-250);
//	[self addChild:storeMenu z:1 tag:7];

}

-(void) addButton1{
    CCSprite* adventureSprite=[CCSprite spriteWithFile:@"adventure.png"];
    CCMenuItem* advenButton=[CCMenuItemSprite itemFromNormalSprite:adventureSprite selectedSprite:nil target:self selector:@selector(goAdventure)];
    CCMenu* advenMenu=[CCMenu menuWithItems:advenButton, nil];
    advenMenu.position=endPos1;
    [self addChild:advenMenu z:1 tag:5];
	
	[self removeChildByTag:201 cleanup:YES];
}

-(void) addButton2{
    CCSprite* endlessSprite=[CCSprite spriteWithFile:@"Endless.png" rect:CGRectMake(0, 0, 274, 95)];
    CCMenuItem* endlessButton=[CCMenuItemSprite itemFromNormalSprite:endlessSprite selectedSprite:nil target:self selector:@selector(goEndless)];
    CCMenu* endlessMenu=[CCMenu menuWithItems:endlessButton,nil ];
    endlessMenu.position=endPos2;
    [self addChild:endlessMenu z:1 tag:2];
	
	[self removeChildByTag:202 cleanup:YES];
}

-(void) addButton3{
	CCSprite* miniGameSprite=[CCSprite spriteWithFile:@"miniGame.png"];
	CCMenuItemSprite* miniButton=[CCMenuItemSprite itemFromNormalSprite:miniGameSprite selectedSprite:nil target:self selector:@selector(goMiniGame)];
	CCMenu* miniMenu=[CCMenu menuWithItems:miniButton,nil];
	miniMenu.position=endPos3;
	[self addChild:miniMenu z:1 tag:6];
	
	[self removeChildByTag:203 cleanup:YES];
}

-(void) addButton4{
	CCSprite* storeGameSprite=[CCSprite spriteWithFile:@"storeButton.png"];
	CCMenuItemSprite* storeButton=[CCMenuItemSprite itemFromNormalSprite:storeGameSprite selectedSprite:nil target:self selector:@selector(goStore)];
	CCMenu* storeMenu=[CCMenu menuWithItems:storeButton,nil];
	storeMenu.position=endPos4;
	[self addChild:storeMenu z:1 tag:7];
	
	[self removeChildByTag:204 cleanup:YES];
}

-(void) addButton5{
	CCSprite* helpGameSprite=[CCSprite spriteWithFile:@"help.png"];
	CCMenuItemSprite* helpButton=[CCMenuItemSprite itemFromNormalSprite:helpGameSprite selectedSprite:nil target:self selector:@selector(goHelp)];
	CCMenu* helpMenu=[CCMenu menuWithItems:helpButton,nil];
	helpMenu.position=endPos5;
	[self addChild:helpMenu z:1 tag:8];
	
	[self removeChildByTag:205 cleanup:YES];
}

-(void)goEndless
{
	[self leavingAnimation];
	
	[MusicHandle stopSound];
	[MusicHandle notifyMiniMusic];
    [SceneManager goEndless];
}
-(void)goAdventure
{
	[self leavingAnimation];
	
	[MusicHandle stopSound];
	[MusicHandle notifyMiniMusic];
    [SceneManager goSelect];
}

-(void)goMiniGame
{
	[self leavingAnimation];
	
	[SceneManager goMiniGame];
}

-(void)goStore
{
	[self leavingAnimation];
	
	[SceneManager goStore];
}

-(void)checkState
{
	if ([SaveSetting getMusic]==1) {
		[MusicHandle stopSound];
	}
	else {
		[MusicHandle notifyMenuMusic];
	}
	
	if ([saveData getScore]>=500&&([saveData getMini:1]==0)) {
		
		[saveData setMini:1 Level:1];
		int tempScore=[saveData getScore];
		tempScore-=500;
		[saveData setScore:tempScore];
	}
	
	if([saveData getScore]>=800&&([saveData getMini:2]==0))
	{
		[saveData setMini:1 Level:2];
		int tempScore=[saveData getScore];
		tempScore-=800;
		[saveData setScore:tempScore];
	}
	
	if([saveData getScore]>=300&&([saveData getMini:3]==0))
	{
		[saveData setMini:1 Level:3];
		int tempScore=[saveData getScore];
		tempScore-=300;
		[saveData setScore:tempScore];
	}
	if ([saveData getScore]!=0) {
		[self removeChild:totalScore cleanup:YES];
		NSString* tempString=[NSString stringWithFormat:@"%d",[saveData getScore]];
		totalScore=[CCLabelTTF labelWithString:tempString fontName:@"BradyBunch.ttf" fontSize:80];
		[totalScore setColor:ccYELLOW];
		totalScore.position=ccp(ipadWidth/2-300,ipadLength/2+230);
		[self addChild:totalScore z:1 tag:102];
	}
	else {
		NSString* tempString=[NSString stringWithFormat:@"%d",[saveData getScore]];
		totalScore=[CCLabelTTF labelWithString:tempString fontName:@"BradyBunch.ttf" fontSize:80];
		[totalScore setColor:ccYELLOW];
		totalScore.position=ccp(ipadWidth/2-300,ipadLength/2+230);
		[self addChild:totalScore z:1 tag:102];
	}

	
	


}

-(void)addOption
{

    if (optionUsed==FALSE) {
        CCLayer* newLayer =[OptionLayer node];
        //newLayer.position=ccp(ipadWidth/2+280,120);
        [self addChild:newLayer z:0 tag:90];
        optionUsed=TRUE;
    }
    else
    {
        [self removeChildByTag:90 cleanup:YES ];
        optionUsed=FALSE;
    }
    
}

-(void)addInfo
{
    if (infoUsed==FALSE) {
        CCLayer* newLayer=[InfoLayer node];
        [self addChild:newLayer z:0 tag:91];
        infoUsed=TRUE;
    }
    else
    {
        [self removeChildByTag:91 cleanup:YES ];
        infoUsed=FALSE;
    }
    
    
}

-(void)goHelp
{
	[SceneManager goHelp];
}

-(void)dealloc
{
    //[self removeChildByTag:2 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    [self removeChildByTag:4 cleanup:YES];
    //[self removeChildByTag:5 cleanup:YES];
	//[self removeChildByTag:6 cleanup:YES];
    [super dealloc];
}





@end
