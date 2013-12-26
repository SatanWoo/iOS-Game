//
//  AppDelegate.h
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-10.
//  Copyright 同济大学 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
@class InputViewController;
@class LotteryViewController;

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;
    
	CCDirectorIOS	*director_;		// weak ref
    InputViewController *_inputVC;
    LotteryViewController *_lotVC;
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
