//
//  UpLevelLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UpLevelLayer : CCLayer <CCTargetedTouchDelegate> {
    CCSprite * bar[100];
}

-(void)InitBar;
-(void)BarDrop;
-(void)BarBegin;
-(void)BarEnd;

@end
