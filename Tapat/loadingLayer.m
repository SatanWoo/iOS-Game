//
//  loadingLayer.m
//  tapat
//
//  Created by 吴 wuziqi on 11-2-27.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "loadingLayer.h"
#import "GameConfig.h"
#import "musiceHandle.h"
#import "SceneManager.h"


@implementation loadingLayer

@synthesize gameCenterManager;

+(id)scene
{
	CCScene* scene =[CCScene node];
	
	CCScene* layer =[loadingLayer node];
	
	[scene addChild:layer];
	
	return  scene;
}

-(id)init
{
    self =[super init];
    if(self)
    {
        [self gameCenterFunction];
        [musiceHandle preload];
        index=1;
        CCSprite* background=[CCSprite spriteWithFile:@"loading.png" rect:CGRectMake(0,0,1024,768)];
        background.position=ccp(ipadWidth/2,ipadLength/2);
        [self addChild:background z:0];
        
        loadingBar=[CCSprite spriteWithFile:@"loading0.png" rect:CGRectMake(0,0,700,400)];
        loadingBar.position=ccp(ipadWidth/2-25,ipadLength/2-130);
        [self addChild:loadingBar z:1];
        [self schedule:@selector(loadingBar) interval:0.5f];
    }
    return self;
}

-(void)loadingBar
{
    if(index>4)
    {
        [self unschedule:@selector(loadingBar)];
        [self removeChild:loadingBar cleanup:YES];
        index=1;
        [SceneManager goMenu:nil];
        return ;
    }
    [self removeChild:loadingBar cleanup:YES];
    NSString* stringTemp=[NSString stringWithFormat:@"loading%d.png",index];
    loadingBar=[CCSprite spriteWithFile:stringTemp rect:CGRectMake(0,0,700,400)];
    loadingBar.position=ccp(ipadWidth/2-25,ipadLength/2-130);
    [self addChild:loadingBar z:1];
    index++;
    
}

-(void)dealloc
{
    [self.gameCenterManager setDelegate:nil];
	[gameCenterManager release];
    [super dealloc];
}

- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message
{
	UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: title message: message 
												   delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL] autorelease];
	[alert show];
	
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

#pragma mark -
#pragma mark delegate


- (void) processGameCenterAuth: (NSError*) error
{
	if(error == NULL)
	{
		;
	}
	else
	{
		UIAlertView* alert= [[[UIAlertView alloc] initWithTitle: @"Game Center Account Required" 
														message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]
													   delegate: self cancelButtonTitle: @"Try Again..." otherButtonTitles: NULL] autorelease];
		[alert show];
	}
	
}


@end
