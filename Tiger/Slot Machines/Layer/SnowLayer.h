//
//  SnowLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SnowLayer : CCLayer {
    CCSprite * snowPoint[100];
}

-(void)InitSnow;
-(void)SnowDrop;
-(void)SnowBegin;
@end
