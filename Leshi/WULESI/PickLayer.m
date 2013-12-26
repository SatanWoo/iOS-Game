//
//  PickLayer.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-11.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "PickLayer.h"
#import "Macro.h"
#import "Chips.h"
#import "Score.h"
#import "TimeLineLayer.h"
#import "MusicHandle.h"

#define deceleration 0.4
#define sensitivity 10
#define maxVelocity 100
#define screenLeftMin _trolleySprite.boundingBox.size.width / 2
#define maxDis _trolleySprite.boundingBox.size.width * 0.4 + chip.boundingBox.size.width * 0.6
#define maxType 18
#define maxTogether 6

@implementation PickLayer

#pragma mark - Private Method
- (void)resetChipPosition:(Chips *)sender
{
    _currentItemCount--;
    sender.opacity = 255;
    CGPoint pos = sender.position;
    int randomX = CCRANDOM_0_1() * 10;
    pos.x = randomX * 100 + sender.boundingBox.size.width / 2; 
    pos.y = IPADHEIGHT + sender.boundingBox.size.height / 2;
    sender.position = pos;
}

- (void)downTheChips:(Chips *)chip
{
    CGPoint desPoint = CGPointMake(chip.position.x, _timeLineBGP.position.y + chip.boundingBox.size.height / 2 + _timeLineBGP.boundingBox.size.height / 2);
    CCMoveTo *move = [CCMoveTo actionWithDuration:2.5f position:desPoint];
    CCFadeOut *fadeout = [CCFadeOut actionWithDuration:0.3f];
    CCCallFuncN *call = [CCCallFuncN actionWithTarget:self selector:@selector(resetChipPosition:)];
    CCSequence* seq = [CCSequence actions:move,fadeout,call,nil];
    [chip runAction:seq];
}

- (void)removeLabel:(Score *)sender
{
    [self removeChild:sender cleanup:YES];
}

- (void)showScoreLabel:(scoreValue)value pos:(CGPoint)point
{
    Score *label = [Score createScoreLabel:value];
    label.position = ccp(point.x, point.y + 100);
    [self addChild:label];
    CCBlink *blink = [CCBlink actionWithDuration:0.5f blinks:2];
    CCCallFuncN *call = [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel:)];
    [label runAction:[CCSequence actions:blink,call,nil]];
}

- (void)checkPick
{
    for (int i = 0; i < maxType; i++) {
        Chips *chip = [_chipsArray objectAtIndex:i];
        if (ccpDistance(chip.position, _trolleySprite.position) < maxDis) {
            if ([chip value] == -1) {
                globalGameScore += _score;
                _score *= 2;
                [MusicHandle notifyGetScore];
                
            }else {
                _score += [chip value];
                if ([chip value] >= 0) {
                    [MusicHandle notifyGetScore];
                } else {
                    [MusicHandle notifyLoseTime];
                }
                globalGameScore += [chip value];
            }
            
            [self showScoreLabel:[chip value] pos:chip.position];
            if ([chip time] < 0) {
                NSLog(@"lost time");
                [MusicHandle notifyLoseTime];
            }
            _timeLayer.countDown += [chip time];
            [chip stopAllActions];// Wu:Important
            [self resetChipPosition:chip];
            [_scoreTTF setString:[NSString stringWithFormat:@"%d",_score]];
        }
    }

}

#pragma mark - Public Method
-(id)init
{
    self = [super init];
    if (self) {
        _readyIndex = _currentItemCount = _score = 0;
        _velocity = CGPointZero;
        _chipsArray = [[CCArray alloc]init];
        _timeLineBGP = [CCSprite spriteWithFile:@"game_lottery_res.png" rect:CGRectMake(1,178, 706, 39)];
        _timeLineBGP.position = ccp(IPADWIDTH / 2, _timeLineBGP.boundingBox.size.height);
        _timeLayer = [TimeLineLayer node];
        [self addChild:_timeLayer z:2];
        
        _bgp = [CCSprite spriteWithFile:@"game_leshi.png"];
        _bgp.position = ccp(IPADWIDTH / 2, IPADHEIGHT / 2);
        [self addChild:_bgp z:0];
        [self addChild:_timeLineBGP z:0];
        
        _trolleySprite = [CCSprite spriteWithFile:@"手推车.png"];
        
        // Wu:Bounding box works as frame here because the texture is a large one;
        _trolleySprite.position = ccp(IPADWIDTH / 2,_timeLineBGP.position.y + _trolleySprite.boundingBox.size.height / 2 +  _timeLineBGP.boundingBox.size.height / 2);
        [self addChild:_trolleySprite z:2];
        
        _scoreTTF = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",_score] fontName:@"Marker Felt" fontSize:100];
        _scoreTTF.position = ccp(IPADWIDTH / 2,IPADHEIGHT - _scoreTTF.boundingBox.size.height + 30);
        [self addChild:_scoreTTF z:4];
        [_scoreTTF setColor:ccORANGE];
        
        [self initChips];
        
        _startArray = [[NSArray alloc] initWithObjects:@"3",@"2",@"1",@"开始",nil];
        
        [self showStartHint];
    }
    return self;
}

- (void)initChips
{
    for (int i = 0; i < maxType; i++) {
        Chips *newChip = [Chips createNewChips:(chipType)i];
        newChip.position = ccp(i * 50 + newChip.boundingBox.size.width / 2, IPADHEIGHT + newChip.boundingBox.size.height / 2);
        [self addChild:newChip z:1];
        [_chipsArray addObject:newChip];
    }
}

- (void)scheduleUpdate
{
    CGPoint pos = _trolleySprite.position;
    pos.x += _velocity.x;
    if (pos.x < screenLeftMin) {
        pos.x = screenLeftMin;
        _velocity = CGPointZero;
    }
    else if (pos.x > IPADWIDTH - screenLeftMin) {
        pos.x = IPADWIDTH - screenLeftMin;
        _velocity = CGPointZero;
    }
    _trolleySprite.position = pos;
    [self checkPick];
}

- (void)chipsUpdate
{
    int randomIndex = CCRANDOM_0_1() * [_chipsArray count];
    Chips *chip = [_chipsArray objectAtIndex:randomIndex];
    if ([chip numberOfRunningActions] == 0 && _currentItemCount < maxTogether) {
        _currentItemCount ++;
        [self downTheChips:chip];
    }
}

// Wu:Accelerometer do not change the height .
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    // Wu:Remember ,here is y to acclerate
    _velocity.x =  1.5 * _velocity.x * deceleration - acceleration.y * sensitivity;
    if (_velocity.x > maxVelocity) {
        _velocity.x = maxVelocity;
    }
    else if (_velocity.x < - maxVelocity){
        _velocity.x = - maxVelocity;
    }
}

- (void)dealloc
{
    [self unscheduleAllSelectors];
    //_timeLayer = nil;
    [_chipsArray release],_chipsArray = nil;
    _timeLineBGP = nil;
    _bgp = nil;
    _trolleySprite = nil;
    [super dealloc];
}

-(void) showStartHint{
	if (_readyIndex >= [_startArray count]) {
		[_startArray release];
		_startArray = nil;
		self.isAccelerometerEnabled = YES;// Wu:Important
        
        [self schedule:@selector(scheduleUpdate)];
        [self schedule:@selector(chipsUpdate) interval:0.3f];
        
        [_timeLayer startMove];
	}
	else {
		NSString *readyText = [_startArray objectAtIndex:_readyIndex];		
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:readyText fontName:@"Marker Felt" fontSize:60.0f];
		label.position=ccp(IPADWIDTH/2,IPADHEIGHT/2);
		label.opacity = 170;
        [label setColor:ccORANGE];
		CCAction *action = [CCSequence actions:
							[CCSpawn actions:
							 [CCScaleTo actionWithDuration:0.8f scaleX:1.8f scaleY:1.8f],
							 [CCSequence actions: 
							  [CCFadeTo actionWithDuration: 0.6f opacity:255],
							  [CCFadeTo actionWithDuration: 0.2f opacity:128],
							  nil],
							 nil],
							[CCCallFuncN actionWithTarget:self  selector:@selector(startHintCallback:)],
							nil
							];
		[self addChild:label z:5];
		[label runAction: action];		
		_readyIndex++;
        [MusicHandle notifyCountDown];
	}
}

-(void) startHintCallback: (id) sender{
	[self removeChild:sender cleanup:YES];
	[self showStartHint];
}

#pragma mark - TimeLineLayerDelegate

- (CGRect)getTimeLineRect
{
    return _timeLineBGP.boundingBox;
}

@end
