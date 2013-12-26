//
//  BannerViewController.h
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-2-29.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdMoGoView.h"

@interface BannerViewController : UIViewController<AdMoGoDelegate>
{
    AdMoGoView *adView;
}

@property (nonatomic ,retain) AdMoGoView *adView;

@end
