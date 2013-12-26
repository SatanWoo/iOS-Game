//
//  saveData.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-11.
//  Copyright 2011 同济大学. All rights reserved.
//
#define levelKey @"levelKey"
#define scoreKey @"scoreKey"
#define miniKey @"miniKey"
#define powerKey @"powerKey"
#define sizeKey @"sizeKey"
#define shelterKey @"shelterKey"
#define costKey @"costKey"
#import <Foundation/Foundation.h>


@interface saveData : NSObject {

}

+(void)setLevel:(int)Level;
+(int)getLevel;

+(void)setMini:(int)status Level:(int)Level;
+(int)getMini:(int)Level;

+(void)setPower:(int)power;
+(int)getPower;

+(void)setSize:(float)size;
+(float)getSize;

+(void)setShelter:(int)shelter;
+(int)getShelter;

+(NSArray*)getArray;

+(void)setCost:(int)cost sort:(int)sort;
+(int)getCost:(int)sort;

+(NSArray*)getArrayOfCost;


+(void)setScore:(int)score;
+(int)getScore;

@end
