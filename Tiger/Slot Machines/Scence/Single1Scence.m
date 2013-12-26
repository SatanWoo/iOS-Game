//
//  Single1Scence.m
//  Slot Machines
//
//  Created by Dingsheng Yu on 1/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Single1Scence.h"
#import "CalcHelp.h"
#import "MusicCenter.h"
#import "CCVideoPlayer.h"
#import "SysConf.h"

@implementation Single1Scence

#define BACKGROUND_LAYER 0
#define TIGER_LAYER 5
#define MACHINE_LAYER 10  
#define JOY_LAYER 15
#define POUR_LAYER 15
#define BUTTON_LAYER 20
#define CHAR_LAYER 20
#define SCORE_LAYER 20
#define COIN_LAYER 25
#define HELP_LAYER 25
#define LEVEL_LAYER 30
#define PLATE_LAYER 35
#define RATE_LAYER 40

-(id)init{
    self = [super init];
    if(self){
        isAuto = false;
        isHelp = [SysConf IsHelp];
        [MusicCenter playModeBackgroundMusic:singleModeFirst];
        [self LoadImage];
        [self LoadMenu];
        [self LoadAnimation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kAddSubView object:nil];
    }
    return self;
}

#pragma mark -
#pragma mark LOAD

-(void)LoadImage{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite * backgroundImage = [CCSprite spriteWithFile:OC("tc_gi_single_pr_tiankong2.png")];
    backgroundImage.position = ccp(size.width / 2 , size.height / 2);
    [self addChild:backgroundImage z:BACKGROUND_LAYER];
        
    CCMenuItemSprite * insertCoin = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_coininsert.png")] 
                                              selectedSprite:nil 
                                                      target:self 
                                                    selector:@selector(InsertCoin)];
    CCMenu *insertMenu = [CCMenu menuWithItems:insertCoin, nil];
    insertMenu.position = ccp(414,75);
    [self addChild:insertMenu z:BUTTON_LAYER];
}

-(void)LoadMenu{
    CCMenuItemToggle * autoItem = [CCMenuItemToggle itemWithTarget:self selector:@selector(SwitchAuto)
                                             items:
                   [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_autooff_151 68.png")] 
                                           selectedSprite:nil],
                   [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_autoon_151 53.png")] 
                                           selectedSprite:nil],
                   nil];
    autoItemCopy = autoItem;
    
    CCMenuItem * lineItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_lineoff_151 68.png")] 
                                                    selectedSprite:[CCSprite spriteWithFile:OC                                    ("tc_gi_single_pr_button_lineon_151 53.png")] target:self selector:@selector(ChangeLine)];
    CCMenuItem * rateItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_rateoff_151 68.png")]
                                                    selectedSprite:[CCSprite spriteWithFile:OC("tc_gi_single_pr_button_rateon_151 53.png")]
                                                            target:self selector:@selector(CreateRate)];
    CCMenu* bottomBay = [CCMenu menuWithItems:lineItem, autoItem, rateItem, nil];
    [bottomBay alignItemsHorizontallyWithPadding:24];
    bottomBay.position = ccp(245, 68);
    [self addChild:bottomBay z:BUTTON_LAYER];                                
}

-(void)LoadAnimation{
    _pourLayer = [PourLayer node];
    [self addChild:_pourLayer z:POUR_LAYER];
        
    _itemLayer = [ItemLayer node];
    [_itemLayer InitItemsWithMode:gameSingleMode Level:1]; 
    [self addChild:_itemLayer z:MACHINE_LAYER];
        
    _joySticker = [JoySticker node];
    [self addChild:_joySticker z:JOY_LAYER];
    
    _tigerLayer = [TigerLayer node];
    [self addChild:_tigerLayer z:TIGER_LAYER];
    [_tigerLayer ShowTiger:6];
    
    _scoreLayer = [ScoreLayer node];
    [_scoreLayer SetDrawer:OC("tc_gi_single_pr_chouti.png")];
    [self addChild:_scoreLayer z:SCORE_LAYER];
    
    _character = [Character node];
    [self addChild:_character z:CHAR_LAYER];

    _coinLayer = [CoinLayer node];
    [self addChild:_coinLayer z:COIN_LAYER];

    _buttonLayer = [ButtonLayer node];
    [self addChild:_buttonLayer z:BUTTON_LAYER];

    if(isHelp){
        _helpLayer = [HelpLayer node];
        [_helpLayer HelpFirst];
        [self addChild:_helpLayer z: HELP_LAYER];
    }
}

-(void)FruitBeginScroll
{
    if(isHelp && [_helpLayer GetStep] != 2) return;
    if(isHelp && [_helpLayer GetStep] == 2) [_helpLayer NextStep];    
    if(isHelp) [_itemLayer SetTheFirst];
    if(![_itemLayer IsFinish]) return;
//    don't have the debt
    if([_scoreLayer GetDebt] == 0){
        [MusicCenter playSoundEffect:error];
        return;
    }
//    engineer full
    if([_scoreLayer GetEng] == 100){
        [_itemLayer SetTheSame];
        [_scoreLayer EngReset];
    }

    [_tigerLayer ShowTiger:6];
    [_character SetCharacter:false];
    
    [_scoreLayer MinusDebt:[_pourLayer GetPourNum]];
    [_itemLayer ActionBegin];
}

-(void)FruitStopScroll
{
    [_itemLayer ActionStop];    
}

-(void)FruitStopScrollLine:(int)th
{
    [_itemLayer ActionStopLine:th];
}

-(void)ScrollFinish
{
    if(isHelp && [_helpLayer GetStep] != 3) return;
    if(isHelp && [_helpLayer GetStep] == 3) [_helpLayer NextStep];    

//    Get pourUnits that show the lines selected
    NSMutableArray * pourUnits = [_pourLayer GetPourUnits];
//    Get itemUnits that show the items selected
    NSMutableArray * itemUnits = [_itemLayer GetItemUnits:pourUnits];
    
//    Set the itemUnits blinks
    [_itemLayer SetBlinkUnits:pourUnits];
    
//    Get the rate
    NSMutableArray * rateUnits = [CalcHelp GetRateWithMode:gameSingleMode ItemUnits:itemUnits];
    int totRate = [CalcHelp GetTotRateWithMode:gameSingleMode RateUnits:rateUnits];
    printf("TotRate %d\n",totRate);
    int maxRate = [CalcHelp GetMaxRateWithMode:gameSingleMode RateUnits:rateUnits];
    int minRate = [CalcHelp GetMinRateWithMode:gameSingleMode RateUnits:rateUnits];

//    Get the exp
    int exp = [CalcHelp GetExpWithMode:gameSingleMode ItemUnits:itemUnits];
    printf("Exp %d\n", exp);

//    refresh Data
    [_scoreLayer AddScoreWithRate:totRate];
    bool isLeveUp = [_scoreLayer AddExp:exp];
  
    int eng = maxRate > 0 ? 1 : 3;
    [_scoreLayer AddEng:eng];


//    set the plate
    if(!isLeveUp && minRate == -1){
        if(isAuto) [self SwitchAuto];
        _plate = [Plate node];
        [self addChild:_plate z:PLATE_LAYER];
    }
//    set the level up
    if(isLeveUp && [_scoreLayer GetLevel] < 999){
        [_scoreLayer LevelUp];
        _upLevelLayer = [UpLevelLayer node];
        [self addChild:_upLevelLayer z:LEVEL_LAYER];
        
        if(isAuto) [self SwitchAuto];
        _plate = [Plate node];
        [self addChild:_plate z:PLATE_LAYER];
    }
    
//    set Animation
    [_character SetCharacter:maxRate];
    [_coinLayer ShowCoinWithRate:maxRate];
    [_tigerLayer ShowTigerWithRate:maxRate];
}

-(void)PlateFinish:(int)score;
{
    if(score == 0) [_itemLayer SetTheSame];
    [_scoreLayer AddScoreWithScore:score];
    [_coinLayer ShowCoinWithScore:score];
}

-(void)SwitchAuto
{
    if(isHelp) return;
    if(![_itemLayer IsFinish] || isHelp){
        [autoItemCopy setSelectedIndex: 1 - [autoItemCopy selectedIndex]];
        return;
    }
    [MusicCenter playSoundEffect:bottomButton];
    if(!isAuto && [_scoreLayer GetDebt] > 0){
        isAuto = true;
        [self FruitBeginScroll];
        [autoItemCopy setSelectedIndex:1];
        [self schedule:@selector(FruitBeginScroll) interval:10.0];
    }else{
        isAuto = false;
        [autoItemCopy setSelectedIndex:0];
        [self unschedule:@selector(FruitBeginScroll)];
    }
}


-(void)CreateRate
{
    [MusicCenter playSoundEffect:bottomButton];
    _rateLayer = [RateLayer node];
    [_rateLayer setBackground:OC("rateFruit")];
    [self addChild:_rateLayer z:RATE_LAYER];
}

-(void)ChangeLine
{ 
    if(isAuto) return;
    if(isHelp) return;
    if(![_itemLayer IsFinish]) return;
    [MusicCenter playSoundEffect:bottomButton];
    [_scoreLayer SetDebtZero];
    [_pourLayer PourNext:gameSingleMode Level:1];
}

-(void)InsertCoin
{
    if(![_itemLayer IsFinish]) return;
    if(isHelp && [_helpLayer GetStep] == 1) [_helpLayer NextStep];
    [_scoreLayer AddDebtWithLimit:5 WithPourNum:[_pourLayer GetPourNum]];
}

-(void)SetHelpless
{
    isHelp = false;
    [SysConf SetHelp:false];
}

-(void)dealloc
{
    [super dealloc];
}

@end
