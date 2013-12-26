//
//  InfoLayer.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-6.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "InfoLayer.h"
#import "GameConfig.h"


@implementation InfoLayer

-(id)init
{
    self =[super init];
    if (self ) {
        CCSprite* infoBackground=[CCSprite spriteWithFile:@"infoLayer.png" rect:CGRectMake(0, 0,50, 226)];
        infoBackground.position=ccp(ipadWidth/2+390,225);
        [self addChild:infoBackground z:0 tag:1];
    }
    return self;
}

-(void)dealloc
{
    [self removeChildByTag:1 cleanup:YES];
    [super dealloc];
}

@end
