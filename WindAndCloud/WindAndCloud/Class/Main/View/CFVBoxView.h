//
//  CFVBoxView.h
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFVPlayerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CFVBoxView : UIView
//牌堆上的最后加入的牌
@property (weak, nonatomic) IBOutlet UIImageView *thirdPockerImgView;
//第二个加入牌堆的牌
@property (weak, nonatomic) IBOutlet UIImageView *secondPockerImgView;
//第一个加入牌堆的牌
@property (weak, nonatomic) IBOutlet UIImageView *firstPockerImgView;
@property (weak, nonatomic) IBOutlet UIButton *wantPockerBtn;
/** 当前积分label **/
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@property (nonatomic, strong) CFVPlayerModel *playerModel;

@end

NS_ASSUME_NONNULL_END
