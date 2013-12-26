//
//  RootViewController.h
//  Slot Machines
//
//  Created by Dingsheng Yu on 12/30/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "WBLogInAlertView.h"
#import "BannerViewController.h"

#define SinaWeiBoSDKAPPKey @"2265532253"
#define SinaWeiBoSDKAPPSecret @"a63215a5dc349727338d269c4dac53ac"

#define kAddSubView @"kAddSubView"
@interface RootViewController : UIViewController {
    BannerViewController *_bc;
}


@end
