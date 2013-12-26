	//
	//  tapatAppDelegate.h
	//  tapat
	//
	//  Created by 吴 wuziqi on 10-10-28.
	//  Copyright 同济大学 2010. All rights reserved.
	//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "saveData.h"
#import "saveSetting.h"
#import "GameConfig.h"
@interface tapatAppDelegate : NSObject <UIApplicationDelegate,GameCenterManagerDelegate> {
	UIWindow			*window;
	RootViewController* viewController;
}




@property (nonatomic, retain) UIWindow *window;
- (void) orientationChanged:(NSNotification *)notification;



@end
