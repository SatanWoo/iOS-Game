//
//  SelectLevel.h
//  tapat
//
//  Created by Yu Dingsheng on 11-1-26.
//  Copyright 2011 Tongji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SelectLevel : CCNode {
	int finish;

}

+(id)scene;
+(void)generateGame;

@end
