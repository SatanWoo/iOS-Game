//
//  JoyStick.h
//  cocos2d-Joystick
//
//  Created by ezshine on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol CCJoyStickDelegate <NSObject>
@optional
- (void) onCCJoyStickUpdate:(CCNode*)sender Angle:(float)angle Direction:(CGPoint)direction Power:(float)power;
- (void) onCCJoyStickActivated:(CCNode*)sender;
- (void) onCCJoyStickDeactivated:(CCNode*)sender;
@end

@interface CCJoyStick : CCSprite<CCTargetedTouchDelegate> {
	CCSprite		*Ball;
	CCSprite		*Stick;
	CCSprite		*Dock;
	
	Boolean			isFollowTouch;
	Boolean			isCanVisible;
	Boolean			isAutoHide;
	Boolean			hasAnimation;
	
	int				MoveAreaRadius;
	int				BallRadius;
	
	CGRect			ActiveRect;
	int				ActiveRadius;
	CGPoint			currentPoint;
	
	Boolean			isTouched;
	float				power;
	CGPoint			direction;
	float			angle;
	
	id<CCJoyStickDelegate> delegate;
}

@property(readonly,retain)CCSprite			*Ball;
@property(readonly,retain)CCSprite			*Stick;
@property(readonly,retain)CCSprite			*Dock;
@property(nonatomic,readonly)int			MoveAreaRadius;
@property(nonatomic,readonly)int			BallRadius;
@property(nonatomic,readonly)CGRect			ActiveRect;
@property(nonatomic,readonly)int			ActiveRadius;
@property(nonatomic,readonly)CGPoint		currentPoint;
@property(nonatomic,readonly)Boolean		isTouched;
@property(nonatomic,readonly)Boolean		hasAnimation;
@property(nonatomic,readonly)float			power;
@property(nonatomic,readonly)float			angle;
@property(nonatomic,readonly)CGPoint		direction;
@property (nonatomic, assign) id<CCJoyStickDelegate> delegate;


+(id)initWithBallRadius:(int)ballradius MoveAreaRadius:(int)movearearadius isFollowTouch:(Boolean)isfollowtouch isCanVisible:(Boolean)iscanvisible isAutoHide:(Boolean)isautohide hasAnimation:(Boolean)hasanimation;
-(id)initWithBallRadius:(int)ballradius MoveAreaRadius:(int)movearearadius isFollowTouch:(Boolean)isfollowtouch isCanVisible:(Boolean)iscanvisible isAutoHide:(Boolean)isautohide hasAnimation:(Boolean)hasanimation;

-(void)setBallTexture:(NSString *)imageName;
-(void)setStickTexture:(NSString *)imageName;
-(void)setDockTexture:(NSString *)imageName;

-(void)setHitAreaWithRadius:(int)radius;
-(void)setHitAreaWithRect:(CGRect)rect;

-(void)startTimer;
-(void)stopTimer;
-(void)timerUpdate;

-(void)onTouchBegan:(CGPoint)touchPoint;
-(void)resetTexturePosition;

- (BOOL)containsTouchLocation:(UITouch *)touch ;
-(void)updateTouchPoint:(CGPoint)touchPoint;

@end
