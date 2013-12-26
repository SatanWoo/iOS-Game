//
//  JoyStick.m
//  cocos2d-Joystick
//
//  Created by ezshine on 11-1-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CCJoyStick.h"
#import "cocos2d.h"

@implementation CCJoyStick

@synthesize Ball;
@synthesize Stick;
@synthesize Dock;
@synthesize BallRadius;
@synthesize MoveAreaRadius;
@synthesize ActiveRect;
@synthesize ActiveRadius;
@synthesize	currentPoint;
@synthesize	isTouched;
@synthesize power;
@synthesize angle;
@synthesize delegate;
@synthesize	direction;
@synthesize	hasAnimation;

-(id)initWithBallRadius:(int)ballradius MoveAreaRadius:(int)movearearadius isFollowTouch:(Boolean)isfollowtouch isCanVisible:(Boolean)iscanvisible isAutoHide:(Boolean)isautohide hasAnimation:(Boolean)hasanimation
{
	if( (self=[super init] )) {
		BallRadius=ballradius;
		MoveAreaRadius=movearearadius;
		isFollowTouch=isfollowtouch;
		isCanVisible=iscanvisible;
		isAutoHide=isautohide;
		hasAnimation=hasanimation;
		
		power=0;
		angle=0;
		
		CGSize size = [[CCDirector sharedDirector] winSize];
		[self setHitAreaWithRect:CGRectMake(0, 0, size.width/2, size.height)];
		
		Ball=[[CCSprite alloc] init];
		Stick=[[CCSprite alloc] init];
		Dock=[[CCSprite alloc] init];
		
		[self addChild:Dock];
		[self addChild:Stick];
		[self addChild:Ball];
		
		if(!isCanVisible){
			[self setVisible:NO];
		}else {
			if (isAutoHide) {
				[self setVisible:NO];
			}
		}
	}
	return self;
}

- (void) onEnter  
{  
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];  
    [super onEnter];  
}  
- (void) onExit  
{  
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];  
    [super onExit];  
}  

+(id)initWithBallRadius:(int)ballradius MoveAreaRadius:(int)movearearadius isFollowTouch:(Boolean)isfollowtouch isCanVisible:(Boolean)iscanvisible isAutoHide:(Boolean)isautohide hasAnimation:(Boolean)hasanimation
{
	return [[self alloc] initWithBallRadius:ballradius MoveAreaRadius:movearearadius isFollowTouch:isfollowtouch isCanVisible:iscanvisible isAutoHide:isautohide hasAnimation:hasanimation];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event  
{  
    if ( ![self containsTouchLocation:touch] )
    {  
        return NO;
    }  
	
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	[self onTouchBegan:touchPoint];
	return YES;
}
-(void)onTouchBegan:(CGPoint)touchPoint
{
	currentPoint = touchPoint;
	isTouched=YES;
	
	if(isAutoHide && isCanVisible){
		[self setVisible:YES];
	}
	
	if(isFollowTouch){
		self.position=ccp(touchPoint.x,touchPoint.y);
	}
	
	[Ball stopAllActions];
	[self updateTouchPoint:touchPoint];
	
	[self startTimer];
}

-(void)updateTouchPoint:(CGPoint)touchPoint
{
	CGPoint selfposition=[self.parent convertToWorldSpace:self.position];
	if (ccpDistance(touchPoint, ccp(selfposition.x,selfposition.y)) > (MoveAreaRadius-BallRadius))
	{
		currentPoint =ccpAdd(ccp(0,0),ccpMult(ccpNormalize(ccpSub(ccp(touchPoint.x-selfposition.x,touchPoint.y-selfposition.y), ccp(0,0))), MoveAreaRadius-BallRadius));
	}else {
		currentPoint = ccp(touchPoint.x-selfposition.x,touchPoint.y-selfposition.y);
	}
	Ball.position=currentPoint;
	
	angle=atan2(Ball.position.y-0, Ball.position.x-0)/(3.14159/180);
	power=ccpDistance(Ball.position, ccp(0,0))/(MoveAreaRadius-BallRadius);
	direction=ccp(cos(angle * (3.14159/180)),sin(angle * (3.14159/180)));
	
	
	CCSprite *sticktexture=(CCSprite*)[Stick getChildByTag:0];
	Stick.scaleX=ccpDistance(Ball.position, ccp(0,0))/sticktexture.textureRect.size.width;
	Stick.rotation=-angle;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event  
{  
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	
	if (isTouched) {
		[self updateTouchPoint:touchPoint];
	}
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event  
{
	if (isTouched) {
		if(isAutoHide && isCanVisible){
			[self setVisible:NO];
		}
		isTouched=NO;
		[self stopTimer];
		[self resetTexturePosition];
	}
}

- (BOOL)containsTouchLocation:(UITouch *)touch  
{  
	CGPoint touchPoint = [touch locationInView:[touch view]];
	touchPoint = [[CCDirector sharedDirector] convertToGL:touchPoint];
	if (ActiveRadius>0)
	{
		if (ccpDistance(touchPoint, [self.parent convertToWorldSpace:ccp(self.position.x,self.position.y)]) < ActiveRadius) {
			return YES;
		}
	}
	if(ActiveRect.size.width>0 && ActiveRect.size.height>0){
		if (touchPoint.x>ActiveRect.origin.x && touchPoint.x<ActiveRect.origin.x+ActiveRect.size.width && touchPoint.y>ActiveRect.origin.y && touchPoint.y<ActiveRect.origin.y+ActiveRect.size.height) {
			return YES;
		}
	}
	return NO;
} 


-(void)resetTexturePosition
{
	power=0;
	angle=0;
	
	currentPoint=ccp(0,0);
	Stick.position=ccp(0,0);
	Stick.scaleX=power;
	
	if (!isAutoHide && isCanVisible && hasAnimation) {
		id action = [CCMoveTo actionWithDuration:.5 position:ccp(0,0)];
		
		[Ball runAction:[CCEaseElasticOut actionWithAction:action]];
	}else {
		Ball.position=ccp(0,0);
	}
}

-(void)startTimer
{
	if ((self.delegate != NULL) && [self.delegate respondsToSelector:@selector(onCCJoyStickActivated:)]) {
		[delegate onCCJoyStickActivated:self];
	}
	[self schedule:@selector(timerUpdate)];
}
-(void)stopTimer
{
	if ((self.delegate != NULL) && [self.delegate respondsToSelector:@selector(onCCJoyStickDeactivated:)]) {
		[delegate onCCJoyStickDeactivated:self];
	}
	[self unschedule:@selector(timerUpdate)];
}
-(void)timerUpdate
{
	if ((self.delegate != NULL) && [self.delegate respondsToSelector:@selector(onCCJoyStickUpdate:Angle:Direction:Power:)]) {
		[delegate onCCJoyStickUpdate:self Angle:angle Direction:direction Power:power];
	}
}

-(void)setBallTexture:(NSString *)imageName
{
	[Ball removeAllChildrenWithCleanup:TRUE];
	
	CCSprite *balltexture=[CCSprite spriteWithFile:imageName];
	
	[Ball addChild:balltexture];
}
-(void)setStickTexture:(NSString *)imageName
{
	[Stick removeAllChildrenWithCleanup:TRUE];
	
	CCSprite *sticktexture=[CCSprite spriteWithFile:imageName];
	sticktexture.position=ccp(sticktexture.contentSize.width/2,0);
	
	[Stick addChild:sticktexture z:0 tag:0];
	
	Stick.scaleX=ccpDistance(Ball.position, ccp(0,0))/sticktexture.textureRect.size.width;
}
-(void)setDockTexture:(NSString *)imageName
{
	[Dock removeAllChildrenWithCleanup:TRUE];
	
	CCSprite *docktexture=[CCSprite spriteWithFile:imageName];
	
	[Dock addChild:docktexture];
}
-(void)setHitAreaWithRadius:(int)radius
{
	ActiveRect=CGRectMake(0, 0, 0, 0);
	ActiveRadius=radius;
}
-(void)setHitAreaWithRect:(CGRect)rect
{
	ActiveRect=rect;
	ActiveRadius=0;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[super dealloc];
	[Ball release];
	[Stick release];
	[Dock release];
	delegate = nil;
	[delegate	release];
}

@end
