//
//  GameLoginViewController.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//
#import <GameKit/GameKit.h>
#import "GameLoginViewController.h"
#import "CFVGameMainViewController.h"
#import "CFVGameCenterViewController.h"
@interface GameLoginViewController ()<GKGameCenterControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *integralBtn;
@property (weak, nonatomic) IBOutlet UIButton *startGameBtn;

@end

@implementation GameLoginViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController * __nullable viewController, NSError * __nullable error){
        if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
            NSLog(@"%@",@"已经授权！");
        }else if(viewController){
            [self presentViewController:viewController animated:YES completion:nil];
        }else{
            if (!error) {
                NSLog(@"%@",@"授权OK");
            } else {
                NSLog(@"没有授权");
                NSLog(@"AuthPlayer error :%@",error);
            }
        }
    };
}



//MARK: 积分按钮点击事件
- (IBAction)integralBtnClickAction:(UIButton *)sender {
//    CFVGameCenterViewController *gameCenterVC = [[CFVGameCenterViewController alloc]init];
//    [gameCenterVC authenticateLocalPlayer];
    [self authenticateLocalPlayer];
    if ([GKLocalPlayer localPlayer].isAuthenticated == NO) {
        NSLog(@"没有授权，无法获取展示中心");
        return;
    }
  
    GKGameCenterViewController *GCVC = [GKGameCenterViewController new];
    //跳转指定的排行榜中
    [GCVC setLeaderboardIdentifier:@"cgwp"];
    //跳转到那个时间段
    NSString *type = @"all";
    if ([type isEqualToString:@"today"]) {
        [GCVC setLeaderboardTimeScope:GKLeaderboardTimeScopeToday];
    }else if([type isEqualToString:@"week"]){
        [GCVC setLeaderboardTimeScope:GKLeaderboardTimeScopeWeek];
    }else if ([type isEqualToString:@"all"]){
        [GCVC setLeaderboardTimeScope:GKLeaderboardTimeScopeAllTime];
    }
    GCVC.gameCenterDelegate = self;
    [self presentViewController:GCVC animated:YES completion:nil];
}

//MARK: 开始按钮点击事件
- (IBAction)startGameBtnClickAction:(UIButton *)sender {
    CFVGameMainViewController *gameMainVC = [[CFVGameMainViewController alloc]initWithNibName:@"CFVGameMainViewController" bundle:nil];
    [self.navigationController pushViewController:gameMainVC animated:YES];
}


//实现代理：
#pragma mark -  GKGameCenterControllerDelegate
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
