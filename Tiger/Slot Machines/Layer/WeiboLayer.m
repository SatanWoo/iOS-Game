//
//  WeiboLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 2/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "WeiboLayer.h"
#import "MusicCenter.h"

/** Degrees to Radian **/
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

/** Radians to Degrees **/
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )


@interface UIImage (CS_Extensions)
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
@end;

@implementation UIImage (CS_Extensions)

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{  
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    [rotatedViewBox release];
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

@implementation WeiboLayer



-(id)init
{
    self = [super init];
    if(self){
        
    }
    return self;
}

-(void)flash
{
    UIView *flashView = [[UIView alloc] init];
    flashView.frame = [[UIApplication sharedApplication].keyWindow bounds];
    [flashView autoresizingMask];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication].keyWindow addSubview:flashView];
    
    [UIView animateWithDuration:2.0f
                     animations:^{
                         [flashView setAlpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                         [flashView release];
                     }
     ];    
}

-(void)snapShot
{
    [MusicCenter playSoundEffect:camera];
    [self flash];
    extern CGImageRef UIGetScreenImage();//需要先extern 
//    _snapShot = [UIImage imageWithCGImage:UIGetScreenImage()]; 
//    
//    _snapShot = [_snapShot imageRotatedByDegrees:-90];
    
    UIImageWriteToSavedPhotosAlbum(_snapShot,nil,nil,nil); 
    
    if (_weiboViewController == nil) {
        //[WeiboViewController setDisableOtherLayer:true];
        disableOtherLayerTouch = true;
        
        RootViewController* rootVC = (RootViewController *)([UIApplication sharedApplication].keyWindow.rootViewController);
        
        _weiboViewController = [[WeiboViewController alloc]init];
        
        _weiboViewController.delegate = self;
        _weiboViewController.view.frame = rootVC.view.bounds;
        
        //  NSLog(@"snapShot again is %@",_snapShot);
        [_weiboViewController.imageView setImage:_snapShot];
        [rootVC.view addSubview:_weiboViewController.view];
    }
}

-(void)dealloc
{
    if (_weiboViewController != nil) {
        [_weiboViewController release];
    }
    if (_snapShot != nil) {
        [_snapShot release];
    }
    [super dealloc];
}

#pragma mark - weiboViewControllerDelegate

- (void)dismissWeiboViewController
{
    [_weiboViewController release];
    _weiboViewController = nil;
    disableOtherLayerTouch = false;
    // [WeiboViewController setDisableOtherLayer:false];
}

@end
