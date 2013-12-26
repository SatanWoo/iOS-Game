//
//  InsertCoin.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface InsertCoin : CCSprite {
    CCSprite * _image;
    CCSpriteBatchNode *_spriteSheet;
}

-(void)ActionBegin;
-(void)ActionStop;

@end