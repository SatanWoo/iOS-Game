//
//  SceneManager.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
    
#import "SceneManager.h"
#import "CGScence.h"
#import "MenuScence.h"
#import "SelectScence.h"
#import "Single1Scence.h"
#import "Single2Scence.h"
#import "Party1Scence.h"


@implementation SceneManager

+(void)GoCGLayer
{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer *layer = [CGScence node];
    [newScene addChild:layer z:0];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}

+(void)GoMenu{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer* newLayer = [MenuScence node];
    [newScene addChild:newLayer];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}

+(void)GoSelectMode{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer* newLayer = [SelectScence node];
  
    [newScene addChild:newLayer];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}

+(void)GoSingle1{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer* newLayer = [Single1Scence node];
    [newScene addChild:newLayer z:0];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}

+(void)GoSingle2{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer* newLayer = [Single2Scence node];
    [newScene addChild:newLayer z:0];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}

+(void)GoParty1{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer* newLayer = [Party1Scence node];
    [newScene addChild:newLayer z:0];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}

+(void)GoTest{
    CCDirector* director=[CCDirector sharedDirector];
    CCScene* newScene = [CCScene node];
    CCLayer* newLayer = [TigerLayer node];
    [newScene addChild:newLayer z:0];
    if ([director runningScene]) {
        [director replaceScene:[CCTransitionFade transitionWithDuration: 0.3 scene: newScene]];
    }
    else {
        [director runWithScene:newScene];		
    }
}



-(void)dealloc
{
    [super dealloc];
}
@end