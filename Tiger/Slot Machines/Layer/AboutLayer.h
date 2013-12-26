//
//  AboutLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SnowLayer.h"

@interface AboutLayer : CCLayer <CCTargetedTouchDelegate> {
    CCSprite * logoSprite, * wordSprite;
    SnowLayer * _snowLayer;
}

-(void)LoadImage;

@end
