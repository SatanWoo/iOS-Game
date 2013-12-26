//
//  ShipScore.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-6-2.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "ShipScore.h"


@implementation ShipScore

+(id)createScoreLabel:(scoreValue)value
{
    return [[[self alloc] initWithValue:value] autorelease];
}

- (id)initWithValue:(scoreValue)value
{
    self = [super init];
    if (self) {
        switch (value) {
            case addFive:
                self = [super initWithSpriteFrameName:@"加5分.png"];
                break;
                
            case addTen:
                self = [super initWithSpriteFrameName:@"加10分.png"];
                break;
                
            case addTwenty:
                self = [super initWithSpriteFrameName:@"加20分.png"];
                break;
                
            case minusFive:
                self = [super initWithSpriteFrameName:@"扣5分.png"];
                
            default:
                break;
        }
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
