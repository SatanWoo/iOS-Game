//
//  SnowLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SnowLayer.h"
#import "GameConfig.h"

@implementation SnowLayer

-(id)init
{
    self = [super init];
    if (self) {
        [self InitSnow];
        [self SnowDrop];
        [self SnowBegin];
    }
    return self;
}

-(void)InitSnow
{
    for(int i = 0; i < 100; i++){
        snowPoint[i] = [CCSprite spriteWithFile:OC("tc_mi_snow.png")];
        [self addChild:snowPoint[i]];
    }
}

-(void)SnowDrop
{
    int snowNum = 3 + arc4random() % 3;
    for(int i = 0; i < snowNum; i++){
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
                               [CCMoveTo actionWithDuration:dist * 0.05 position:ccp(x + dx, y + dy)],
                               [CCFadeOut actionWithDuration:0.0], nil];
        [snowPoint[k] runAction:action];
    }
    
}

-(void)SnowBegin
{
    [self schedule:@selector(SnowDrop) interval:2.0f];
}

-(void)dealloc
{
    [super dealloc];
}

@end
