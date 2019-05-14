//
//  CFVHeGuanPockerModel.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/20.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVHeGuanPockerModel.h"

@implementation CFVHeGuanPockerModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpHeGuanPockerArray];
    }
    return self;
}

- (void)setUpHeGuanPockerArray {
    self.pockerArray = [[NSMutableArray alloc]init];
    for (int pockFlowerKindItem = 1; pockFlowerKindItem<5; pockFlowerKindItem++) {
        for (int pockNumItem = 1; pockNumItem < 14; pockNumItem++) {
             [self.pockerArray addObject:[NSString stringWithFormat:@"%d_%d",pockFlowerKindItem,pockNumItem]];
        }
    }
}

//三张牌加和
- (BOOL)addThreePockerIntergalStatuFirst:(NSString *)firstIntergalStr sec:(NSString *)secondIntergalStr third:(NSString *)thirdIntergalStr {

    int threeNumSum = 0;
    if (firstIntergalStr != nil && secondIntergalStr != nil && thirdIntergalStr != nil) {
     int   firstIntergalNum = [firstIntergalStr intValue];
     int   secondIntergalNum = [secondIntergalStr intValue];
     int   thirdIntergalNUm = [thirdIntergalStr intValue];
        
        NSArray *threeNumArray = @[firstIntergalStr,secondIntergalStr,thirdIntergalStr];
        if ([threeNumArray containsObject:@"1"]) {//是否包含A这张牌，若没有则直接求和，若有再依次判断
            if ([firstIntergalStr isEqualToString:@"1"] && secondIntergalNum != 1 &&  thirdIntergalNUm != 1) {
                 threeNumSum = 10 + secondIntergalNum + thirdIntergalNUm;
                if (threeNumSum == 21) {
                    return YES;
                }else{
                    threeNumSum = 1 + secondIntergalNum + thirdIntergalNUm;
                    if (threeNumSum == 21) {
                        return  YES;
                    }else{
                        return NO;
                    }
                }
            }else if (firstIntergalNum != 1 && secondIntergalNum == 1 &&  thirdIntergalNUm != 1) {
                threeNumSum = 10 + firstIntergalNum + thirdIntergalNUm;
                if (threeNumSum == 21) {
                    return YES;
                }else{
                    threeNumSum = 1 + firstIntergalNum + thirdIntergalNUm;
                    if (threeNumSum == 21) {
                        return  YES;
                    }else{
                        return NO;
                    }
                }
            }else if (firstIntergalNum != 1 && secondIntergalNum != 1 &&  thirdIntergalNUm == 1) {
                threeNumSum = 10 + firstIntergalNum + secondIntergalNum;
                if (threeNumSum == 21) {
                    return YES;
                }else{
                    threeNumSum = 1 + firstIntergalNum + secondIntergalNum;
                    if (threeNumSum == 21) {
                        return  YES;
                    }else{
                        return NO;
                    }
                }
            }else if (firstIntergalNum == 1 && secondIntergalNum == 1 &&  thirdIntergalNUm != 1) {
                if (thirdIntergalNUm != 10) {
                    return NO;
                }else{
                    return YES;
                }
            }else if (firstIntergalNum != 1 && secondIntergalNum == 1 &&  thirdIntergalNUm == 1) {
                if (firstIntergalNum != 10) {
                    return NO;
                }else{
                    return YES;
                }
            }else if (firstIntergalNum == 1 && secondIntergalNum != 1 &&  thirdIntergalNUm == 1) {
                if (secondIntergalNum != 10) {
                    return NO;
                }else{
                    return YES;
                }
            }else if (firstIntergalNum == 1 && secondIntergalNum == 1 &&  thirdIntergalNUm == 1){
                return YES;
            }else {
                return NO;
            }
        }else{
            threeNumSum = firstIntergalNum + secondIntergalNum + thirdIntergalNUm;
            if (threeNumSum == 21) {
                return YES;
            }else{
                return NO;
            }
        }
//        return YES;
    }else{
        return NO;
    }
//    return NO;
}

//将第二张牌和第一张牌分数相加返回分数总和
- (NSString *)addSecondPockerWithFirstPockerIngtergal:(NSString *)firstIntergalStr second:(NSString *)secondIntergalStr {
    int secondSum = 0;
    if (firstIntergalStr != nil && secondIntergalStr != nil) {
        secondSum = [firstIntergalStr intValue] + [secondIntergalStr intValue];
        return [NSString stringWithFormat:@"%d",secondSum];
    }else{
        return @"0";
    }
}

/** 拿到当前牌的积分数 **/
- (NSString *)getPockerIntergalNumWithImgName:(NSString *)PockerImgName {
    NSArray *numArray = [[NSArray alloc]init];
    int finalIntergalNum = 0;
    if (PockerImgName != nil) {
        numArray = [PockerImgName componentsSeparatedByString:@"_"];
    }
    if (numArray.count == 2) {//判断牌面数是否大于10，或等于1,即A,A可代表10或1, 若大于10的牌面,统一分值为10
        finalIntergalNum = [numArray[1] intValue];
        if (finalIntergalNum > 10) { //这里只判断是否大于10
            finalIntergalNum = 10;
        }
        return [NSString stringWithFormat:@"%d",finalIntergalNum];
    }else{
        NSLog(@"获取牌面分值数组错误，请查看PockerModel，获取积分数方法");
        return @"0";
    }
    
}

- (void)deletOneHeGuanPockerWithPockerName:(NSString *)pockerName {
    if ([self.pockerArray containsObject:pockerName]) {
        [self.pockerArray removeObject:pockerName];
    }
}

- (void)deletThreeHeGuanPockerWithPockerName:(NSString *)firstPockerName second:(NSString *)secondPockerName third:(NSString *)thirdPockerName {
    if ([self.pockerArray containsObject:firstPockerName]) {
        [self.pockerArray removeObject:firstPockerName];
    }
    if ([self.pockerArray containsObject:secondPockerName]) {
        [self.pockerArray removeObject:secondPockerName];
    }
    if ([self.pockerArray containsObject:thirdPockerName]) {
        [self.pockerArray removeObject:thirdPockerName];
    }    
}

-(int)getRandomNumber:(int)from to:(int)to {
    if (to == 1) {
        return 0;
    }else{
    return (int)(from + (arc4random() % (to - (from + 1))));
    }
}
@end
