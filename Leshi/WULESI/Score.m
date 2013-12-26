//
//  Score.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-16.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "Score.h"


@implementation Score

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
                self = [super initWithSpriteFrameName:@"+5.png"];
                break;
                
            case addTen:
                self = [super initWithSpriteFrameName:@"+10.png"];
                break;
                
            case addTwenty:
                self = [super initWithSpriteFrameName:@"+20.png"];
                break;
                
            case minusFive:
                self = [super initWithSpriteFrameName:@"-5.png"];
                
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
