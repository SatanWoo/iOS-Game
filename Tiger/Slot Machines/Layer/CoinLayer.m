//
//  CoinLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoinLayer.h"
#import "MusicCenter.h"
#import "GameConfig.h"


@implementation CoinLayer

static CoinLayer *_sharedAnimation = nil;

+(CoinLayer *)sharedAnimation
{
	if (!_sharedAnimation) {
        _sharedAnimation = [[self alloc] init];
	}
	return _sharedAnimation;
}


-(id)init
{
    self = [super init];
    if(self)
    {
        [self InitCoin];
    }
    return self;
}

-(void)InitCoin;
{
    int ds[11] = {0, 1, 3, 6, 9, 12, 15, 18, 21, 24, 27};
    int de[11] = {0, 88, 92, 96, 103, 108, 110, 114, 118, 120, 123};
    for(int i = 1; i <= 10; i++){
        _coinFall[i] = [CoinFall node];
        [_coinFall[i] InitCoinWithPng:[NSString stringWithFormat:OC("jinbi%02d"), i] start:ds[i] end:de[i]];
        [self addChild:_coinFall[i]];
    }
}

-(void)CoinFallStart:(int)s End:(int)e
{
    for(int i = s; i <= e; i++){
        [_coinFall[i] ActionBegin];
    }
}

-(void)ShowCoinWithRate:(int)rate{
    if(rate == 2)  [self CoinFallStart:5 End:5];
    if(rate == 3) [self CoinFallStart:3 End:7];
    if(rate == 4)  [self CoinFallStart:5 End:6];
    if(rate == 7)  [self CoinFallStart:4 End:6];
    if(rate == 10) [self CoinFallStart:4 End:7];
    if(rate == 20) [self CoinFallStart:3 End:7];
    if(rate == 40) [self CoinFallStart:3 End:8];
    if(rate == 60) [self CoinFallStart:2 End:8];
    if(rate == 80) [self CoinFallStart:2 End:9];
    if(rate == 100) [self CoinFallStart:1 End:10];
    tempRate = rate;
    [self performSelector:@selector(PlayEffect) withObject:nil afterDelay:0.4f];
}

-(void)ShowCoinWithScore:(int)score{
    if(score == 20)  [self CoinFallStart:3 End:8]; 
    if(score == 40)  [self CoinFallStart:2 End:8];
    if(score == 80)  [self CoinFallStart:2 End:9];
    if(score == 120) [self CoinFallStart:1 End:10];

    if(score == 20)  tempRate = 40;
    if(score == 40)  tempRate = 60;
    if(score == 80)  tempRate = 80;
    if(score == 120) tempRate = 100;
    [self performSelector:@selector(PlayEffect) withObject:nil afterDelay:0.4f];
}

-(void)PlayEffect
{
    int rate = tempRate;
    if(rate == 2)  [MusicCenter playSoundEffect:moneyRateOne];
    if(rate == 3) [MusicCenter playSoundEffect:moneyRateFive];    
    if(rate == 4)  [MusicCenter playSoundEffect:moneyRateTwo];
    if(rate == 7)  [MusicCenter playSoundEffect:moneyRateThree];
    if(rate == 10) [MusicCenter playSoundEffect:moneyRateFour];
    if(rate == 20) [MusicCenter playSoundEffect:moneyRateFive];
    if(rate == 40) [MusicCenter playSoundEffect:moneyRateFive];
    if(rate == 60) [MusicCenter playSoundEffect:moneyRateSix];
    if(rate == 80) [MusicCenter playSoundEffect:moneyRateSeven];
    if(rate == 100) [MusicCenter playSoundEffect:moneyRateEight];    
}

-(void)dealloc
{
    [super dealloc];
}
@end
