//
//  StoreLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-14.
//  Copyright 2011 同济大学. All rights reserved.
//

#import "StoreLayer.h"
#import "GameConfig.h"
#import "saveData.h"

@implementation StoreLayer

-(id)init
{
	self =[super init];
	if (self) {
		
//		NSString* tempString7=[NSString stringWithFormat:@"TotalScore: %d",[saveData getScore]];
//		CCLabelTTF* totalScore=[CCLabelTTF labelWithString:tempString7 fontName:@"nevis.ttf" fontSize:60];
//		[totalScore setColor:ccORANGE];
//		totalScore.position=ccp(ipadWidth/2+250,ipadLength/2+300);
//		[self addChild:totalScore z:2 tag:102];
		
		
		CCSprite* backSprite=[CCSprite spriteWithFile:@"back.png"];
		CCMenuItemSprite* backButton=[CCMenuItemSprite itemFromNormalSprite:backSprite selectedSprite:nil target:self selector:@selector(goMenu)];
		CCMenu* menu=[CCMenu menuWithItems:backButton,nil];
		menu.position=ccp(150,120);
		[self addChild:menu z:1 tag:11];
		
		CCSprite* background=[CCSprite spriteWithFile:@"store.png"];
		background.position=ccp(ipadWidth/2,ipadLength/2);
		[self addChild:background z:0 tag:1];
	
		
		CCLabelTTF* levelLabel=[CCLabelTTF labelWithString:@"Level" fontName:@"nevis.ttf" fontSize:40];
		[levelLabel setColor:ccBLUE];
		levelLabel.position=ccp(ipadWidth/2,ipadLength/2+150);
		[self addChild:levelLabel z:0 tag:2];
		
		
		CCLabelTTF* costLabel=[CCLabelTTF labelWithString:@"Cost" fontName:@"nevis.ttf" fontSize:40];
		[costLabel setColor:ccBLUE];
		costLabel.position=ccp(ipadWidth/2+200,ipadLength/2+150);
		[self addChild:costLabel z:0 tag:3];
		
		NSString* tempString=[NSString stringWithFormat:@"%d",[saveData getShelter]];
		NSString* tempString3=[NSString stringWithFormat:@"%d",[saveData getCost:1]];
		
		recordLevelofShelter=[CCLabelTTF labelWithString:tempString fontName:@"nevis.ttf" fontSize:50];
		[recordLevelofShelter setColor:ccBLUE];
		recordLevelofShelter.position=ccp(ipadWidth/2,ipadLength/2+50);
		[self addChild:recordLevelofShelter z:0 tag:5];
		recordCostofShelter=[CCLabelTTF labelWithString:tempString3 fontName:@"nevis.ttf" fontSize:50];
		[recordCostofShelter setColor:ccBLUE];
		recordCostofShelter.position=ccp(ipadWidth/2+200,ipadLength/2+50);
		[self addChild:recordCostofShelter z:0 tag:8];
		
		NSString* tempString1=[NSString stringWithFormat:@"%g",[saveData getSize]];
		NSString* tempString4=[NSString stringWithFormat:@"%d",[saveData getCost:2]];

		recordLevelofSize=[CCLabelTTF labelWithString:tempString1 fontName:@"nevis.ttf" fontSize:50];
		[recordLevelofSize setColor:ccBLUE];
		recordLevelofSize.position=ccp(ipadWidth/2,ipadLength/2-50);
		[self addChild:recordLevelofSize z:0 tag:6];
		
		recordCostofSize=[CCLabelTTF labelWithString:tempString4 fontName:@"nevis.ttf" fontSize:50];
		[recordCostofSize setColor:ccBLUE];
		recordCostofSize.position=ccp(ipadWidth/2+200,ipadLength/2-50);
		[self addChild:recordCostofSize z:0 tag:9];
		
		
		NSString* tempString2=[NSString stringWithFormat:@"%d",[saveData getPower]];
		NSString* tempString5=[NSString stringWithFormat:@"%d",[saveData getCost:3]];
		
		
		recordLevelofPower=[CCLabelTTF labelWithString:tempString2 fontName:@"nevis.ttf" fontSize:50];
		[recordLevelofPower setColor:ccBLUE];
		recordLevelofPower.position=ccp(ipadWidth/2,ipadLength/2-150);
		[self addChild:recordLevelofPower z:0 tag:7];
		recordCostofPower=[CCLabelTTF labelWithString:tempString5 fontName:@"nevis.ttf" fontSize:50];
		[recordCostofPower setColor:ccBLUE];
		recordCostofPower.position=ccp(ipadWidth/2+200,ipadLength/2-150);
		[self addChild:recordCostofPower z:0 tag:10];
		
		
		lastScore = [saveData getScore];
		NSString* tempStringa=[NSString stringWithFormat:@"TotalScore: %d",[saveData getScore]];
		CCLabelTTF* totalScore=[CCLabelTTF labelWithString:tempStringa fontName:@"BradyBunch.ttf" fontSize:80];
		[totalScore setColor:ccYELLOW];
		totalScore.position=ccp(ipadWidth/2+230,ipadLength/2+300);
		[self addChild:totalScore z:1 tag:400];
		
		
		[self addUpdate];
		
		[self schedule:@selector(updateLabel:)];

	}
	return self;
}

-(void)addUpdate
{
	CCSprite* shelterSprite=[CCSprite spriteWithFile:@"updateButton.png"];
	CCSprite* sizeSprite=[CCSprite spriteWithFile:@"updateButton.png"];
	CCSprite* powerSprite=[CCSprite spriteWithFile:@"updateButton.png"];
	CCSprite* disableShelter=[CCSprite spriteWithFile:@"updateDisable.png"];
	CCSprite* disableSize=[CCSprite spriteWithFile:@"updateDisable.png"];
	CCSprite* disablePower=[CCSprite spriteWithFile:@"updateDisable.png"];
	CCMenuItemSprite* updateShelter=[CCMenuItemSprite itemFromNormalSprite:shelterSprite selectedSprite:nil disabledSprite:disableShelter target:self selector:@selector(updateShelter:)];
	if ([saveData getShelter]>=1) {
		[updateShelter setIsEnabled:NO];
	}
	CCMenuItemSprite* updateSize=[CCMenuItemSprite itemFromNormalSprite:sizeSprite selectedSprite:nil disabledSprite:disableSize target:self selector:@selector(updateSize:)];
	if ([saveData getSize]>=1) {
		[updateSize setIsEnabled:NO];
	}
	CCMenuItemSprite* updatePower=[CCMenuItemSprite itemFromNormalSprite:powerSprite selectedSprite:nil disabledSprite:disablePower target:self selector:@selector(updatePower:)];
	if ([saveData getPower]>=4) {
		[updatePower setIsEnabled:NO];
	}
	
	CCMenu* menu=[CCMenu menuWithItems:updateShelter,updateSize,updatePower,nil];
	[menu alignItemsVerticallyWithPadding:50];
	menu.position=ccp(ipadWidth/2+330,ipadLength/2-50);
	[self addChild:menu z:1 tag:4];
}

-(void)updateShelter:(id)sender
{

	if ([saveData getScore]<[saveData getCost:1]) {
		return;
	}
	int shetler=[saveData getShelter];
	shetler++;
	[saveData setShelter:shetler];
	if (shetler>=1) {
		[sender setIsEnabled:NO];
	}
	[self removeChild:recordLevelofShelter cleanup:YES];
	
	NSString* tempString=[NSString stringWithFormat:@"%d",[saveData getShelter]];
	
	recordLevelofShelter=[CCLabelTTF labelWithString:tempString fontName:@"nevis.ttf" fontSize:50];
	[recordLevelofShelter setColor:ccBLUE];
	recordLevelofShelter.position=ccp(ipadWidth/2,ipadLength/2+50);
	[self addChild:recordLevelofShelter z:0 tag:5];
	
	[self removeChild:recordCostofShelter cleanup:YES];
	int scoreTemp=[saveData getScore];
	int cost=[saveData getCost:1];
	scoreTemp-=cost;
	[saveData setScore:scoreTemp];
	cost*=2;
	[saveData setCost:cost sort:1];
	NSString* tempString3=[NSString stringWithFormat:@"%d",[saveData getCost:1]];
	recordCostofShelter=[CCLabelTTF labelWithString:tempString3 fontName:@"nevis.ttf" fontSize:50];
	[recordCostofShelter setColor:ccBLUE];
	recordCostofShelter.position=ccp(ipadWidth/2+200,ipadLength/2+50);
	[self addChild:recordCostofShelter z:0 tag:8];
	
	
}

-(void)updateSize:(id)sender
{
	if ([saveData getScore]<[saveData getCost:2]) {
		return;
	}
	float size=[saveData getSize];
	size+=0.05;
	[saveData setSize:size];
	if (size>=1) {
		[sender setIsEnabled:NO];
	}
	
	[self removeChild:recordLevelofSize cleanup:YES];
	
	NSString* tempString1=[NSString stringWithFormat:@"%g",[saveData getSize]];
	recordLevelofSize=[CCLabelTTF labelWithString:tempString1 fontName:@"nevis.ttf" fontSize:50];
	[recordLevelofSize setColor:ccBLUE];
	recordLevelofSize.position=ccp(ipadWidth/2,ipadLength/2-50);
	[self addChild:recordLevelofSize z:0 tag:6];
	
	[self removeChild:recordCostofSize cleanup:YES];
	
	int scoreTemp=[saveData getScore];
	int cost=[saveData getCost:2];
	scoreTemp-=cost;
	[saveData setScore:scoreTemp];
	cost*=2;
	[saveData setCost:cost sort:2];
	NSString* tempString4=[NSString stringWithFormat:@"%d",[saveData getCost:2]];
	recordCostofSize=[CCLabelTTF labelWithString:tempString4 fontName:@"nevis.ttf" fontSize:50];
	[recordCostofSize setColor:ccBLUE];
	recordCostofSize.position=ccp(ipadWidth/2+200,ipadLength/2-50);
	[self addChild:recordCostofSize z:0 tag:9];
	
}

-(void)updatePower:(id)sender
{
	if ([saveData getScore]<[saveData getCost:3]) {
		return;
	}
	int power= [saveData getPower];
	power++;
	[saveData setPower:power];
	if (power>=4) {
		[sender setIsEnabled:NO];
	}
	
	[self removeChild:recordLevelofPower cleanup:YES];
	NSString* tempString2=[NSString stringWithFormat:@"%d",[saveData getPower]];
	recordLevelofPower=[CCLabelTTF labelWithString:tempString2 fontName:@"nevis.ttf" fontSize:50];
	[recordLevelofPower setColor:ccBLUE];
	recordLevelofPower.position=ccp(ipadWidth/2,ipadLength/2-150);
	[self addChild:recordLevelofPower z:0 tag:7];
	
	[self removeChild:recordCostofPower cleanup:YES];
	int scoreTemp=[saveData getScore];
	int cost=[saveData getCost:3];
	scoreTemp-=cost;
	[saveData setScore:scoreTemp];
	cost*=2;
	
	[saveData setCost:cost sort:3];
	NSString* tempString4=[NSString stringWithFormat:@"%d",[saveData getCost:3]];
	recordCostofPower=[CCLabelTTF labelWithString:tempString4 fontName:@"nevis.ttf" fontSize:50];
	[recordCostofPower setColor:ccBLUE];
	recordCostofPower.position=ccp(ipadWidth/2+200,ipadLength/2-150);
	[self addChild:recordCostofPower z:0 tag:10];
	
}

-(void)goMenu
{
	[SceneManager goMenu];
}


-(void) updateLabel:(ccTime)delta{
	int tempScore = [saveData getScore];
	if (lastScore != tempScore) {
		lastScore = tempScore;
		CCLabelTTF * totalScore = (CCLabelTTF*)[self getChildByTag:400];
		
		[totalScore setString: [NSString stringWithFormat:@"TotalScore: %d",lastScore]];
	}
}


-(void)dealloc
{
	[self removeChildByTag:1 cleanup:YES];
	[self removeChildByTag:2 cleanup:YES];
	[self removeChildByTag:3 cleanup:YES];
	[self removeChildByTag:4 cleanup:YES];
	[self removeChildByTag:5 cleanup:YES];
	[self removeChildByTag:6 cleanup:YES];
	[self removeChildByTag:7 cleanup:YES];
	[self removeChildByTag:8 cleanup:YES];
	[self removeChildByTag:9 cleanup:YES];
	[self removeChildByTag:10 cleanup:YES];
	[self removeChildByTag:11 cleanup:YES];
	[super dealloc];
}

@end
