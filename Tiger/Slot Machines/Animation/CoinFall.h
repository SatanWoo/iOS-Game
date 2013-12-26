//
//  CoinFall.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CoinFall : CCSprite {
    CCSprite * _image;
    CCSpriteBatchNode * _spriteSheet;
    CCSequence * _action;
}

@property(nonatomic,retain) CCSprite * image;
@property(nonatomic,retain) CCSpriteBatchNode * spriteSheet;
@property(nonatomic,retain) CCSequence * action;

-(void)InitCoinWithPng:(NSString *)name start:(int)s end:(int)e;
-(void)ActionBegin;



@end