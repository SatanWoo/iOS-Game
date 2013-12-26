//
//  UpLevelLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "UpLevelLayer.h"
#import "GameConfig.h"
#import "MusicCenter.h"


@implementation UpLevelLayer

-(id)init
{
    self = [super init];
    if (self) {
        [MusicCenter playSoundEffect:levelUp];        
        [self InitBar];
        [self BarDrop];
        [self BarBegin];
        [self schedule:@selector(RemoveLayer) interval:10.0f];
    }
    return self;
}

-(void)InitBar
{
    for(int i = 0; i < 100; i++){
        bar[i] = [CCSprite spriteWithFile:[NSString stringWithFormat:OC("tc_ani_caidai_%02d.png"), i % 4 + 1]];
        [bar[i] runAction:[CCFadeOut actionWithDuration:0.0f]];
        [self addChild:bar[i]];
    }
}

-(void)BarDrop
{
    int barNum = 3 + arc4random() % 3;
    for(int i = 0; i < barNum; i++){
        int k = arc4random() % 100;
        int x, y, dx, dy;
        x = arc4random() % 480;
        y = 325;
        dx = arc4random() % 200 - 100;
        dy = -200 + arc4random() % 220 * -1;
        double dist = sqrt(dx * dx + dy * dy);
        CCSequence * action = [CCSequence actions:
                               [CCFadeIn actionWithDuration:0.0],
                               [CCMoveTo actionWithDuration:0.0 position:ccp(x, y)],
                               [CCMoveTo actionWithDuration:dist * 0.02 position:ccp(x + dx, y + dy)],
                               [CCFadeOut actionWithDuration:0.0], nil];
        [bar[k] runAction:action];
    }
    
}

-(void)BarBegin
{
    [self schedule:@selector(BarDrop) interval:0.5f];
}

-(void)BarEnd
{
    [self unschedule:@selector(BarEnd)];
    for(int i = 0; i < 100; i++){
        [bar[i] stopAllActions];
        [bar[i] runAction:[CCFadeOut actionWithDuration:0.0f]];
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
