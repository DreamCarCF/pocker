//
//  CFVBoxView.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVBoxView.h"

@implementation CFVBoxView
//先根据屏幕大小分配四个等宽等高等间距的容器视图，再去计算pocker的宽高，因为pocker的宽高永远略小于容器宽高
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [CFVBoxView viewFromNibNamed:@"CFVBoxView" owner:self];
        //初始化时置空所有的img
        self.firstPockerImgView.image = nil;
        self.secondPockerImgView.image = nil;
        self.thirdPockerImgView.image = nil;
        self.integralLabel.text = @"";
        self.playerModel = [[CFVPlayerModel alloc]init];
        
    }
    return self;
}




@end
