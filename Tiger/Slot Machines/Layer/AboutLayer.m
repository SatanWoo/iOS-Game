//
//  AboutLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutLayer.h"
#import "GameConfig.h"

#define SCROLL_SPEED 50


@implementation AboutLayer


-(id)init
{
    self = [super init];
    if(self)
    {
        [self LoadImage];
        [self performSelector:@selector(ScrollInfo) withObject:nil afterDelay:2.0];
    }
    return self;
}

-(void)LoadImage
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite * backgroundImage = [CCSprite spriteWithFile:OC("tc_ch_mi_bk.png")];
    backgroundImage.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:backgroundImage];
    
    _snowLayer = [SnowLayer node];
    [self addChild:_snowLayer];
    
    CCSprite * shelter = [CCSprite spriteWithFile:OC("tc_i_zhezhao.png")];
    shelter.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:shelter];
    
    logoSprite = [CCSprite spriteWithFile:OC("tc_i_logo.png")];
    logoSprite.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:logoSprite];
    wordSprite = [CCSprite spriteWithFile:OC("tc_i_attendant.png")];
    wordSprite.position = ccp(size.width / 2 , size.height / 2 - 400);
    [self addChild:wordSprite];
}

-(void)ScrollInfo
{
    CGSize size = [[CCDirector sharedDirector] winSize];

    [logoSprite runAction:[CCMoveTo actionWithDuration:(800 - logoSprite.position.y) / SCROLL_SPEED 
                                              position:ccp(size.width / 2 ,800)]];
    [wordSprite runAction:[CCMoveTo actionWithDuration:(800 - wordSprite.position.y) / SCROLL_SPEED 
                                              position:ccp(size.width / 2 ,800)]];    
    [self schedule:@selector(CheckAction) interval:0.1];
    
    
}

-(void)CheckAction
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    if(logoSprite.position.y > 600 && logoSprite.position.y > wordSprite.position.y){
        [logoSprite stopAllActions];
        logoSprite.position = ccp(size.width / 2 ,wordSprite.position.y - 400);
        [logoSprite runAction:[CCMoveTo actionWithDuration:(800 - logoSprite.position.y) / SCROLL_SPEED 
                                                  position:ccp(size.width / 2 ,800)]];
    }
    
    if(wordSprite.position.y > 500 && logoSprite.position.y < wordSprite.position.y){
        [wordSprite stopAllActions];
        wordSprite.position = ccp(size.width / 2 ,logoSprite.position.y - 350);
        [wordSprite runAction:[CCMoveTo actionWithDuration:(800 - wordSprite.position.y) / SCROLL_SPEED 
                                                  position:ccp(size.width / 2 ,800)]];            
    }
}


- (void)onEnter
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:kCCMenuTouchPriority swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}

-(void)RemoveLayer
{
    [self removeFromParentAndCleanup:YES];
}

-(BOOL)ccTouchBegan :(UITouch *)touch withEvent:(UIEvent *)event
{
    [self RemoveLayer];
    return YES;
}

-(void)dealloc
{
    [super dealloc];
}

@end
