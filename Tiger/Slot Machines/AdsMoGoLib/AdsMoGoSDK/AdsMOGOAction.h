//
//  AdsMOGOAction.h
//  AdsMogo   
//
//  Created by pengxu on 12-2-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMNetworkReachabilityDelegate.h"


@interface AdsMOGOAction : NSObject <AMNetworkReachabilityDelegate>{
    NSURLConnection *connection_;
}

-(void)action:(NSString *)adID;

@end
