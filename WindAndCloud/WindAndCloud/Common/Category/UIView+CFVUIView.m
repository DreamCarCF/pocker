//
//  UIView+CFVUIView.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "UIView+CFVUIView.h"

@implementation UIView (CFVUIView)
+(id)viewFromNibNamed:(NSString*)nibName owner:(id)owner{
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    return [nibView firstObject];
}
@end
