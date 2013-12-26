//
//  BlueTimeLineLayer.h
//  WULESI
//
//  Created by M.K.Rain on 12-5-31.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BlueTimeLineLayer : CCLayer{
    float _length;
    int _countDown;
    CCLabelTTF *_countDownTTF;
}

@property(nonatomic ,assign) float length;
@property(nonatomic ,assign) int countDown;
//@property(nonatomic ,assign) BOOL isStart;

- (void) startMove;

@end
