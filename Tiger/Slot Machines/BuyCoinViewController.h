//
//  BuyCoinViewController.h
//  Slot Machines
//
//  Created by 吴 wuziqi on 12-3-1.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BuyCoinDelegate <NSObject>

-(void)dismissBuyCoinViewController;

@end

@interface BuyCoinViewController : UIViewController
{
    
}

@property (nonatomic ,assign) id<BuyCoinDelegate>delegate;
- (IBAction)closeView:(id)sender;

@end
