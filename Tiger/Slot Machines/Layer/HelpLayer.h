//
//  HelpLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HelpLayer : CCLayer {
    CCSprite * helpSprite;
    CCSprite * arrowSprite;
    int nowStep;
}

-(void)HelpFirst;
-(void)ShowBoard1;
-(void)ShowBoard2;
-(void)NextStep;
-(int)GetStep;

@end
