//
//  BuyLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BuyCoinViewController.h"
#import "RootViewController.h"

@interface BuyLayer  : CCLayer <CCTargetedTouchDelegate,BuyCoinDelegate> {
    BuyCoinViewController *_buyVC;
}

-(void)LoadImage;

@end
