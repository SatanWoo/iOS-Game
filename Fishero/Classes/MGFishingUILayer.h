//
//  MGFishingUILayer.h
//  MiniGame
//
//  Created by Ye Gabriel on 11-3-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum {
	backButtonTag,
	againButtonTag,
	backgroundTag,
	scorelabelTag,
}ButtonTag;

@interface MGFishingUILayer : CCLayer {
}
-(void)goMenu;
-(void)goPause;
@end
