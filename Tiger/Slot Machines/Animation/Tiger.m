//
//  Tiger.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "Tiger.h"

#define TigerPointX 458
#define TigerPointY 143 

@implementation Tiger

-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(void)InitTigerWithPng:(NSString *)name;
{
    [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:[name stringByAppendingString:OC(".plist")]]
    ;
    _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[name stringByAppendingString:OC(".png")]];
    _image = [CCSprite spriteWithFile:[name stringByAppendingString:OC(".png")]];
    [self addChild:_spriteSheet z:0];
    
    _image = [CCSprite spriteWithSpriteFrameName:[name stringByAppendingString:OC("_001.png")]];
    _image.position = ccp(TigerPointX,TigerPointY);
    [_spriteSheet addChild:_image];        

    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = 1; i <= 25; ++i) {
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [name stringByAppendingString: [NSString stringWithFormat:OC("_%03d.png"), i]]]];
    }
    CCAnimation *walkAnim = [CCAnimation
                             animationWithFrames:walkAnimFrames delay:0.05f];  
    _action = [CCRepeatForever actionWithAction:
                        [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [_image runAction:_action];
}

-(void)SetActionable:(bool)isActionable{
    if (isActionable) {
        [_image setVisible:true];
    }else{
        [_image setVisible:false];
    }
}

-(void)dealloc
{ 
    [self removeChild:_spriteSheet cleanup:YES];
    [super dealloc];
    printf("dealloc Tiger Success\n");
}
@end