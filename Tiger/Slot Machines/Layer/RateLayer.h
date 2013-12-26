//
//  RateLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RateViewController.h"
#import "RootViewController.h"

@interface RateLayer : CCLayer <CCTargetedTouchDelegate,RateViewDelegate> {
    RateViewController *_rateViewController;
}

-(void)setBackground:(NSString *)name;

@end
