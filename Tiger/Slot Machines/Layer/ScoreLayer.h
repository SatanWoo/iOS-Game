//
//  ScoreLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "InsertCoin.h"

@interface ScoreLayer : CCLayer {
    CCSprite * large, * middle, * small;
    CCSprite * itemL, * itemR;
    CCSprite * coinShow;
    
    CCSprite * expSp[80];
    CCSprite * engSp[80];
    CCSprite * expSpl, * expSpr;
    CCSprite * engSpl, * engSpr;
    
    CCLabelTTF * scoreLabel;
    CCLabelTTF * debtLabel;
    CCLabelTTF * winLabel;
    CCLabelTTF * levelLabel;
    CCLabelTTF * downLabel;
    int scoreNum;
    int debtNum;
    int winNum;
    int levelNuml;
    int expNum;
    int engNum;
    int coundDownTime;
    bool reDebt;
}

-(void)InitCoinHeap;
-(void)SetDrawer:(NSString *)name;
-(void)InitSlide;
-(void)InitLabel;
-(void)Refresh;
-(void)AddDebtWithLimit:(int)limit WithPourNum:(int)pourNum;
-(int)GetDebt;
-(void)SetDebtZero;
-(void)MinusDebt:(int)pourNum;
-(void)AddScoreWithScore:(int)score;
-(void)AddScoreWithRate:(int)rate;
-(bool)AddExp:(int)exp;
-(bool)AddEng:(int)eng;
-(void)LevelUp;
-(int)GetLevel;
-(void)EngReset;
-(int)GetEng;
@end
