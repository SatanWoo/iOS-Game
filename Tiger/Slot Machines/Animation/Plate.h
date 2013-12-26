//
//  Plate.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Plate : CCLayer<CCTargetedTouchDelegate> {
    CCSprite * background;
    CCSprite * plate;
    CCSprite * pointer;
    bool isFinish;
    bool isBegin;
    unsigned int treaRunPoint;
}

-(void)InitPlate;
-(void)StopPlate;

@end
