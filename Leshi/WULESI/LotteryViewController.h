//
//  LotteryViewController.h
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-14.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CongratulationViewController;

@interface LotteryViewController : UIViewController
{
    NSManagedObjectContext *_context;    
    IBOutlet UILabel *_textLabel;
    NSTimer *_timer;
    CongratulationViewController *_vc;
}
@property (nonatomic, retain) NSManagedObjectContext *context;

- (IBAction)startLottery:(id)sender;
- (IBAction)stopLottery:(id)sender;
@end
