//
//  CalcHelp.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CalcHelp.h"
#import "GameConfig.h"

@implementation CalcHelp

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+(int)RaCalcWithMode:(gameMode)mode Level:(int)level{
    if(mode == gameSingleMode && level == 1){
        double temp[10] = {45, 20, 16, 13, 11, 8, 6, 3, 1, 5};
        double resp[10] = {000, 111, 222, 333, 444, 555, 666, 777, 888, 999};
        double s = 0;
        int rand = arc4random() % 1000;
        for(int i = 0; i < 10; i++){
            if(s <= rand && rand < s + temp[i]) return resp[i];
            else s += temp[i];
        }
        return arc4random() % 1000;
    }
    if(mode == gameSingleMode && level == 2){
        double temp[10] = { 30,  20,  13,  9,  6,  5,  3,   2,   1,   2};
        double resp[10] = {000, 111, 222, 333, 444, 555, 666, 777, 888, 999};
        double s = 0;
        int rand = arc4random() % 1000;
        for(int i = 0; i < 10; i++){
            if(s <= rand && rand < s + temp[i]) return resp[i];
            else s += temp[i];
        }
        return arc4random() % 1000;
    }    
    if(mode == gamePartyMode && level == 1){
        double temp[10] = { 40,  40,  40,  40,  40,  40,  40,  40,  40,   2};
        double resp[10] = {000, 111, 222, 333, 444, 555, 666, 777, 888, 999};
        double s = 0;
        int rand = arc4random() % 1000;
        for(int i = 0; i < 10; i++){
            if(s <= rand && rand < s + temp[i]) return resp[i];
            else s += temp[i];
        }
        return arc4random() % 1000;
    }     
    return -1;
}

+(int)GetDigitNum:(int)n Th:(int)k{
    for(int i = 0; i < k; i++)
        n /= 10;
    return n % 10;
}

+(int)GetUnitKind:(int)itemUnit
{
    if(itemUnit == 000)  return 1;
    if(itemUnit == 111)  return 2;
    if(itemUnit == 222)  return 3;
    if(itemUnit == 333)  return 4;
    if(itemUnit == 444)  return 5;
    if(itemUnit == 555)  return 6;
    if(itemUnit == 666)  return 7;
    if(itemUnit == 777)  return 8;
    if(itemUnit == 888)  return 9;
    if(itemUnit == 999)  return 10;
    return 0;
}

+(NSMutableArray *)GetRateWithMode:(gameMode)mode ItemUnits:(NSMutableArray *)itemUnits
{
    NSMutableArray * rateUnits = [[NSMutableArray alloc] init];
    if(mode == gameSingleMode){
        int rate[] = {0, 2, 4, 7, 10, 20, 40, 60, 80, 100, -1};
        for(int i = 0; i < itemUnits.count; i++){
            int itemUnit = [[itemUnits objectAtIndex:i] intValue];
            [rateUnits addObject:[NSNumber numberWithInt:rate[[self GetUnitKind:itemUnit]]]];
        }
    }
    if(mode == gamePartyMode){
        int rate[] = {0, 3, 3, 3, 3, 3, 3, 3, 3, 3, -1};
        for(int i = 0; i < itemUnits.count; i++){
            int itemUnit = [[itemUnits objectAtIndex:i] intValue];
            [rateUnits addObject:[NSNumber numberWithInt:rate[[self GetUnitKind:itemUnit]]]];
        }
    }    
    return rateUnits;
}

+(int)GetTotRateWithMode:(gameMode)mode RateUnits:(NSMutableArray *)rateUnits
{
    int totRate = 0;
    for(int i = 0; i < rateUnits.count; i++){
        if([[rateUnits objectAtIndex:i] intValue] != -1)
            totRate += [[rateUnits objectAtIndex:i] intValue];
        printf("%d rate : %d\n", i, totRate);
    }
    return totRate;
}

+(int)GetMaxRateWithMode:(gameMode)mode RateUnits:(NSMutableArray *)rateUnits
{
    int maxRate = -1;
    for(int i = 0; i < rateUnits.count; i++)
        if([[rateUnits objectAtIndex:i] intValue] > maxRate)
            maxRate = [[rateUnits objectAtIndex:i] intValue];
    return maxRate;
}

+(int)GetMinRateWithMode:(gameMode)mode RateUnits:(NSMutableArray *)rateUnits
{
    int minRate = 99999;
    for(int i = 0; i < rateUnits.count; i++)
        if([[rateUnits objectAtIndex:i] intValue] < minRate)
            minRate = [[rateUnits objectAtIndex:i] intValue];
    return minRate;
}



+(int)GetExpWithMode:(gameMode)mode ItemUnits:(NSMutableArray *)itemUnits
{
    int totExp = 0;
    if(mode == gameSingleMode){
        int exp[] = {0, 2, 4, 8, 10, 14, 16, 18, 20, 30, 0};
        for(int i = 0; i < itemUnits.count; i++){
            int itemUnit = [[itemUnits objectAtIndex:i] intValue];
            totExp += exp[[self GetUnitKind:itemUnit]];
        }
        
    }
    if(mode == gamePartyMode){
//        int exp[] = {0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0};
//        for(int i = 0; i < itemUnits.count; i++){
//            int itemUnit = [[itemUnits objectAtIndex:i] intValue];
//            totExp += exp[[self GetUnitKind:itemUnit]];
//        }
        
    }
    
    return totExp;
}

-(void)dealloc
{
    [super dealloc];
}

@end
