//
//  SceneManager.h
//  Fishero
//
//  Created by 吴 wuziqi on 11-3-6.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SceneManager : NSObject {
    
}

+(void)goEndless;
+(void)goMenu;
+(void)goAdventure;
+(void)goSelect;
+(void)goMiniGame;
+(void)goMatch;
+(void)goStore;
+(void)goPuzzle;
+(void)goFishing;
+(void)goHelp;

@end
