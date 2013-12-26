	//
	//  highScore.m
	//  tapat
	//
	//  Created by 吴 wuziqi on 11-1-26.
	//  Copyright 2011 同济大学. All rights reserved.
	//

#import "highScore.h"
#import "GameConfig.h"
#import "saveData.h"
#import "SceneManager.h"
#import "GameCenterManager.h"
@implementation highScore
@synthesize gameCenterManager;

-(id)init
{
	self =[super init];
	if (self) {
		[self gameCenterFunction];
		[self initButton];	
		[self showAllScoreLocally];
	}
	return self;
}

-(void)initButton
{
	
	CCSprite* highScoreBack=[CCSprite spriteWithFile:@"leaderboard.png" rect:CGRectMake(0, 0, 1024, 768)];
	highScoreBack.position=ccp(ipadWidth/2,ipadLength/2);
	[self addChild:highScoreBack z:0];
	
	CCSprite* submit=[CCSprite spriteWithFile:@"submit.png" rect:CGRectMake(0, 0, 80, 80)];
	CCMenuItem* submitButton=[CCMenuItemSprite itemFromNormalSprite:submit selectedSprite:nil target:self selector:@selector(submitToLeaderboard:)];
	CCMenu* submitMenu=[CCMenu menuWithItems:submitButton,nil];
	submitMenu.scale=1;
	submitMenu.position=ccp(ipadWidth/2+430,ipadWidth/2-100);
	for (CCMenuItem* each in [submitMenu children]) {
		CCAction* action=[CCRepeatForever actionWithAction:[CCSequence actions:
															[CCScaleTo actionWithDuration:2.0f scale:1.6],
															nil]
						  ];
		[each runAction:action];
	}
	[self addChild:submitMenu z:1];
	
	CCSprite* resetPicture=[CCSprite spriteWithFile:@"reset.png" rect:CGRectMake(0, 0, 80, 80)];
	CCSprite* menuPicture=[CCSprite spriteWithFile:@"back.png" rect:CGRectMake(0, 0, 80, 80)];
	
	CCMenuItem* resetButton =[CCMenuItemSprite itemFromNormalSprite:resetPicture selectedSprite:nil target:self selector:@selector(reset)];
	CCMenu* resetMenu=[CCMenu menuWithItems:resetButton,nil];
	resetMenu.position=ccp(ipadWidth-200,100);
	[self addChild:resetMenu];
	
	CCMenuItem* backButton =[CCMenuItemSprite itemFromNormalSprite:menuPicture selectedSprite:nil target:self selector:@selector(back)];
	CCMenu* backMenu=[CCMenu menuWithItems:backButton,nil];
	backMenu.position=ccp(200,100);
	[self addChild:backMenu];
}


-(void)reset
{
	UIAlertView* alert =[[UIAlertView alloc]
						 initWithTitle:@"Do you really want to reset the record?"
						 message:@"If you choose Yes,all the record will be set to 0"
						 delegate:self
						 cancelButtonTitle:@"Yes"
						 otherButtonTitles:@"No",nil];
	[alert show];
	[alert release];
}

-(void)back
{
	[SceneManager goMenu:nil];
}

-(void)showAllScoreLocally
{
	//advenLabel =[CCLabelTTF labelWithString:@"Adventure Score" fontName:@"nevis.ttf" fontSize:40];
	//advenLabel.position=ccp(ipadWidth/2-250,ipadLength/2+200);
	//[self addChild:advenLabel z:2 tag:79];
	for (int i=0; i<8; i++) {
		levelLabel[i] =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level %d: %d",i+1,[saveData getAdvenScore:i]] fontName:@"nevis.ttf" fontSize:25];
		levelLabel[i].position=ccp(ipadWidth/2-280,ipadLength/2+200-(i+1)*50);
		[self addChild:levelLabel[i]];
	}
	
	//challenLabel =[CCLabelTTF labelWithString:@"Challenge Score" fontName:@"nevis.ttf" fontSize:40];
	//challenLabel.position=ccp(ipadWidth/2+25,ipadLength/2+200);
	//[self addChild:challenLabel z:2];
	scoreLabel =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Best:%d" ,[saveData getChallengeScore]] fontName:@"nevis.ttf" fontSize:25];
	scoreLabel.position=ccp(ipadWidth/2+275,ipadWidth/2-100);
	[self addChild:scoreLabel];
	
}

-(void)gameCenterFunction
{
	if([GameCenterManager isGameCenterAvailable]) {
		self.gameCenterManager= [[[GameCenterManager alloc] init] autorelease];
		
		[self.gameCenterManager setDelegate:self];
		[self.gameCenterManager authenticateLocalUser];
	}
	else{
		[self showAlertWithTitle: @"Game Center Support Required!"
						 message: @"The current device does not support Game Center, which this sample requires."];
	}
	
}


-(void)submitToLeaderboard:(id)sender
{
	[self.gameCenterManager reportScore:[saveData getChallengeScore] forCategory:@"com.tapat.totalscore"];
	[self.gameCenterManager showLeaderboard];
}

-(void)dealloc
{
	[self.gameCenterManager setDelegate:nil];
	[gameCenterManager release];
	[super dealloc];
}

#pragma mark -
#pragma mark delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==0) {
		//[self removeChild:challenLabel cleanup:YES];
		//[self removeChild:advenLabel cleanup:YES];
		[self removeChild:scoreLabel cleanup:YES];
		[saveData saveChallengeScore:0];
		for (int i=0; i<8; i++) {
			[self removeChild:levelLabel[i] cleanup:YES];
			[saveData saveAdvenScore:0 level:i];
		}		
		[self showAllScoreLocally];
		
	}
}

- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: title message: message 
												   delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL] autorelease];
	[alert show];
	
}

#pragma mark -
#pragma mark leaderboard

- (void) scoreReported: (NSError*) error;
{
	if(error == NULL)
	{
			//[self.gameCenterManager reloadHighScoresForCategory:@"com.tapat.totalscore"];
		[self showAlertWithTitle: @"High Score Submitted!"
						 message: [NSString stringWithFormat: @"", [error localizedDescription]]];
	}
	else
	{
		[self showAlertWithTitle: @"Score Report Failed!"
						 message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]];
	}
}




@end
