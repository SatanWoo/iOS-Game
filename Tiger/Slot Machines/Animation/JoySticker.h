//
//  JoySticker.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfig.h"

@interface JoySticker : CCSprite  <CCTargetedTouchDelegate>{
    CCSprite * _image;
    CCSpriteBatchNode *_spriteSheet;
    CCLayer * _delagateLayer;
    CGPoint touchBegin, touchMove, touchEnd;
    int nowPage;
    bool isOn;
}

-(void)InitJoySticker;

@end
