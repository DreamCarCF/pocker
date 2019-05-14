//
//  UIView+CFVUIView.h
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CFVUIView)
+(id)viewFromNibNamed:(NSString*)nibName owner:(id)owner;
@end

NS_ASSUME_NONNULL_END
