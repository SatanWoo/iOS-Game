//
//  PourLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PassLayer.h"

@interface PourLayer : CCLayer {
    CCSprite * pour[5];
    CCSprite * line[5];
    bool isOn[5];
    int unitNum;
}

-(void)InitLayer;
-(void)PourNext:(gameMode)mode Level:(int)leve;
-(NSMutableArray *)GetPourUnits;
-(int)GetPourNum;

@end
