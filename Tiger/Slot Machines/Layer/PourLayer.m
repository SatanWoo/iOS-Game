//
//  PourLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PourLayer.h"
#import "GameConfig.h"


@implementation PourLayer

-(id)init
{
    self = [super init];
    if(self){
        [self InitLayer];
    }
    return self;
}

-(void)InitLayer
{
    for (int i = 0 ; i < 5; i++) {
        CCSprite *temp = [CCSprite spriteWithFile:OC("tc_gi_single_pr_dengoff_31 32.png")];
        temp.position = ccp(85, 237 - i * 30);
        [self addChild:temp z:1];
    }
    for (int i = 0; i < 5; i++) {
        if(i == 0 || i == 4)
            pour[i] = [CCSprite spriteWithFile:OC("tc_gi_single_pr_dengon1_31 32.png")];
        if(i == 1 || i == 3)
            pour[i] = [CCSprite spriteWithFile:OC("tc_gi_single_pr_dengon2.png")];
        if(i == 2)
            pour[i] = [CCSprite spriteWithFile:OC("tc_gi_single_pr_dengon3_31 32.png")];
        pour[i].position = ccp(85,237 - i * 30);
        pour[i].visible = false;
        [self addChild:pour[i] z:2];
    }
    for(int i = 0; i < 5; i++){
        if(i == 0 || i == 4) line[i] = [CCSprite spriteWithFile:OC("tc_ga_line_green.png")];
        if(0 < i && i < 4) line[i] = [CCSprite spriteWithFile:OC("tc_ga_line_red.png")];
        line[i].position = ccp(241,240 - i * 30.5);
        line[i].visible = false;
        [self addChild:line[i]];
    }
    unitNum = 1;
    line[2].visible = pour[2].visible = true;
}

-(void)PourNext:(gameMode)mode Level:(int)level
{
    int preSet[][5]={{1, 0, 0, 0, 0},
                     {0, 0, 1, 0, 0},
                     {0, 0, 0, 0, 1},
                     {1, 0, 1, 0, 1},
                     {0, 0, 0, 0, 0}};
    if(mode == gameSingleMode && level == 1){
        if(unitNum == 0) unitNum = 1;else
        if(unitNum == 1) unitNum = 2;else
        if(unitNum == 2) unitNum = 0;
        for(int i = 0; i < 5; i++)
            line[i].visible = pour[i].visible = preSet[unitNum][i];
    }
    
    if(mode == gameSingleMode && level == 2){
        if(unitNum == 1) unitNum = 0;else
        if(unitNum == 0) unitNum = 2;else
        if(unitNum == 2) unitNum = 3;else
        if(unitNum == 3) unitNum = 1;
        for(int i = 0; i < 5; i++)
            line[i].visible = pour[i].visible = preSet[unitNum][i];
    }
    
    if(mode == gamePartyMode && level == 1){
        if(unitNum == 0) unitNum = 1;else
        if(unitNum == 1) unitNum = 2;else
        if(unitNum == 2) unitNum = 0;
        for(int i = 0; i < 5; i++)
            line[i].visible = pour[i].visible = preSet[unitNum][i];
    }    
}
-(NSMutableArray *)GetPourUnits
{
    int preSet[][5]={{1, 0, 0, 0, 0},
                     {0, 0, 1, 0, 0},
                     {0, 0, 0, 0, 1},
                     {1, 0, 1, 0, 1},
                     {0, 0, 0, 0, 0}};
    NSMutableArray * pourUnits = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++){
        NSNumber *temp = [NSNumber numberWithInt:preSet[unitNum][i]];
        [pourUnits addObject:temp];
    }
    return pourUnits;
}

-(int)GetPourNum
{
    if(unitNum == 0 || unitNum == 1 || unitNum == 2)return 1;
    if(unitNum == 3) return 3;
    return 0;
}

-(void)dealloc
{
    [super dealloc];
}

@end
