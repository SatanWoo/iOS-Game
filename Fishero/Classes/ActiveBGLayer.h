//
//  ActiveBGLayer.h
//  Fishero
//
//  Created by Ye Gabriel on 11-3-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define MovingFishesNum 10

typedef enum{
	left,
	right,
}FishDirection;


@interface ActiveBGLayer : CCLayer {
	CCArray * MovingFishes;
}

@end
