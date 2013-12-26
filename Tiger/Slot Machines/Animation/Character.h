//
//  Character.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/16/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Character : CCSprite {
    CCSprite * _standby, * _win;
    CCSpriteBatchNode *_spriteSheet1, *_spriteSheet2;
}

-(void)InitCharacter;
-(void)InitAction;
-(void)SetCharacter:(int)rate;

@end
