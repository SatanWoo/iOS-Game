//
//  Score.h
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-16.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum 
{
    addFive = 5,
    addTen = 10,
    addTwenty = 20,
    minusFive = -5
}scoreValue;

@interface Score : CCSprite {
    
}

+ (id)createScoreLabel:(scoreValue)value;

@end
