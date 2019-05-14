//
//  CFVHeGuanPockerModel.h
//  WindAndCloud
//
//  Created by cfv on 2019/4/20.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CFVHeGuanPockerModel : NSObject
/** 扑克总的数组 **/
@property (nonatomic,strong) NSMutableArray *pockerArray;
/** 等待发放的三张牌数组 **/
@property (nonatomic,strong) NSMutableArray *waitPockerArray;

/** 获取一个随机整数，范围在[from,to]，包括from，包括to **/
- (int)getRandomNumber:(int)from to:(int)to;

/** 取走一张删除对应牌 **/
- (void)deletOneHeGuanPockerWithPockerName:(NSString *)pockerName;

/** 牌满21分消除三张对应牌 **/
- (void)deletThreeHeGuanPockerWithPockerName:(NSString *)firstPockerName second:(NSString *)secondPockerName third:(NSString *)thirdPockerName;

/** 拿到当前牌的积分数 **/
- (NSString *)getPockerIntergalNumWithImgName:(NSString *)PockerImgName;

/** 将第二张牌和第一张牌分数相加返回分数总和 **/
- (NSString *)addSecondPockerWithFirstPockerIngtergal:(NSString *)firstIntergalStr second:(NSString *)secondIntergalStr;

/** 三张牌加和 **/
- (BOOL)addThreePockerIntergalStatuFirst:(NSString *)firstIntergalStr sec:(NSString *)secondIntergalStr third:(NSString *)thirdIntergalStr;
@end

NS_ASSUME_NONNULL_END
