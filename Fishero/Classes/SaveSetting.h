//
//  SaveSetting.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-7.
//  Copyright 2011年 同济大学. All rights reserved.
//

#define musicKey @"musicKey"
#define soundKey @"soundKey"

#import <Foundation/Foundation.h>


@interface SaveSetting : NSObject {
    
}

+(void)saveSound:(int)choice;
+(void)saveMusic:(int)choice;

+(int)getMusic;
+(int)getSound;

@end
