	//
	//  highScore.h
	//  tapat
	//
	//  Created by 吴 wuziqi on 11-1-26.
	//  Copyright 2011 同济大学. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameCenterManager.h"
@class GameCenterManager;

@interface highScore : CCLayer<UIAlertViewDelegate,GameCenterManagerDelegate> {
	GameCenterManager* gameCenterManager;
	int64_t score;
	//CCLabelTTF* advenLabel;
	//CCLabelTTF* challenLabel;
	CCLabelTTF* scoreLabel;
	CCLabelTTF* levelLabel[8];
}
@property(nonatomic,retain)GameCenterManager* gameCenterManager;

-(void)submitToLeaderboard:(id)sender;
-(void)gameCenterFunction;
-(void)initButton;
-(void)showAllScoreLocally;
- (void) showAlertWithTitle: (NSString*) title message: (NSString*) message;


@end
