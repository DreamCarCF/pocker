//
//  CFVGameMainViewController.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVGameMainViewController.h"
#import "CFVTopSingleShowPockerView.h"
#import "CFVHeGuanPockerModel.h"
#import "CFVPlayerModel.h"
#import "CFVCommonBottomView.h"
#import "CFVSkipPokerView.h"
#import "CFVFrameSetting.h"
#import "CFVWaitView.h"
#import "CFVBoxView.h"
#import "CFVEndGameView.h"
#import "CFVIntergalView.h"
#import "NSTimer+HICategory.h"





@interface CFVGameMainViewController () {
    NSString *_pockerName;
    NSInteger _leftSeconds;
    NSInteger _intergalNum;
    NSInteger _remainPockerCountNum;
    NSTimer *_timer;
    struct {
        MASViewAttribute *pockerWidth;
        MASViewAttribute *pockerHeight;
    } pockerImgFrame; //扑克牌的宽高
}

@property (nonatomic, strong) CFVCommonBottomView *bottomView;
//从左往右第一个
@property (nonatomic, strong) CFVBoxView *firstBoxView;
//从左往右第二个
@property (nonatomic, strong) CFVBoxView *secondBoxView;
//从左往右第三个
@property (nonatomic, strong) CFVBoxView *thirdBoxView;
//从左往右第四个
@property (nonatomic, strong) CFVBoxView *fourthBoxView;
//左上角跳过按钮
@property (nonatomic, strong) CFVSkipPokerView *skipPockerView;
//中间展示扑克
@property (nonatomic, strong) CFVTopSingleShowPockerView *centerPockerShowView;
//等待的三张扑克
@property (nonatomic, strong) CFVWaitView *waitPockerView;
/** 荷官的Model 包含扑克总数组，包含等待区域三张数组 **/
@property (nonatomic, strong) CFVHeGuanPockerModel *heguanModel;
/** 玩家model **/
@property (nonatomic, strong) CFVPlayerModel *playerModel;
/** 游戏结束页面 **/
@property (nonatomic, strong) CFVEndGameView *endGameView;

@property (nonatomic, strong) CFVIntergalView *intergalView;
@property (nonatomic, strong) UIView *blackView;
/** 中心展示扑克 **/
@property (nonatomic, copy) NSString *centerShowPockerNameStr;


@end

@implementation CFVGameMainViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timer invalidate];
    NSLog(@"dealloc: %@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftSeconds = 240;
    _intergalNum = 0000;
    _remainPockerCountNum = 52;
    
    [self setupUI];
    [self setupAnimtation];
    [self setupModel];
    [self setupTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameEndNotification:) name:GameEndNotification object:nil];

//    [self gameEndNotification:nil];
}


- (void)setupAnimtation { // 加载新一手牌动画动画 从左到右
    UIImageView *welcomeImgView = [[UIImageView alloc]init];
    welcomeImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:welcomeImgView];
    [welcomeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(60);
    }];
    welcomeImgView.image = [UIImage imageNamed:@"xinpai.png"];
    
    [UIView animateWithDuration:2.0 animations:^{
        welcomeImgView.alpha = 0;
    } completion:^(BOOL finished) {
        [welcomeImgView removeFromSuperview];
    }];
}

#pragma mark -NOTIFICATION
- (void)gameEndNotification:(NSNotification *)notification {
    self.blackView = [[UIView alloc]init];
    self.blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:self.blackView];
    [self.blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.endGameView = [[CFVEndGameView alloc]init];
    [self.view addSubview:self.endGameView];
    [self.endGameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-80);
        make.top.equalTo(self.view).offset(80);
        make.bottom.equalTo(self.view).offset(-80);
    }];
    [self.endGameView.reStartBtn addTarget:self action:@selector(resetstartBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.endGameView.writeIntergalBtn addTarget:self action:@selector(writeIntergalBtnAction) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *strarray = [[NSMutableArray alloc]init];
    NSString *intergalStr = [NSString stringWithFormat:@"%ld",_intergalNum];
    for (int i = 0;i < intergalStr.length; i++) {
        [strarray addObject:[intergalStr substringWithRange:NSMakeRange(i, 1)]];
    }
    self.endGameView.wanNumImgView.hidden = YES;
    self.endGameView.qianNumImgView.hidden = YES;
    self.endGameView.baiNumImgViwe.hidden = YES;
    self.endGameView.shiNumImgView.hidden = YES;
    self.endGameView.geNumImgView.hidden = YES;
    
    for (int i = 0; i<strarray.count; i++) {
        switch (i) {
            case 0:
                self.endGameView.wanNumImgView.hidden = NO;
                self.endGameView.wanNumImgView.image = [UIImage imageNamed:strarray.firstObject];
                break;
            case 1:
                self.endGameView.qianNumImgView.hidden = NO;
                 self.endGameView.qianNumImgView.image = [UIImage imageNamed:strarray[i]];
                break;
            case 2:
                self.endGameView.baiNumImgViwe.hidden = NO;
                 self.endGameView.baiNumImgViwe.image = [UIImage imageNamed:strarray[i]];
                break;
            case 3:
                self.endGameView.shiNumImgView.hidden = NO;
                 self.endGameView.shiNumImgView.image = [UIImage imageNamed:strarray[i]];
                break;
            case 4:
                self.endGameView.geNumImgView.hidden = NO;
                 self.endGameView.geNumImgView.image = [UIImage imageNamed:strarray[i]];
                break;
                
            default:
                break;
        }
    }

    
    NSLog(@"游戏结束");
    [_timer invalidate];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




- (void)setupTimer {
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer db_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        [weakSelf reduceLeftSeconds];
        NSInteger seconds = _leftSeconds;
        self.bottomView.fireTimeLabel.text = [NSString stringWithFormat:@"%ld:%02ld", (long)seconds / 60, (long)seconds % 60];
        if (seconds <= 0 || self.heguanModel.waitPockerArray.count == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:GameEndNotification object:nil];
            });
        }
    }];
}

- (void)reduceLeftSeconds {
    _leftSeconds --;
}

//MARK:模型初始化
- (void)setupModel {
    //初始化等待区域扑克
    self.heguanModel = [[CFVHeGuanPockerModel alloc]init];
    self.heguanModel.waitPockerArray = [[NSMutableArray alloc]init];
    
    [self updateWaitArray];
    self.centerShowPockerNameStr = self.heguanModel.waitPockerArray[0];
    [self.heguanModel.waitPockerArray removeObject:self.centerShowPockerNameStr];
    [self updateWaitArray];
    _pockerName = @"chess_poker_";
    [self setupWaitViewWithPockerModel];
    [self setupCenterShowViewWithPockerModel];
    
    [self.skipPockerView.skipButton addTarget:self action:@selector(skipThisPockerBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

//MARK:数据处理 更新等待数组
- (void)updateWaitArray {
    if (self.heguanModel.waitPockerArray.count == 3 && self.heguanModel.pockerArray.count == 0) {
        return;
    }
    while (self.heguanModel.waitPockerArray.count < 3) {
        int choseIndexNum = 0;
        if (self.heguanModel.pockerArray.count == 0) {break;}
        if (self.heguanModel.pockerArray.count == 1) {
            choseIndexNum = 0;
        }else{
            if (self.heguanModel.pockerArray.count == 3) {
                choseIndexNum = 2;
            }else if (self.heguanModel.pockerArray.count == 2) {
                choseIndexNum = 1;
            }else{
            choseIndexNum = [self.heguanModel getRandomNumber:0 to:(int)self.heguanModel.pockerArray.count-1];
            }
        }
        
        //当所选牌已在等待区域或在中心展示区域，直接返回重选牌
        if ([self.heguanModel.waitPockerArray containsObject:self.heguanModel.pockerArray[choseIndexNum]]){
            return;
        }else if ([self.heguanModel.waitPockerArray containsObject:self.centerShowPockerNameStr]) {
            [self.heguanModel.waitPockerArray removeObject:self.centerShowPockerNameStr];
            [self setupWaitViewWithPockerModel];
            return;
        }else if([self.centerShowPockerNameStr isEqualToString:self.heguanModel.pockerArray[choseIndexNum]]) {
            return;
        }else{
        [self.heguanModel.waitPockerArray addObject:self.heguanModel.pockerArray[choseIndexNum]];
        }
        if (self.heguanModel.waitPockerArray.count == 3) {
            break;
        }
    }
}

//MARK:数据处理 当点击要牌之后的一系列操作
- (void)updateAfterWantPockerGiveArrayData {
    self.centerShowPockerNameStr = self.heguanModel.waitPockerArray.firstObject;
    //更新中心展示视图
    [self setupCenterShowViewWithPockerModel];
    
    if (self.heguanModel.waitPockerArray.count != 0) {
    [self.heguanModel.waitPockerArray removeObject:self.centerShowPockerNameStr];
    }
    if (self.heguanModel.pockerArray.count == 3){
        NSLog(@"111");
    }
    [self updateWaitArray];
    //更新等待视图
    [self setupWaitViewWithPockerModel];
}

//MARK:视图初始化
- (void)setupUI {
    //1.确定底部视图，时间，剩余排数，积分
    self.bottomView = [[CFVCommonBottomView alloc]init];
    [self.view addSubview:self.bottomView];
    [self setupBottomViewFrame];
    //先根据屏幕大小分配四个等宽等高等间距的容器视图，再去计算pocker的宽高，因为pocker的宽高永远略小于容器宽高
    self.firstBoxView  = [[CFVBoxView alloc]init];
    [self.view addSubview:self.firstBoxView];
    self.secondBoxView = [[CFVBoxView alloc]init];
    [self.view addSubview:self.secondBoxView];
    self.thirdBoxView  = [[CFVBoxView alloc]init];
    [self.view addSubview:self.thirdBoxView];
    self.fourthBoxView = [[CFVBoxView alloc]init];
    [self.view addSubview:self.fourthBoxView];
    [self setupBoxViewFrame];
    
    //要牌按钮事件添加
    [self.firstBoxView.wantPockerBtn addTarget:self action:@selector(firstBoxViewWantPockerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.secondBoxView.wantPockerBtn addTarget:self action:@selector(secondBoxViewWantPockerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.thirdBoxView.wantPockerBtn addTarget:self action:@selector(thirdBoxViewWantPockerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.fourthBoxView.wantPockerBtn addTarget:self action:@selector(fourthBoxViewWantPockerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstBoxView layoutIfNeeded];
    pockerImgFrame.pockerWidth  = self.firstBoxView.firstPockerImgView.mas_width;
    pockerImgFrame.pockerHeight = self.firstBoxView.firstPockerImgView.mas_height;
    
    //初始化左边跳过pocker
    self.skipPockerView = [[CFVSkipPokerView alloc]init];
    self.skipPockerView.skipButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.skipPockerView];
    //初始化中心展示扑克
    self.centerPockerShowView = [[CFVTopSingleShowPockerView alloc]init];
    [self.view addSubview:self.centerPockerShowView];
    //初始化等待的牌堆
    self.waitPockerView = [[CFVWaitView alloc]init];
    [self.view addSubview:self.waitPockerView];
    [self setupDesktopUpLeftSkipPockerBtnAndRightWaitPockerViewAndCenterPockerViewFrame];
    
}


//MARK:模型与视图关联
//等待区域模型于视图关联
- (void)setupWaitViewWithPockerModel {
    switch (self.heguanModel.waitPockerArray.count) {
        case 0:
            self.waitPockerView.firstWaitPockerImgView.image = nil;
            self.waitPockerView.secondWaitPockerImgView.image = nil;
            self.waitPockerView.thirdWaitPockerImgView.image = nil;
            break;
        case 1: {
            self.waitPockerView.firstWaitPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.heguanModel.waitPockerArray[0]]];
            self.waitPockerView.secondWaitPockerImgView.image = nil;
            self.waitPockerView.thirdWaitPockerImgView.image = nil;
        }
            break;
        case 2: {
            self.waitPockerView.firstWaitPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.heguanModel.waitPockerArray[0]]];
            self.waitPockerView.secondWaitPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.heguanModel.waitPockerArray[1]]];
                 self.waitPockerView.thirdWaitPockerImgView.image = nil;
            
        }
            break;
        case 3: {
            self.waitPockerView.firstWaitPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.heguanModel.waitPockerArray[0]]];
            self.waitPockerView.secondWaitPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.heguanModel.waitPockerArray[1]]];
             self.waitPockerView.thirdWaitPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.heguanModel.waitPockerArray[2]]];
        }
            break;
            
        default:
            break;
    }
}

- (void)setupCenterShowViewWithPockerModel {
    self.centerPockerShowView.centerShowImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.centerShowPockerNameStr]];
}



-(void)viewDidLayoutSubviews {
}

#pragma -Frame
//底部视图的frame
- (void)setupBottomViewFrame {
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@64);
    }];
}

//放牌的盒子视图frame
- (void)setupBoxViewFrame {
    CFVFrameSetting *boxViewFrame = [[CFVFrameSetting alloc]init];
    [boxViewFrame setupBoxSubViewFrameSetting];
    [self.firstBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(boxViewFrame.boxViewTopOffset_Y));
        make.left.equalTo(@(boxViewFrame.boxViewLeftOffset_X));
        make.right.equalTo(self.secondBoxView.mas_left).offset(boxViewFrame.boxViewOffset_X);
        make.bottom.equalTo(@(boxViewFrame.boxViewBottomOffset_Y));
    }];
    [self.secondBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(boxViewFrame.boxViewTopOffset_Y));
        make.right.equalTo(self.thirdBoxView.mas_left).offset(boxViewFrame.boxViewOffset_X);
        make.bottom.equalTo(@(boxViewFrame.boxViewBottomOffset_Y));
        make.width.equalTo(self.firstBoxView.mas_width);
        make.height.equalTo(self.firstBoxView.mas_height);
    }];
    [self.thirdBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(boxViewFrame.boxViewTopOffset_Y));
        make.right.equalTo(self.fourthBoxView.mas_left).offset(boxViewFrame.boxViewOffset_X);
        make.bottom.equalTo(@(boxViewFrame.boxViewBottomOffset_Y));
        make.width.equalTo(self.firstBoxView.mas_width);
        make.height.equalTo(self.firstBoxView.mas_height);
    }];
    [self.fourthBoxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(boxViewFrame.boxViewTopOffset_Y));
        make.right.equalTo(@(boxViewFrame.boxViewRightOffset_X));
        make.bottom.equalTo(@(boxViewFrame.boxViewBottomOffset_Y));
        make.width.equalTo(self.firstBoxView.mas_width);
        make.height.equalTo(self.firstBoxView.mas_height);
    }];
}

//牌桌左上角跳过按钮和牌桌右上角等待牌堆和中间展示扑克frame
- (void)setupDesktopUpLeftSkipPockerBtnAndRightWaitPockerViewAndCenterPockerViewFrame {
    //1.左上角跳过按钮Frame
    [self.skipPockerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.firstBoxView.mas_top).offset(0);
        make.left.equalTo(self.firstBoxView.mas_left).offset(20);
        make.width.equalTo(pockerImgFrame.pockerWidth);
        make.height.equalTo(pockerImgFrame.pockerHeight);
    }];
    
    //2.中间展示扑克Frame
    [self.centerPockerShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.skipPockerView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(pockerImgFrame.pockerWidth);
        make.height.equalTo(pockerImgFrame.pockerHeight);
    }];
    
    //3.等待展示的扑克Frame
    [self.waitPockerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.skipPockerView.mas_bottom);
        make.right.equalTo(self.fourthBoxView.mas_right).offset(-20);
        make.width.equalTo(self.fourthBoxView.mas_width);
        make.height.equalTo(pockerImgFrame.pockerHeight);
    }];

    
}


- (void)setIntergalImgView:(NSInteger)IntergalNum andImgViewItems:(NSMutableArray *)imgViewArray{
    
    NSMutableArray *strarray = [[NSMutableArray alloc]init];
    NSString *intergalStr = [NSString stringWithFormat:@"%ld",IntergalNum];
    for (int i = 0;i < intergalStr.length; i++) {
        [strarray addObject:[intergalStr substringWithRange:NSMakeRange(i, 1)]];
    }
    
    UIImageView *firstImgView = imgViewArray[0];
    UIImageView *secondImgView = imgViewArray[1];
    UIImageView *thirdImgView = imgViewArray[2];
    UIImageView *fourthImgView = imgViewArray[3];
    UIImageView *fifthImgView = imgViewArray[4];
    
     firstImgView.hidden = YES;
     secondImgView.hidden = YES;
     thirdImgView.hidden = YES;
     fourthImgView.hidden = YES;
     fifthImgView.hidden = YES;
    for (int i = 0; i<strarray.count; i++) {
        switch (i) {
            case 0:
                firstImgView.hidden = NO;
                 firstImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"j_%@",strarray.firstObject]];
                break;
            case 1:
                secondImgView.hidden = NO;
                secondImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"j_%@",strarray[i]]];
                break;
            case 2:
                thirdImgView.hidden = NO;
                thirdImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"j_%@",strarray[i]]];
                break;
            case 3:
                fourthImgView.hidden = NO;
                fourthImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"j_%@",strarray[i]]];
                break;
            case 4:
                fifthImgView.hidden = NO;
                fifthImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"j_%@",strarray[i]]];
                break;
                
            default:
                break;
        }
    }
}



- (void)setThirdIntergalImgView:(NSInteger)thirdIntergalNum {
    NSMutableArray *imgViewArray = [[NSMutableArray alloc]initWithArray:@[self.intergalView.thirdWanIngertalNumImgView,self.intergalView.thirdQianIngertalNumImgView, self.intergalView.thirdBaiIngertalNumImgView,self.intergalView.thirdShiIngertalNumImgView,self.intergalView.thirdGeIngertalNumImgView]];
    [self setIntergalImgView:thirdIntergalNum andImgViewItems:imgViewArray];
}

- (void)setSecondIntergalImgView:(NSInteger)secondIntergalNum {
    NSMutableArray *imgViewArray = [[NSMutableArray alloc]initWithArray:@[self.intergalView.secondWanIngertalNumImgView,self.intergalView.secondQianIngertalNumImgView, self.intergalView.secondBaiIngertalNumImgView,self.intergalView.secondShiIngertalNumImgView,self.intergalView.secondGeIngertalNumImgView]];
    
    [self setIntergalImgView:secondIntergalNum andImgViewItems:imgViewArray];
}

- (void)setTopIntergalImgView:(NSInteger)topIntergalNum {
 NSMutableArray *imgViewArray = [[NSMutableArray alloc]initWithArray:@[self.intergalView.topWanIngertalNumImgView,self.intergalView.topQianIngertalNumImgView, self.intergalView.topBaiIngertalNumImgView,self.intergalView.topShiIngertalNumImgView,self.intergalView.topGeIngertalNumImgView]];
    
    [self setIntergalImgView:topIntergalNum andImgViewItems:imgViewArray];
}

#pragma mark -Action
//写入积分
-(void)writeIntergalBtnAction {
    self.endGameView.hidden = YES;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger topIntergalNum = [defaults integerForKey:@"topIntergalNum"];
    NSInteger secondIntergalNum  = [defaults integerForKey:@"secondIntergalNum"];
    NSInteger thirdIntergalNum = [defaults integerForKey:@"thirdIntergalNum"];
    if (topIntergalNum) {
        if (_intergalNum > topIntergalNum ) {
            topIntergalNum = _intergalNum;
            [defaults setInteger:topIntergalNum forKey:@"topIntergalNum"];
        }
    }else if (secondIntergalNum) {
        if (_intergalNum > secondIntergalNum ) {
            secondIntergalNum = _intergalNum;
            [defaults setInteger:secondIntergalNum forKey:@"secondIntergalNum"];
        }
    }else if (thirdIntergalNum) {
        if (_intergalNum > thirdIntergalNum ) {
            thirdIntergalNum = _intergalNum;
            [defaults setInteger:thirdIntergalNum forKey:@"thirdIntergalNum"];
        }
    }else{
        topIntergalNum = _intergalNum;
        [defaults setInteger:topIntergalNum forKey:@"topIntergalNum"];
    }
    [defaults synchronize];
   
    self.intergalView = [[CFVIntergalView alloc]init];
    [self.view addSubview:self.intergalView];
    [self.intergalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-80);
        make.top.equalTo(self.view).offset(80);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    
    [self setTopIntergalImgView:topIntergalNum];
    [self setSecondIntergalImgView:secondIntergalNum];
    [self setThirdIntergalImgView:thirdIntergalNum];
    
    [self.intergalView.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

//返回按钮
- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}
//重新开局
- (void)resetstartBtnAction {
    [self.blackView removeFromSuperview];
    [self.endGameView removeFromSuperview];
    _leftSeconds = 240;
    _intergalNum = 0000;
    _remainPockerCountNum = 52;
    [self resetBoxView:self.firstBoxView];
    [self resetBoxView:self.secondBoxView];
    [self resetBoxView:self.thirdBoxView];
    self.bottomView.integralNumLabel.text = @"0000";
    self.bottomView.remainNumLabel.text = @"52";
    [self setupAnimtation];
    [self setupModel];
    [self setupTimer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameEndNotification:) name:GameEndNotification object:nil];
}

- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/** 跳过此张视图,需要获取等待区域顶部牌，更新等待区域牌视图与数组，更新中心牌 **/
- (void)skipThisPockerBtnAction {
    if (self.heguanModel.waitPockerArray.count == 0) {return;}
    self.centerShowPockerNameStr = self.heguanModel.waitPockerArray.firstObject;
    [self setupCenterShowViewWithPockerModel];
    [self.heguanModel.waitPockerArray removeObjectAtIndex:0];
    [self updateWaitArray];
    [self setupWaitViewWithPockerModel];
}

//点击第一个牌堆的要牌按钮,从展示牌拿牌，荷官牌数组delete相应牌
- (void)firstBoxViewWantPockerBtnAction {
    [self setUpBoxImgViewWith:self.firstBoxView];
}

- (void)secondBoxViewWantPockerBtnAction {
     [self setUpBoxImgViewWith:self.secondBoxView];
}

- (void)thirdBoxViewWantPockerBtnAction {
     [self setUpBoxImgViewWith:self.thirdBoxView];
}

- (void)fourthBoxViewWantPockerBtnAction {
     [self setUpBoxImgViewWith:self.fourthBoxView];
}

- (void)setUpBoxImgViewWith:(CFVBoxView *)boxItemView {
    if (self.centerShowPockerNameStr == nil && self.heguanModel.waitPockerArray.count == 0) {return;//已经无牌可发
    }
    //先判断boxView中有无牌，再判断所选牌放置位置
    if (boxItemView.thirdPockerImgView.image == nil) { //第一张如果为空,其他两项必为空
            boxItemView.thirdPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.centerShowPockerNameStr]];
            //数据删除
            [self.heguanModel.pockerArray removeObject:self.centerShowPockerNameStr];
            //更新积分数
            boxItemView.integralLabel.text = [self.heguanModel getPockerIntergalNumWithImgName:self.centerShowPockerNameStr];
            boxItemView.playerModel.pockerBoxModel.firstImgViewPockerValue = boxItemView.integralLabel.text;
         [self updateAfterWantPockerGiveArrayData];
        
    }else if (boxItemView.secondPockerImgView.image == nil){
        
        boxItemView.secondPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.centerShowPockerNameStr]];
        //数据删除
        [self.heguanModel.pockerArray removeObject:self.centerShowPockerNameStr];
       boxItemView.playerModel.pockerBoxModel.secondImgViewPockerValue = [self.heguanModel getPockerIntergalNumWithImgName:self.centerShowPockerNameStr];
        //拿到第二张牌，更新积分数
        boxItemView.integralLabel.text = [self.heguanModel addSecondPockerWithFirstPockerIngtergal:boxItemView.playerModel.pockerBoxModel.firstImgViewPockerValue second:boxItemView.playerModel.pockerBoxModel.secondImgViewPockerValue];
        [self updateAfterWantPockerGiveArrayData];
        
    }else if (boxItemView.firstPockerImgView.image == nil) {
        boxItemView.firstPockerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",_pockerName,self.centerShowPockerNameStr]];
        //数据删除
        [self.heguanModel.pockerArray removeObject:self.centerShowPockerNameStr];
        boxItemView.playerModel.pockerBoxModel.thirdImgViewPockerValue = [self.heguanModel getPockerIntergalNumWithImgName:self.centerShowPockerNameStr];
        //求和，满足21 yes 清除牌堆，加相应积分；若不满足NO，爆炸牌堆，扣相应积分；（爆炸也是清除牌堆）
        BOOL addIntergalStatu =[self.heguanModel addThreePockerIntergalStatuFirst:boxItemView.playerModel.pockerBoxModel.firstImgViewPockerValue
                                                                              sec:boxItemView.playerModel.pockerBoxModel.secondImgViewPockerValue third:boxItemView.playerModel.pockerBoxModel.thirdImgViewPockerValue];
        if(addIntergalStatu) {
            boxItemView.integralLabel.text = @"21";
            [self performSelector:@selector(addIntergalAnimationWith:) withObject:boxItemView afterDelay:1.0];
        }else{
            boxItemView.integralLabel.text = @"XX";
             [self performSelector:@selector(subtractIntergalAnimationWith:) withObject:boxItemView afterDelay:1.0];
        }
        [self updateAfterWantPockerGiveArrayData];
    }
    
   
    
}

- (void)resetBoxView:(CFVBoxView *)boxView{
    boxView.firstPockerImgView.image = nil;
    boxView.secondPockerImgView.image = nil;
    boxView.thirdPockerImgView.image = nil;
    boxView.integralLabel.text = @"";
}

- (void)clearBoxViewWith:(CFVBoxView *)boxView {
    _remainPockerCountNum -= 3;
    self.bottomView.remainNumLabel.text = [NSString stringWithFormat:@"%ld",_remainPockerCountNum];
    [self resetBoxView:boxView];
}
//加分动画
- (void)addIntergalAnimationWith:(CFVBoxView *)boxItemView {
     NSLog(@"加分");
    _intergalNum += 100;
    self.bottomView.integralNumLabel.text = [NSString stringWithFormat:@"%ld",_intergalNum];
    //清空boxView所有子视图
    [self clearBoxViewWith:boxItemView];
}

//爆炸减分动画
- (void)subtractIntergalAnimationWith:(CFVBoxView *)boxItemView {
    NSLog(@"减分");
    //清空boxView所有子视图
    [self clearBoxViewWith:boxItemView];
    
    if (_intergalNum <= 0) {//积分小于0时直接返回
        return;
    }
    _intergalNum -= 100;
    self.bottomView.integralNumLabel.text = [NSString stringWithFormat:@"%ld",_intergalNum];
  
}
@end
