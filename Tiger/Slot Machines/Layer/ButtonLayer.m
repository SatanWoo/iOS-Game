//
//  ButtonLayer.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonLayer.h"
#import "SceneManager.h"
#import "GameConfig.h"
#import "SettingLayer.h"
#import "BuyLayer.h"
#import "MusicCenter.h"
#import "AppDelegate.h"

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


@implementation ButtonLayer

-(id)init
{
    self = [super init];
    if(self){
        [self Load];
        [self InitPopLayer];
    }
    return self;
}

-(void)InitPopLayer
{
    isPop = false;
    control = [CCSprite node];
    CCSprite * menuBack = [CCSprite spriteWithFile:OC("tc_si_button_cehuatiao.png")];
    menuBack.position = ccp(66, 125.5);
    [control addChild:menuBack];
    
    CCMenuItemSprite * pauseItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_pause_back.png")] selectedSprite:nil target: self selector: @selector(BackMenuLayer)];
    CCMenuItemSprite * backItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_setup_70 69.png")] selectedSprite:nil target: self selector:@selector(PopSettingLayer)];
    CCMenu * popMenu = [CCMenu menuWithItems:pauseItem, backItem, nil];
    [popMenu alignItemsHorizontallyWithPadding:-7.00f];
    popMenu.position = ccp(69, 125.5);
    [control addChild:popMenu];
    control.visible = false;
    [self addChild:control];
}

-(void)Load
{
    CCMenuItemSprite * moneyItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_jinbi_69 70.png")] 
                                                           selectedSprite:nil target:self 
                                                                 selector:@selector(OpenBuyLayer)];
    
    CCMenuItemSprite * cameraItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_zhaoxiang_70 69.png")]                                      
                                                            selectedSprite:nil target:self 
                                                                  selector:@selector(snapShot)];
    
    CCMenuItemSprite * settingItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_pause.png")] 
                                                             selectedSprite:nil target:self 
                                                                   selector:@selector(PopMenu)];
    
    CCMenu * leftNav = [CCMenu menuWithItems:moneyItem, cameraItem, settingItem,nil];
    
    [leftNav alignItemsVerticallyWithPadding:20];
    leftNav.position = ccp(20, 180);
    [self addChild:leftNav z:1];    
    
}

-(void)OpenBuyLayer
{
    [MusicCenter playSoundEffect:leftButton];    
    BuyLayer * _buyLayer = [BuyLayer node];
    [self addChild:_buyLayer z:2];
}

-(void)PopSettingLayer
{
    [MusicCenter playSoundEffect:leftButton];
    SettingLayer *setupLayer = [SettingLayer node];
    [self addChild:setupLayer z:2];
}

-(void)PopMenu
{
    [MusicCenter playSoundEffect:leftButton];
    if(!isPop)
        control.visible = true;
    else
        control.visible = false;
    isPop ^= 1;
}

-(void)BackMenuLayer
{
    [MusicCenter playSoundEffect:leftButton];
    [SceneManager GoSelectMode];
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

-(UIImage *)captureView:(UIView *)view {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void)snapShot
{
    [MusicCenter playSoundEffect:camera];
    [self flash];
    _snapShot = [[CCDirector sharedDirector] screenShotUIImage];
    
    UIImageWriteToSavedPhotosAlbum(_snapShot,nil,nil,nil); 
    
    if (_weiboViewController == nil) {
        //[WeiboViewController setDisableOtherLayer:true];
        disableOtherLayerTouch = true;
        
        RootViewController* rootVC = (RootViewController *)([UIApplication sharedApplication].keyWindow.rootViewController);
        
        _weiboViewController = [[WeiboViewController alloc]init];
        _weiboViewController.delegate = self;
        _weiboViewController.view.frame = rootVC.view.bounds;
        
        [_weiboViewController.imageView setImage:_snapShot];
//        [_weiboViewController.imageView setContentMode: UIViewContentModeCenter];
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
