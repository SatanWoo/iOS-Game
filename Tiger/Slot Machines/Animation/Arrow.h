//
//  Arrow.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Arrow : CCSprite {
    CCSprite * _image;
    CCSpriteBatchNode *_spriteSheet;
}

-(void)ActionBegin;
-(void)ActionStop;

@end