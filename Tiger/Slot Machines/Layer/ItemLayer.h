//
//  ItemLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PassLayer.h"

#define ITEM_KIND 10
#define ITEM_NUM 20

@interface ItemLayer : CCLayer{
    CCSprite * item[ITEM_KIND][ITEM_NUM];
    int itemStatu[3][3];
    CCSprite * final[3][3];
    int isStopLine[3];
    int stopColumn;
    double speed, speedVal;
    bool isStop, isFinish, isSame;
    gameMode sMode;
    int sLevel;
    int stopKind;
    int stopLineNum;
    bool isFirst;
    
}

-(void)InitItemsWithMode:(gameMode)mode Level:(int)level;
-(void)ActionBegin;
-(void)ActionStop;
-(void)ActionStopLine:(int)th;
-(void)FinalScroll:(int)column;
-(bool)IsFinish;
-(void)SetTheSame;
-(void)SetTheFirst;

-(NSMutableArray *)GetItemUnits:(NSMutableArray *)pourUnits;
-(void)SetBlinkUnits:(NSMutableArray *)pourUnits;


@end
