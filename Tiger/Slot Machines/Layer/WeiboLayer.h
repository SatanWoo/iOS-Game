//
//  WeiboLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RootViewController.h"
#import "WeiboViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WeiboLayer : CCLayer<WeiboViewControllerDelegate> {
    WeiboViewController *_weiboViewController;
    UIImage *_snapShot;
}

@end
