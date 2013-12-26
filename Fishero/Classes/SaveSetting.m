//
//  SaveSetting.m
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-7.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "SaveSetting.h"


@implementation SaveSetting

+(void)saveMusic:(int)choice
{
    [[NSUserDefaults standardUserDefaults]setInteger:choice forKey:musicKey];
}

+(void)saveSound:(int)choice
{
    [[NSUserDefaults standardUserDefaults]setInteger:choice forKey:soundKey];
}

+(int)getMusic
{
    return [[NSUserDefaults standardUserDefaults]integerForKey:musicKey];
}

+(int)getSound
{
    return [[NSUserDefaults standardUserDefaults]integerForKey:soundKey];
}


@end
