//
//  SceneManager.h
//  tapat
//
//  Created by 吴 wuziqi on 11-1-24.
//  Copyright 2011 同济大学. All rights reserved.
//



@interface SceneManager : NSObject {

}

+(void)goAdventure:(id)sender;
+(void)goClassical:(id)sender;
+(void)goMenu:(id)sender;
+(void)goAbout:(id)sender;
+(void)goOptions:(id)sender;
+(void)goHighScore:(id)sender;
+(void)goWin:(id)sender;
+(void)goLose:(id)sender;
+(void)goGameOver:(id)sender;
+(void)goLoading:(id)sender;

@end
