//
//  RateViewController.h
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-3-1.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RateViewDelegate
- (void)dismissRateViewController;
@end

@interface RateViewController : UIViewController
{
    IBOutlet UIView *_fruitView;
    IBOutlet UIView *_foodView;
    IBOutlet UIView *_partyView;
}

@property (nonatomic ,copy) NSString *rateName;
@property (nonatomic ,assign) id<RateViewDelegate> delegate;
- (IBAction)closeView:(id)sender;

@end
