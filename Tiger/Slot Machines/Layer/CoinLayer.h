//
//  CoinLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CoinFall.h"

@interface CoinLayer : CCSprite {
    CoinFall * _coinFall[11];
    int tempRate;
    
}

+(CoinLayer *)sharedAnimation;
-(void)InitCoin;
-(void)ShowCoinWithRate:(int)rate;
-(void)ShowCoinWithScore:(int)score;
-(void)CoinFallStart:(int)s End:(int)e;

@end
