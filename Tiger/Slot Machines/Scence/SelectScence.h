//
//  SelectScence.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RedeemLayer.h"
#import "PassLayer.h"


@interface SelectScence : CCLayer<CCTargetedTouchDelegate> {
    CCLayer * singleLayer;
    CCLayer * partyLayer;
    CCMenuItemToggle * slevel1, * slevel2, * slevel3;
    CCMenuItemToggle * plevel1, * plevel2, * plevel3;
    CCMenuItemSprite * point1, * point2;
    RedeemLayer * _redeemLayer;
    gameMode selectMode;
    int selectLevel;
    int sx, px;
    int begin, move, end, offset;
    bool isAction;
}

-(void)Load;
-(void)SingleLayerInit;
-(void)PartyLayerInit;
-(void)PassRefresh;
-(void)AddLoadLayer;
@end
