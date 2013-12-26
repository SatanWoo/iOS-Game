//
//  ItemLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ItemLayer.h"
#import "GameConfig.h"
#import "CalcHelp.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SysConf.h"


#define ITEM_POSITION_X 144
#define ITEM_POSITION_Y 275 
#define ITEM_END_Y ITEM_POSITION_Y - ITEM_INTERVAL * 4
#define ITEM_INTERVAL 50
#define COLUMN_INTERVAL 95
#define SCROLL_SPEED 1000.0f
#define SPEED_VAL 60.0f

@implementation ItemLayer

-(id)init
{
    self = [super init];
    if(self){
        isFinish = isStop = true;
        isSame = isFirst = false;
        stopColumn = -1;
    }
    return self;
}

-(void)InitItemsWithMode:(gameMode)mode Level:(int)level;
{
    sMode = mode;
    sLevel = level;
    NSArray * array;
    if(mode == gameSingleMode && level == 1){
        CCSprite * shelter = [CCSprite spriteWithFile:OC("tc_gi_single_pr_shelter.png")];
        CGSize size = [[CCDirector sharedDirector] winSize];
        shelter.position = ccp(size.width / 2 , size.height / 2);
        [self addChild:shelter z:2];

        array = [NSArray arrayWithObjects:
                    OC("tc_gi_single_pr_yingtao.png"),
                    OC("tc_gi_single_pr_chengzi.png"),
                    OC("tc_gi_single_pr_mangguo.png"),
                    OC("tc_gi_single_pr_lingdang.png"),
                    OC("tc_gi_single_pr_xigua.png"),
                    OC("tc_gi_single_pr_bar1.png"),
                    OC("tc_gi_single_pr_bar2.png"),
                    OC("tc_gi_single_pr_bar3.png"),
                    OC("tc_gi_single_pr_7.png"),
                    OC("tc_gi_single_pr_baoxiang.png"),
                    nil];    
    }

    if(mode == gameSingleMode && level == 2){
        CCSprite * shelter = [CCSprite spriteWithFile:OC("tc_gi_single_in_jiqi.png")];
        CGSize size = [[CCDirector sharedDirector] winSize];
        shelter.position = ccp(size.width / 2 , size.height / 2);
        [self addChild:shelter z:2];
        
        array = [NSArray arrayWithObjects:
                 OC("tc_gi_single_in_tangguo.png"),
                 OC("tc_gi_single_in_shengdanmao.png"),
                 OC("tc_gi_single_in_huahuan.png"),
                 OC("tc_gi_single_in_wazi.png"),
                 OC("tc_gi_single_in_lihe.png"),
                 OC("tc_gi_single_in_xueren.png"),
                 OC("tc_gi_single_in_milu.png"),
                 OC("tc_gi_single_in_shengdanshu.png"),
                 OC("tc_gi_single_in_shengdanlaoren.png"),
                 OC("tc_gi_single_pr_baoxiang.png"),
                 nil];    
    }
    
    
    if (mode == gamePartyMode && level == 1) {
        CCSprite * shelter = [CCSprite spriteWithFile:OC("tc_gi_multi_pr_labaji.png")];
        CGSize size = [[CCDirector sharedDirector] winSize];
        shelter.position = ccp(size.width / 2 , size.height / 2);
        [self addChild:shelter z:2];
        
        array = [NSArray arrayWithObjects:
                    OC("tc_gi_multi_pr_huoguo.png"),
                    OC("tc_gi_multi_pr_mianbao.png"),
                    OC("tc_gi_multi_pr_pisa.png"),
                    OC("tc_gi_multi_pr_shaokao.png"),
                    OC("tc_gi_multi_pr_shitang.png"),
                    OC("tc_gi_multi_pr_shousi.png"),
                    OC("tc_gi_multi_pr_xican.png"),
                    OC("tc_gi_multi_pr_xishikuaican.png"),
                    OC("tc_gi_multi_pr_zhongshikuaican.png"),
                    OC("tc_gi_single_pr_baoxiang.png"),
                    nil];       
    }
    
//
//    initialize all the sprite and set all the sprite invisible
//    
    
    for(int i = 0; i < ITEM_KIND; i++){
        for (int j = 0; j < ITEM_NUM; j++) {
            item[i][j] = [CCSprite spriteWithFile:[array objectAtIndex:i]];
            item[i][j].visible = false;
            [self addChild:item[i][j]];
        }
    }

//
//    initialize the sprite showing in the machine
//    set these sprite visible
//    
    for(int line = 0; line < 3; line ++){
        int itemUnit = [CalcHelp RaCalcWithMode:sMode Level:sLevel];
        for(int column = 0; column < 3; column++){
            int itemKind = [CalcHelp GetDigitNum:itemUnit Th:column];
            for(int i = 0; i < ITEM_NUM; i++){
                if(item[itemKind][i].visible) continue;
                item[itemKind][i].visible = true;
                item[itemKind][i].position = ccp(ITEM_POSITION_X + COLUMN_INTERVAL * column,ITEM_POSITION_Y - ITEM_INTERVAL * (line + 1));
                break;
            }
        }
    }
}

-(void)cVisible:(id)sender data:(void *)sp
{
    CCSprite * temp = sp;
    temp.visible = false;
}

-(void)InitScroll{
    for(int i = 0; i < 3; i++)
        for(int j = 0; j < 3; j++)
            [final[i][j] stopAllActions];
    for(int i = 0; i < ITEM_KIND; i++)
        for(int j = 0; j < ITEM_NUM; j++){
            if(item[i][j].visible){
                double runTime = (item[i][j].position.y - (ITEM_POSITION_Y - ITEM_INTERVAL * 4)) / SCROLL_SPEED ;
                CCSequence * action = [CCSequence actions:
                                       [CCMoveTo actionWithDuration:runTime position:ccp(item[i][j].position.x, ITEM_POSITION_Y - ITEM_INTERVAL * 4)],
                                       [CCCallFuncND actionWithTarget:self selector:@selector(cVisible:data:) data:(void *)item[i][j]],
                                       nil];
                [item[i][j] runAction:action];
            }
        }
}

-(void)FinalScroll:(int)column{
    for(int line = 0; line < 3; line ++){
        int itemKind = itemStatu[line][column];
        for(int i = 0; i < ITEM_NUM; i++){
            if(item[itemKind][i].visible) continue;
            item[itemKind][i].visible = true;
            final[line][column] = item[itemKind][i];
            item[itemKind][i].position = ccp(ITEM_POSITION_X + column * COLUMN_INTERVAL, ITEM_POSITION_Y);
            CGPoint reachPoint = ccp(ITEM_POSITION_X + COLUMN_INTERVAL * column,ITEM_POSITION_Y - ITEM_INTERVAL * (line + 1));
            id delay = [CCDelayTime actionWithDuration:(2 - line) * ITEM_INTERVAL / speed];
            id move = [CCMoveTo actionWithDuration:(ITEM_POSITION_Y - reachPoint.y) / speed position:reachPoint];
            CCSequence *action = [CCSequence actions:delay, move, nil];
            [item[itemKind][i] runAction:action];
            break;
        }
    }
}

-(void)SlowScroll{
    if(speed < 400){
        [self FinalScroll:stopColumn];
        stopColumn++;
        if(stopColumn >= 3){
            [self performSelector:@selector(CallBack) withObject:nil afterDelay:1.0 / speed * 3 * ITEM_INTERVAL];
            return;
        }
        speed = SCROLL_SPEED - SPEED_VAL;
        [self performSelector:@selector(SlowScroll) withObject:nil afterDelay:ITEM_INTERVAL / speed];
        return;
    }else{
        speed = speed - SPEED_VAL;
        [self performSelector:@selector(SlowScroll) withObject:nil afterDelay:ITEM_INTERVAL /speed];
    }
    int itemKind = arc4random() % 10;
    for(int j = 0; j < ITEM_NUM; j++){
        if(item[itemKind][j].visible) continue;
        item[itemKind][j].visible = true;
        CGPoint point = ccp(ITEM_POSITION_X + stopColumn * COLUMN_INTERVAL, ITEM_POSITION_Y);
        item[itemKind][j].position = point;
        CCSequence * action = [CCSequence actions:
                                [CCMoveTo actionWithDuration:ITEM_INTERVAL * 4 / speed
                                                       position:ccp(point.x, point.y - ITEM_INTERVAL * 4)],
                                [CCCallFuncND actionWithTarget:self selector:@selector(cVisible:data:) data:(void *)item[itemKind][j]],
                                   nil];
        [item[itemKind][j] runAction:action];
        break;
    }
}

-(void)CallBack
{
    stopColumn = -1;
    isSame = false;
    isFinish = true;
    [self unscheduleAllSelectors];
    [self.parent ScrollFinish];
}

-(void)SpriteAction{
    if(isStop && stopColumn == -1){
        stopColumn++;
        speed = speed - SPEED_VAL;
        [self performSelector:@selector(SlowScroll) withObject:nil afterDelay:ITEM_INTERVAL / speed];
    }
    int itemUnit = [CalcHelp RaCalcWithMode:1 Level:1];
    for(int column = stopColumn + 1; column < 3; column++){
        if(isStopLine[column] == 1){
            isStopLine[column]++;
            speed = SCROLL_SPEED;
            [self FinalScroll:column];
            if (stopLineNum == 3) {
                [self performSelector:@selector(CallBack) withObject:nil afterDelay:1.0 / speed * 3 * ITEM_INTERVAL];
            }
        }
        if(isStopLine[column] > 0) continue;
        int itemKind = [CalcHelp GetDigitNum:itemUnit Th:column];
        if(isSame) itemKind = [CalcHelp GetDigitNum:itemUnit Th:0];
        for(int j = 0; j < ITEM_NUM; j++){
            if(item[itemKind][j].visible) continue;
            item[itemKind][j].visible = true;
            CGPoint point = ccp(ITEM_POSITION_X + column * COLUMN_INTERVAL, ITEM_POSITION_Y);
            item[itemKind][j].position = point;
            CCSequence * action = [CCSequence actions:
                                   [CCMoveTo actionWithDuration:ITEM_INTERVAL * 4 / SCROLL_SPEED
                                                       position:ccp(point.x, point.y - ITEM_INTERVAL * 4)],
                                   [CCCallFuncND actionWithTarget:self selector:@selector(cVisible:data:) data:(void *)item[itemKind][j]],
                                   nil];
            [item[itemKind][j] runAction:action];
            break;
        }
    }
}

-(void)ActionBegin
{
    memset(isStopLine, 0, sizeof(isStopLine));
    stopKind = 0;
    stopLineNum = 0;
    isStop = isFinish = false;
    speed = SCROLL_SPEED;
    speedVal = SPEED_VAL;
    for(int line = 0; line < 3; line ++){
        int itemUnit = [CalcHelp RaCalcWithMode:sMode Level:sLevel];
        for(int column = 0; column < 3; column++){
            int itemKind = [CalcHelp GetDigitNum:itemUnit Th:column];
            if(isSame) itemKind = [CalcHelp GetDigitNum:itemUnit Th:0];
            itemStatu[line][column] = itemKind;
        }
    }
    if(isFirst) itemStatu[1][0] = itemStatu[1][1] = itemStatu[1][2] = 8;
    isFirst = false;
    
    [self performSelector:@selector(InitScroll) withObject:nil afterDelay:ITEM_INTERVAL / SCROLL_SPEED];
    [self schedule:@selector(SpriteAction) interval:ITEM_INTERVAL / SCROLL_SPEED];
    [self performSelector:@selector(ActionStop) withObject:nil afterDelay:3.0f];
}

-(void)ActionStop
{
    if(stopKind != 0) return;
    stopKind = 1;  //automatic
    isStop = true;
}

-(void)ActionStopLine:(int)th
{
    if(stopKind != 0 && stopKind != 2) return;
    if(isStopLine[th] != 0) return;
    stopKind = 2;   //manual
    isStopLine[th] = 1;
    stopLineNum ++;
}

-(bool)IsFinish
{
    return isFinish;
}

-(void)SetTheSame
{
    isSame = true;
}

-(void)SetTheFirst
{
    isFirst = true;
}

//     0 ***
//
//     2 *** 
//
//     4 ***
//     
//     1
//        *
//         *
//          *
//     3
//          *
//         *
//        *

-(int)GetItem:(int)kind
{
    int itemArray[][3] = {{0, 1, 2}, {2, 11, 20}, {10, 11, 12}, {0, 11, 22}, {20, 21, 22}};
    int cnt = 0;
    for(int i = 0; i < 3; i++){
        cnt = cnt * 10 + itemStatu[itemArray[kind][i] / 10][itemArray[kind][i] % 10];
    }
    return cnt;
}

-(NSMutableArray *)GetItemUnits:(NSMutableArray *)pourUnits
{
    NSMutableArray * itemUnits= [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++){
        if([[pourUnits objectAtIndex:i] intValue] == 1){
            [itemUnits addObject:[NSNumber numberWithInt:[self GetItem:i]]];
        }
    }
    return itemUnits;
}

-(void)SetBlinkUnits:(NSMutableArray *)pourUnits
{

    int blinkArray[][3]= {{0, 1, 2}, {0, 0, 0}, {10, 11, 12}, {0, 0, 0}, {20, 21, 22}};
    CCAction * actionBlink[3][3];
    for(int i = 0; i < 3; i++) 
        for(int j = 0; j < 3; j++)
            actionBlink[i][j] = [CCBlink actionWithDuration:4.0 blinks:6];    

    bool isBlink = false;
    for (int k = 0; k < 5; k++) 
        if([[pourUnits objectAtIndex:k] intValue] && [CalcHelp GetUnitKind:[self GetItem:k]] != 0){
            isBlink = true;
            for(int i = 0; i < 3; i++){
                int x = blinkArray[k][i] / 10;
                int y = blinkArray[k][i] % 10;
                [final[x][y] runAction:actionBlink[x][y]];
            }
        }
    if(isBlink && [SysConf IsShockEffect]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
}

-(void)dealloc
{
    [super dealloc];
}

@end
