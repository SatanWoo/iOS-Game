//
//  MiniGameFishing.h
//  MiniGame
//
//  Created by Ye Gabriel on 11-3-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum
{
	LayerTagGameLayer,
	LayerTagUILayer,
} MultiLayerSceneTags;

@class MGFishingGameLayer;
@class MGFishingUILayer;

@interface MiniGameFishing : CCLayer {
	bool isTouchForUserInterface;
}

+(MiniGameFishing *) sharedLayer;

@property (readonly) MGFishingGameLayer* gameLayer;
@property (readonly) MGFishingUILayer* uiLayer;

+(CGPoint) locationFromTouch:(UITouch*)touch;
+(CGPoint) locationFromTouches:(NSSet *)touches;

+(id) scene;

@end
