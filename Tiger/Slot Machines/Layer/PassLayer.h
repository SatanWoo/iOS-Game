//
//  PassLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum 
{
    gameSingleMode = 0 ,
    gamePartyMode = 1,
}gameMode;

@interface PassLayer  : CCLayer <CCTargetedTouchDelegate> {
    gameMode nowMode;
    int needLevel, needCoin;
}

-(void)LoadImage;
-(void)SetInfo:(NSString *)name Mode:(gameMode)mode Level:(int)level Coin:(int)coin;
-(void)RemoveLayer;
@end
