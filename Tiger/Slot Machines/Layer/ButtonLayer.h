//
//  ButtonLayer.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "RootViewController.h"
#import "WeiboViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ButtonLayer : CCLayer<WeiboViewControllerDelegate> {
    CCSprite * control;
    bool isPop;
    
    WeiboViewController *_weiboViewController;
    UIImage *_snapShot;
}

-(void)Load;
-(void)InitPopLayer;
-(void)snapShot;
-(void)flash;

@end