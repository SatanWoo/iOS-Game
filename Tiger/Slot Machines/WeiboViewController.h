//
//  WeiboViewController.h
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-1-13.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameConfig.h"
#import "WBEngine.h"
#import "WBEngine.h"
#import "WBSendView.h"
#import "RootViewController.h"


//static bool disableOtherLayerTouch = false;

@protocol WeiboViewControllerDelegate

- (void)dismissWeiboViewController;

@end

@interface WeiboViewController : UIViewController<UIImagePickerControllerDelegate,WBEngineDelegate,WBSendViewDelegate>
{
    WBEngine *_engine;
    
    IBOutlet UIButton *_sendWeibo;
    //  IBOutlet UIButton *_chooseAPhoto;
    IBOutlet UIButton *_logOut;
    IBOutlet UIImageView *_imageView;
}

@property (nonatomic, assign) WBEngine *engine;
@property (nonatomic, assign) IBOutlet UIImageView *imageView;
//@property (nonatomic, retain)IBOutlet UIButton *chooseAPhoto;
@property (nonatomic, retain) id<WeiboViewControllerDelegate> delegate;

- (IBAction)postWeibo:(id)sender;
//- (IBAction)ChoosePhoto:(id)sender;
- (IBAction)logout:(id)sender;
@end
