//
//  MenuScence.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TigerCoinGo.h"
#import "Arrow.h"
#import "AboutLayer.h"
#import "SnowLayer.h"


@interface MenuScence : CCLayer{
    TigerCoinGo * _goSticker;
    Arrow * _arrow;
    SnowLayer * _snowLayer;

    CCLayer * control;
    CCMenuItemToggle* soundToggle;
    bool isPop;

}

-(void)LoadMenu;
-(void)LoadImage;
-(void)InitPopLayer;

@end
