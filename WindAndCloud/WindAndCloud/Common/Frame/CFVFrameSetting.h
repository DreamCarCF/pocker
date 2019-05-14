//
//  CFVFrameSetting.h
//  WindAndCloud
//
//  Created by cfv on 2019/4/18.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFVFrameSetting : NSObject
//卡牌盒子之间的间距
@property (nonatomic, assign) CGFloat boxViewOffset_X;
//卡牌盒子距顶部边界的距离
@property (nonatomic, assign) CGFloat boxViewTopOffset_Y;
//卡牌盒子距底部边界的距离
@property (nonatomic, assign) CGFloat boxViewBottomOffset_Y;
//卡牌盒子距左边边界的距离
@property (nonatomic, assign) CGFloat boxViewLeftOffset_X;
//卡牌盒子距右边边界的距离
@property (nonatomic, assign) CGFloat boxViewRightOffset_X;
//扑克宽度
@property (nonatomic, assign) CGFloat pockerWidth_width;
//扑克高度
@property (nonatomic, assign) CGFloat pockerHeight_height;
- (void)setupBoxSubViewFrameSetting;
@end

NS_ASSUME_NONNULL_END
