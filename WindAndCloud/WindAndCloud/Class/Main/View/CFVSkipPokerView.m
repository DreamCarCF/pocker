//
//  CFVSkipPokerView.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVSkipPokerView.h"

@implementation CFVSkipPokerView
//先根据屏幕大小分配四个等宽等高等间距的容器视图，再去计算pocker的宽高，因为pocker的宽高永远略小于容器宽高
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [CFVSkipPokerView viewFromNibNamed:@"CFVSkipPokerView" owner:self];
    }
    return self;
}
@end
