//
//  Plate.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Plate.h"
#import "MusicCenter.h"
#import "GameConfig.h"


@implementation Plate


-(id)init
{
    self = [super init];
    if (self) {
        isBegin = isFinish = false;
        [MusicCenter playSoundEffect:treasure];
        [self InitPlate];
    }
    return self;
}

-(void)InitPlate
{
    CGSize size = [[CCDirector sharedDirector] winSize];    
    background = [CCSprite spriteWithFile:OC("tc_zhezhaoceng.png")];    
    background.position =ccp(size.width / 2, size.height / 2);
    background.opacity = 0;
    [background runAction:[CCFadeIn actionWithDuration:1.0f]];
    [self addChild:background];
    
    pointer = [CCSprite spriteWithFile:OC("tc_tt_zhizhen.png")];
    pointer.position = ccp(size.width / 2 + 5, size.height / 2 - 5);
    pointer.opacity = 0;
    [pointer runAction:[CCFadeIn actionWithDuration:1.0f]];
    [self addChild:pointer z:3];
    
    plate = [CCSprite spriteWithFile:OC("tc_tt_pan.png")];
    plate.position = ccp(size.width / 2, size.height / 2 + 0);
    plate.opacity = 0;
    [plate runAction:[CCFadeIn actionWithDuration:1.0f]];
    [self addChild:plate z:2];
}

-(int)GetRotateAngle{
    CGSize size = [[CCDirector sharedDirector] winSize];    
    CGPoint point;
    point = [plate convertToWorldSpace:ccp(size.width / 2, size.height / 2)];
    double x = (point.x - size.width / 2);
    double y = (point.y - size.height / 2);
    double d = sqrt(x * x + y * y);
    int angle = (int)(acos(x / d) / 3.14159 * 180);
    if(asin(y / d) > 0) angle = 360 - angle;
    angle = (angle + 39) % 360;
    return angle;
}

-(int)GetType{
    return [self GetRotateAngle] / 45 + 1;
}

-(int)GetMoney
{
    int type = [self GetType];
    if(type == 5) return 20;
    if(type == 1 || type == 2 || type == 7) return 40;
    if(type == 6 || type == 8) return 80;
    if(type == 3) return 120;
    if(type == 4) return 0;
    return -1;
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


-(void)CallBack
{
    [self.parent PlateFinish:[self GetMoney]];
    [self removeFromParentAndCleanup:YES];
}

-(void)StopPlate
{
    [self unschedule:@selector(StopPlate)];
    [MusicCenter stopEffect:treaRunPoint];
    [MusicCenter playSoundEffect:treastop];
    [plate stopAllActions];
    [self performSelector:@selector(CallBack) withObject:nil afterDelay:2.0f];
}

-(BOOL)ccTouchBegan :(UITouch *)touch withEvent:(UIEvent *)event
{
    if(isFinish) return YES;
    if(!isBegin){
        isBegin = true;
        [plate runAction:[CCRepeatForever actionWithAction:[CCRotateBy actionWithDuration:0.1f angle:270]]];
        treaRunPoint = [MusicCenter playSoundEffect:trearun];
        [self schedule:@selector(StopPlate) interval:3.5f + arc4random()% 50 / 100.0];
    }else
    {
        [self schedule:@selector(StopPlate) interval:0.5f + arc4random()% 50 / 100.0];
        isFinish = true;
    }
    return YES;
}

-(void)dealloc
{
    [super dealloc];
}

@end
