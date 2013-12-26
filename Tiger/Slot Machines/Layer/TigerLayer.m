//
//  TigerLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TigerLayer.h"
#import "MusicCenter.h"
#import "GameConfig.h"


@implementation TigerLayer


static TigerLayer *_sharedAnimation = nil;

+ (TigerLayer *)sharedAnimation
{
	if (!_sharedAnimation) {
        _sharedAnimation = [[self alloc] init];
	}
	return _sharedAnimation;
}


-(id)init
{
    self = [super init];
    if (self) {
        tigerNum = 0;
        [self InitTiger];
            
    }
    return self;
}

-(void)InitTiger
{
    CCSprite * body = [CCSprite spriteWithFile:OC("tc_tiger_body.png")];
    body.position = ccp(450, 90);
    [self addChild:body];
                                                  
                                                  
                                                  
                                            
    NSArray * array = [NSArray arrayWithObjects:
                       OC("tc_ani_tiger_sx1"),
                       OC("tc_ani_tiger_sx2"),
                       OC("tc_ani_tiger_sx3"),
                       OC("tc_ani_tiger_sx4"),
                       OC("tc_ani_tiger_sx5"),
                       OC("tc_ani_tiger_happy"),                       
                       OC("tc_ani_tiger_standby"),
                       nil];    
    for(int i = 0; i < 7; i++){
        tiger[i] = [Tiger node];
        [tiger[i] InitTigerWithPng:[array objectAtIndex:i]];
        [self addChild:tiger[i]];
    }
}

-(void)ShowTiger:(int)kind
{
    for(int i = 0; i < 7; i++) [tiger[i] SetActionable:false];
    [tiger[kind] SetActionable:true];
}

-(void)ShowTigerWithRate:(int)rate{
    if(2 <= rate && rate <= 7){
        [self ShowTiger:0];
        [MusicCenter playSoundEffect:silly];
    }
    if(10 <= rate && rate <= 18){
        [self ShowTiger:1];
        [MusicCenter playSoundEffect:embarrassment];        
    }
    if(20 <= rate && rate <= 40){
        [MusicCenter playSoundEffect:dizzy];
        [self ShowTiger:2];
    }
    if(60 <= rate && rate <= 80){
        [MusicCenter playSoundEffect:cry];
        [self ShowTiger:3];
    }
    if((100 <= rate && rate <= 100) || rate == -1){
        [MusicCenter playSoundEffect:angry];
        [self ShowTiger:4];        
    }
    if(rate == 0){
        [MusicCenter playSoundEffect:happy];
        [self ShowTiger:5];
    }
}

-(void)dealloc
{
    [super dealloc];
}
@end
