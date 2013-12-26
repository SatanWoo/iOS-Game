//
//  InputViewController.h
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-12.
//  Copyright (c) 2012年 同济大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputViewController : UIViewController
{
    NSManagedObjectContext *_context;    
    IBOutlet UILabel *_textField;
}
@property (nonatomic, retain) NSManagedObjectContext *context;

- (IBAction)confirm:(id)sender;
- (IBAction)reinput:(id)sender;
- (IBAction)buttonPressed:(UIButton *)sender;

@end
