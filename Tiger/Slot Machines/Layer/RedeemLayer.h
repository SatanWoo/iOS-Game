//
//  RedeemLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RedeemLayer : CCLayer <CCTargetedTouchDelegate> {
    CCSprite * logoSprite, * wordSprite;
}

-(void)LoadImage;

@end
