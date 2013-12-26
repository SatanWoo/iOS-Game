//
//  gameBackground.m
//  tapat
//
//  Created by Yu Dingsheng on 11-1-26.
//  Copyright 2011 Tongji. All rights reserved.
//

#import "gameBackground.h"
#import "GameConfig.h"
#import "SceneManager.h"
#import "saveSetting.h"


@interface gameBackground()
-(void) setGameBackground;
//-(void)BackToMenu:(id)sender;	
@end


@implementation gameBackground


-(id)init{
	self = [super init];
	if(self){
		//isPause = false;
		[self setGameBackground];
	}
	return self;
}

-(void)setGameBackground{
	int kind = [saveSetting getBackground];
	NSLog(@"%d", kind);
	CCSprite* gameBackground = [CCSprite spriteWithFile:[NSString stringWithFormat: @"GameBackground%d.png", kind] rect:CGRectMake(0,0,ipadWidth,ipadLength)];
	gameBackground.position = ccp(ipadWidth / 2, ipadLength / 2);
	[self addChild:gameBackground z:0];	
}




-(void)dealloc{
	[super dealloc];
}

@end