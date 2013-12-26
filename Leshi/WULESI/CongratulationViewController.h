//
//  CongratulationViewController.h
//  WULESI
//
//  Created by M.K.Rain on 12-6-2.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CongratulationViewController : UIViewController{
    NSManagedObjectContext *_context;  
    IBOutlet UILabel* _phoneNumber;
    IBOutlet UILabel* _date;
}
@property (nonatomic, retain) NSManagedObjectContext *context;

- (IBAction)backToMenu:(id)sender;

@end
