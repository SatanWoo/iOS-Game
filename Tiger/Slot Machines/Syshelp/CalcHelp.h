//
//  CalcHelp.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassLayer.h"

@interface CalcHelp : NSObject{
    
}

+(int)RaCalcWithMode:(gameMode)mode Level:(int)level;
+(int)GetDigitNum:(int)n Th:(int)k;
+(int)GetUnitKind:(int)itemUnit;
+(NSMutableArray *)GetRateWithMode:(gameMode)mode ItemUnits:(NSMutableArray *)itemUnits;
+(int)GetExpWithMode:(gameMode)mode ItemUnits:(NSMutableArray *)itemUnits;
+(int)GetTotRateWithMode:(gameMode)mode RateUnits:(NSMutableArray *)rateUnits;
+(int)GetMaxRateWithMode:(gameMode)mode RateUnits:(NSMutableArray *)rateUnits;
+(int)GetMinRateWithMode:(gameMode)mode RateUnits:(NSMutableArray *)rateUnits;

@end
