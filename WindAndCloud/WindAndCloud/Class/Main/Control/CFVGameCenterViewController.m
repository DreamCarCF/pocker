//
//  CFVGameCenterViewController.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/25.
//  Copyright © 2019 SpeedUp. All rights reserved.
//
#import <GameKit/GameKit.h>
#import "CFVGameCenterViewController.h"

@interface CFVGameCenterViewController ()

@end

@implementation CFVGameCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (BOOL) isGameCenterAvailable
{
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}


- (void) authenticateLocalPlayer
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


// 上传分数给 gameCenter
-(void)saveHighScore{
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        //得到分数的报告
        GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:@"你的排行榜ID，ITC中找"];
        scoreReporter.value = 1000;
        NSArray<GKScore*> *scoreArray = @[scoreReporter];
        //上传分数
        [GKScore reportScores:scoreArray withCompletionHandler:nil];
    }
}

//下载 game center 某一排行榜中的分数及排名情况
- (void)downLoadGameCenter{
    if ([GKLocalPlayer localPlayer].isAuthenticated == NO) {
        NSLog(@"没有授权，无法获取更多信息");
        return;
    }
    GKLeaderboard *leaderboadRequest = [GKLeaderboard new];
    //设置好友的范围
    leaderboadRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
    //指定那个区域的排行榜
    NSString *type = @"today";
    if ([type isEqualToString:type]) {
        leaderboadRequest.timeScope = GKLeaderboardTimeScopeToday;
        
    }else if([type isEqualToString:@"week"]){
        leaderboadRequest.timeScope = GKLeaderboardTimeScopeWeek;
        
    }else if([type isEqualToString:@"all"]){
        leaderboadRequest.timeScope = GKLeaderboardTimeScopeAllTime;
        
    }
    //哪一个排行榜
    NSString *ID = @"你的排行榜ID，ITC中找";
    leaderboadRequest.identifier = ID;
    //从那个排名到那个排名
    NSInteger location = 1;
    NSInteger length = 10;
    leaderboadRequest.range = NSMakeRange(location, length);
    //请求数据
    [leaderboadRequest loadScoresWithCompletionHandler:^(NSArray<GKScore *> * _Nullable scores, NSError * _Nullable error) {
        if (error) {
            NSLog(@"请求分数失败");
            NSLog(@"error = %@",error);
        }else{
            NSLog(@"请求分数成功");
            //定义一个可变字符串存放用户信息
            NSMutableString *userInfo = [NSMutableString string];
            NSString *rankBoardID = nil;
            for (GKScore *score in scores) {
                NSLog(@"");
                //得到排行榜的 id
                NSString *gamecenterID = score.leaderboardIdentifier;
                NSString *playerName = score.player.displayName;
                NSInteger scroeNumb = score.value;
                NSInteger rank = score.rank;
                NSLog(@"排行榜 = %@，玩家名字 = %@，玩家分数 = %zd，玩家排名 = %zd",gamecenterID,playerName,scroeNumb,rank);
                [userInfo appendString:[NSString stringWithFormat:@"玩家名字 = %@，玩家分数 = %zd，玩家排名 = %zd",playerName,scroeNumb,rank]];
                [userInfo appendString:@"\n"];
                rankBoardID = gamecenterID;
            }
            //弹框展示
//            [self popShowViewWithTitileName:[NSString stringWithFormat:@"%@ 排行榜的信息",rankBoardID] andInfo:userInfo];
        }
    }];
}



- (void)getAllOnlineFriends {
    if ([GKLocalPlayer localPlayer].isAuthenticated == NO) {
        NSLog(@"没有授权，无法获取好友信息");
        return;
    }
    [[GKLocalPlayer localPlayer] loadFriendPlayersWithCompletionHandler:^(NSArray<GKPlayer *> * _Nullable friendPlayers, NSError * _Nullable error) {
        //定义一个可变字符串存放用户信息
        NSMutableString *userInfo = [NSMutableString string];
        
        for (GKPlayer *player in friendPlayers) {
            NSString *name = player.displayName;
            NSString *al = player.alias;
            //NSString *ID = player.guestIdentifier;
            NSString *ID = @"";
            [userInfo appendString:[NSString stringWithFormat:@"好友名字 = %@，nickName = %@%@",name,al,ID]];
            [userInfo appendString:@"\n"];
        }
//        [self popShowViewWithTitileName:@"好友信息" andInfo:userInfo];
    }];
}
@end
