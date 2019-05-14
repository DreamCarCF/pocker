//
//  CFVGameCenterViewController.h
//  WindAndCloud
//
//  Created by cfv on 2019/4/25.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFVGameCenterViewController : UIViewController
- (BOOL) isGameCenterAvailable;
- (void) authenticateLocalPlayer;
@end

NS_ASSUME_NONNULL_END
