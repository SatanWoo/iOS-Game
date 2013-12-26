//
//  ItemLayer.m
//  WULESI
//
//  Created by 吴 wuziqi on 12-5-24.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "ItemLayer.h"
#import "Player.h"
#import "PepsiChips.h"
#import "Macro.h"
#import "BlueTimeLineLayer.h"
#import "ShipScore.h"
#import "MusicHandle.h"

#define minType 17
#define maxType 38
#define maxDis 300
#define npcType 3
#define scrollSpeed 5.0f
#define outPlace -150

@implementation ItemLayer

- (void)removeLabel:(ShipScore *)sender
{
    [self removeChild:sender cleanup:YES];
}

- (void)showScoreLabel:(scoreValue)value pos:(CGPoint)point
{
    ShipScore *label = [ShipScore createScoreLabel:value];
    label.position = ccp(point.x, point.y + 100);
    [self addChild:label];
    CCBlink *blink = [CCBlink actionWithDuration:0.5f blinks:2];
    CCCallFuncN *call = [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel:)];
    [label runAction:[CCSequence actions:blink,call,nil]];
}

- (id)init
{
    self = [super init];
    if (self) {
        globalGameScore = 0;
        _count = 0;
        _score = 0;
        _lastMoveLine = -1;
        _array = [[CCArray alloc] init];
        _npcArray = [[CCArray alloc]init];
        _player = [Player getPlayer];
        _startArray = [[NSArray alloc] initWithObjects:@"3",@"2",@"1",@"开始",nil];
        _readyIndex = 0;
        _timeLayer = [BlueTimeLineLayer node];
        [self addChild:_timeLayer z:200];
        [self initChips];
        //[self initNpc];
        _scoreTTF = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",_score] fontName:@"Marker Felt" fontSize:100];
        _scoreTTF.position = ccp(IPADWIDTH / 2,IPADHEIGHT - _scoreTTF.boundingBox.size.height + 30);
        [self addChild:_scoreTTF z:4];
        [_scoreTTF setColor:ccORANGE];
        [self showStartHint];
        
    }
    return self;
}

- (void)resetChipPosition:(PepsiChips *)sender
{
    CGPoint pos = sender.position;
    pos.x = IPADWIDTH * 2;
    sender.position = pos;
    _count --;
}

- (void)moveForward:(PepsiChips *)sender
{
    CGPoint desPoint = CGPointMake(outPlace,sender.position.y);
    CCMoveTo *move = [CCMoveTo actionWithDuration:scrollSpeed position:desPoint];
    CCCallFuncN *call = [CCCallFuncN actionWithTarget:self selector:@selector(resetChipPosition:)];
    CCSequence* seq = [CCSequence actions:move,call,nil];
    [sender runAction:seq];
}

- (void)update
{
    int randomIndex = CCRANDOM_0_1() * [_array count];
    PepsiChips *chip = [_array objectAtIndex:randomIndex];
    if ([chip numberOfRunningActions] == 0 && _count < 80 && chip.line != _lastMoveLine) {
        _count ++;
        _lastMoveLine = chip.line;
        [self moveForward:chip];
    }
}

- (void)moveNPC
{
    for (int i = 0; i < npcType; i++) {
        NpcShip *ship = (NpcShip *)[_npcArray objectAtIndex:i];
        [ship runAction:[CCMoveTo actionWithDuration:(i + 1) * 7.0f position:ccp(outPlace,ship.position.y)]];
    }
}

- (void)showStartHint{
	if (_readyIndex >= [_startArray count]) {
		[_startArray release];
		_startArray = nil;
        
        [[NSNotificationCenter defaultCenter]postNotificationName:STARTMOVE object:nil];
		//self.isAccelerometerEnabled = YES;// Wu:Important
        [self initNpc];
        
        [self schedule:@selector(checkPick)];
        [self schedule:@selector(update) interval:0.1f];
        
        [[Player getPlayer] actionStart];
        
        [_timeLayer startMove];
        [self moveNPC];
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

- (void)checkPick
{
    for (int i = 0; i < [_array count]; i++) {
        PepsiChips *chip = [_array objectAtIndex:i];
        if (ccpDistance(chip.position, _player.position) < maxDis && _player.line == chip.line && _player.position.x < chip.position.x) {
            
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
            
            /*globalGameScore += [chip value];
            _score += [chip value];
            [MusicHandle notifyGetScore];*/
            [self showScoreLabel:[chip value] pos:chip.position];
            [chip stopAllActions];
            [self resetChipPosition:chip];
            [_scoreTTF setString:[NSString stringWithFormat:@"%d",_score]];
        }
    }
    
    for (int i = 0; i < [_npcArray count]; i++) {
        NpcShip *ship = [_npcArray objectAtIndex:i];
        if (ccpDistance(ship.position, _player.position) < maxDis && _player.line == ship.line && _player.position.x < ship.position.x) {
            _timeLayer.countDown -= 5;
            [MusicHandle notifyLoseTime];
            ship.position = ccp(0,0);
            [self removeChild:ship cleanup:YES];
        }
    }
}

- (void)initNpc
{
    for (int i = 0 ; i < npcType; i++) {
        NpcShip *ship = [NpcShip createNpcWithType:i];
        ship.line = i;
        [self addChild:ship];
        [ship actionStart];
        [_npcArray addObject:ship];
    }
}

- (void)initChips
{
    for (int i = minType; i < maxType; i++) {
        PepsiChips *ch = [PepsiChips createNewChips:(chipType)i];
        int randomLine = CCRANDOM_0_1() * 3;
        ch.line = randomLine;
        //ch.position = ccp(ch.position.x +, ch.position.y);
        [self addChild:ch];
        [_array addObject:ch];
    }
}

- (void)dealloc
{
    [self unscheduleAllSelectors];
    [_array removeAllObjects],[_array release],_array = nil;
    [_npcArray removeAllObjects],[_npcArray release],_npcArray = nil;
    [super dealloc];
}
@end
