//
//  TigerLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Tiger.h"

@interface TigerLayer : CCLayer{
    Tiger * tiger[8];
    int tigerNum;
}

+(TigerLayer *)sharedAnimation;
-(void)InitTiger;
-(void)ShowTiger:(int)kind;
-(void)ShowTigerWithRate:(int)rate;

@end
