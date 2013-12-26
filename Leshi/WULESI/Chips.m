//
//  Chips.m
//  Lesi
//
//  Created by 吴 wuziqi on 12-5-12.
//  Copyright 2012年 同济大学. All rights reserved.
//

#import "Chips.h"
#import "Macro.h"

@implementation Chips
#define STARTHEIGHT IPADHEIGHT * 2 / 3

@synthesize value = _value;
@synthesize time = _time;
@synthesize line = _line;
// Wu:Try to use this autorelease method
+ (id)createNewChips:(chipType)type
{
    return [[[self alloc] initWithType:type] autorelease];
}

- (id)init
{
    return [self initWithType:0];
}

- (id)initWithType:(chipType)type
{
    self = [super init];
    if (self) {
        _type = type;
        _time = 0;
        _line = -1;
        switch (_type) {
            case fiveGreenBOGUCUI:
                self = [super initWithSpriteFrameName:@"波谷脆干锅香葱味.png"];
                _value = 5;
                break;
                
            case fiveYellowBOGUCUI:
                self = [super initWithSpriteFrameName:@"波谷脆椒盐坚果味.psd"];
                _value = 5;
                break;
                
            case fiveBlueQIDUO:
                self = [super initWithSpriteFrameName:@"奇多美国火鸡60G.png"];
                _value = 5;
                break;
                
            case fiveRedQIDUO:
                self = [super initWithSpriteFrameName:@"奇多牛排60G.png"];

                _value = 5;
                break;
                
            case fiveRedLEKAICUI:
                self = [super initWithSpriteFrameName:@"乐开脆番茄味.png"];

                _value = 5;
                break;
                
            case fiveGreenLEKAICUI:
                self = [super initWithSpriteFrameName:@"乐开脆鲜虾味.png"];

                _value = 5;
                break;
                
            case tenPinkLESI:
                self = [super initWithSpriteFrameName:@"乐事墨西哥鸡汁番茄味45克.png"];

                _value = 10;
                break;
                
            case tenBlueLESI:
                self = [super initWithSpriteFrameName:@"乐事意大利香浓红烩味45克.png"];

                _value = 10;
                break;
                
            case tenYellowLESI:
                self = [super initWithSpriteFrameName:@"乐事美国经典原味45克.png"];

                _value = 10;
                break;
                
            case tenRedLESI:
                self = [super initWithSpriteFrameName:@"乐事得克萨斯烧烤味45克.png"];

                _value = 10;
                break;
                
            case orginLESI:
                self = [super initWithSpriteFrameName:@"乐事无限忠于原味110g.png"];

                _value = 20;
                break;
                
            case seasedgeYOUMICUI:
                self = [super initWithSpriteFrameName:@"悠米脆海苔味.png"];

                _value = 20;
                break;
                
            case natureYOUMOCUI:
                self = [super initWithSpriteFrameName:@"悠米脆原味.png"];

                _value = 20;
                break;
                
            case barbecueLESI:
                self = [super initWithSpriteFrameName:@"乐事无限兹兹烤肉味110g.png"];

                _value = 20;
                break;
                
            case spicySeaFoodLES:
                self = [super initWithSpriteFrameName:@"乐事无限香辣海鲜味110克.png"];

                _value = 20;
                break;
                
            case timeMinus5:
                self = [super initWithSpriteFrameName:@"青椰子.png"];

                _value = 0;
                _time = -5;
                break;
                
            case scoreMinus5:
                self = [super initWithSpriteFrameName:@"黄椰子.png"];
                _value = -5;
                break;
                
            case doubleScore:
                self = [super initWithFile:@"乐事加倍.png"];
                _value = -1;
                _line = 3;
                break;
            
            case bigCoke:
                self = [super initWithSpriteFrameName:@"百事大瓶装.png"];
                _value = 5;
                _line = 3;
                break;
                
            case bigchunguole:
                self = [super initWithSpriteFrameName:@"纯果乐大瓶装.png"];
                _value = 5;
                 _line = 3;
                break;
                
            case bigmeinianda:
                self = [super initWithSpriteFrameName:@"美年达大瓶装.png"];
                _value = 5;
                _line = 3;
                break;
                
            case bigqixi:
                self = [super initWithSpriteFrameName:@"七喜大瓶装.png"];
                _value = 5;
                 _line = 3;
                break;
                
            case xianguoli:
                self = [super initWithSpriteFrameName:@"鲜果粒.png"];
                _value = 5;
                 _line = 3;
                break;
                
            case smallCoke:
                self = [super initWithSpriteFrameName:@"百事小瓶装.png"];
                _value = 10;
                 _line = 3;
                break;
                
            case smallguobingfen:
                self = [super initWithSpriteFrameName:@"果缤纷小瓶装.png"];
                _value = 10;
                 _line = 3;
                break;
                
            case smalljiadele:
                self = [super initWithSpriteFrameName:@"佳得乐小瓶装.png"];
                _value = 10;
                _line = 3;
                break;
                
            case smalljilang:
                self = [super initWithSpriteFrameName:@"激浪小瓶装.png"];
                _value = 10;
                 _line = 3;
                break;
                
            case smallqixi:
                self = [super initWithSpriteFrameName:@"七喜小瓶装.png"];
                _value = 10;
                 _line = 3;
                break;
                
            case smalllidun:
                self = [super initWithSpriteFrameName:@"立顿小瓶装.png"];
                _value = 10;
                 _line = 3;
                break;
                
            case smallmeinianda:
                self = [super initWithSpriteFrameName:@"美年达小瓶装.png"];
                _value = 10;
                _line = 3;
                break;
                
            case smallxianguoli:
                self = [super initWithSpriteFrameName:@"鲜果粒小瓶装.png"];
                _value = 10;
                 _line = 3;
                break;
            
            case canCoke:
                self = [super initWithSpriteFrameName:@"百事罐装.png"];
                _value = 20;
                 _line = 3;
                break;
                
            case canqixi:
                self = [super initWithSpriteFrameName:@"七喜罐装.png"];
                _value = 20;
                 _line = 3;
                break;
                
            case canjilang:
                self = [super initWithSpriteFrameName:@"激浪罐装.png"];
                _value = 20;
                 _line = 3;
                break;
                
            case canmeinianda:
                self = [super initWithSpriteFrameName:@"美年达罐装.png"];
                _value = 20;
                 _line = 3;
                break;
                
            case icebergone:
                self = [super initWithSpriteFrameName:@"冰山_1.png"];
                _value = -5;
                 _line = 3;
                break;
                
            case icebergtwo:
                self = [super initWithSpriteFrameName:@"冰山_2.png"];
                _value = -5;
                 _line = 3;
                break;
                
            case icebergthree:
                self = [super initWithSpriteFrameName:@"冰山_3.png"];
                _value = -5;
                 _line = 3;
                break;
                
            default:
                break;
        }
    }    
    return self;
}

- (void)setLine:(int)line
{
    if (_line == -1) {
        return ;
    }
    _line = line;
    self.position = ccp(IPADWIDTH *  (_line + 1) + IPADWIDTH * 0.2 ,STARTHEIGHT  - _line * IPADHEIGHT / 4 + 25);
}

- (void)dealloc
{
    [super dealloc];
}

@end
