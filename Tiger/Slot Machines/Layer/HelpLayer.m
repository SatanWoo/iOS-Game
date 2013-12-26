//
//  HelpLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpLayer.h"
#import "GameConfig.h"


@implementation HelpLayer

int dx[] = {0, 370, 365, 90, -100, -100};
int dy[] = {0, 120, 305, 280, -100, -100};

-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}

-(void)HelpFirst
{
    nowStep = 1;
    helpSprite = [CCSprite spriteWithFile:OC("tc_mission_help1.png")];
    helpSprite.position = ccp(340, 185);
    [self addChild:helpSprite];
    arrowSprite = [CCSprite spriteWithFile:OC("tc_mission_jiantou.png")];
    arrowSprite.position = ccp(dx[nowStep], dy[nowStep]);
    [self addChild:arrowSprite];
    CCSequence * action = [CCSequence actions:
                           [CCDelayTime actionWithDuration:0.2f],
                           [CCMoveTo actionWithDuration:0.0f position:ccp(dx[nowStep], dy[nowStep])],
                           [CCMoveTo actionWithDuration:1.0f position:ccp(dx[nowStep] + 20, dy[nowStep] - 20)],
                           nil];
    [arrowSprite runAction:[CCRepeatForever actionWithAction:action]];            
}

-(void)NextStep{
    nowStep ++;
    if(nowStep <= 5){
        [self removeChild:helpSprite cleanup:YES];
        helpSprite = [CCSprite spriteWithFile:[NSString stringWithFormat:OC("tc_mission_help%d.png"),nowStep]];
        helpSprite.position = ccp(340, 185);
        CCSequence * actionDis = [CCSequence actions:
                                  [CCDelayTime actionWithDuration:2.0f],
                                  [CCFadeOut actionWithDuration:2.0f],
                                  nil];
        [helpSprite runAction:actionDis];
        [self addChild:helpSprite];
        [arrowSprite stopAllActions];
        CCSequence * action = [CCSequence actions:
                               [CCDelayTime actionWithDuration:0.2f],
                               [CCMoveTo actionWithDuration:0.0f position:ccp(dx[nowStep], dy[nowStep])],
                               [CCMoveTo actionWithDuration:1.0f position:ccp(dx[nowStep] + 20, dy[nowStep] - 20)],
                               nil];
        [arrowSprite runAction:[CCRepeatForever actionWithAction:action]];
    }else{
        [self removeChild:helpSprite cleanup:YES];
        [arrowSprite stopAllActions];
        [self removeChild:arrowSprite cleanup:YES];
    }
    if(nowStep == 4) [self performSelector:@selector(NextStep) withObject:nil afterDelay:5.0];
    if(nowStep == 5) {
        [self.parent SetHelpless];
        [self performSelector:@selector(RemoveLayer) withObject:nil afterDelay:6.0];
    }
}

-(void)ShowBoard1
{
    helpSprite = [CCSprite spriteWithFile:OC("tc_mission_board1.png")];
    helpSprite.position = ccp(340, 185);
    [self addChild:helpSprite];
    CCSequence * actionDis = [CCSequence actions:
                              [CCDelayTime actionWithDuration:2.0f],
                              [CCFadeOut actionWithDuration:2.0f],
                              nil];
    [helpSprite runAction:actionDis];    
    if(nowStep == 5) [self performSelector:@selector(RemoveLayer) withObject:nil afterDelay:6.0];
}

-(void)ShowBoard2
{
    helpSprite = [CCSprite spriteWithFile:OC("tc_mission_board2.png")];
    helpSprite.position = ccp(340, 185);
    [self addChild:helpSprite];    
    CCSequence * actionDis = [CCSequence actions:
                              [CCDelayTime actionWithDuration:2.0f],
                              [CCFadeOut actionWithDuration:2.0f],
                              nil];
    [helpSprite runAction:actionDis];    
    [self performSelector:@selector(RemoveLayer) withObject:nil afterDelay:6.0];
}


-(void)RemoveLayer
{
    [self removeFromParentAndCleanup:YES];
}

-(int)GetStep{
    return nowStep;
}

-(void)dealloc
{
    [super dealloc];
}

@end
