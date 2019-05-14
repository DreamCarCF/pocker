//
//  ViewController.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "ViewController.h"
#import "GameLoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(jumpToWelocmeVC) withObject:nil afterDelay:3];
}


- (void)jumpToWelocmeVC {
    GameLoginViewController *gameLoginVC = [[GameLoginViewController alloc]initWithNibName:@"GameLoginViewController" bundle:nil];
    UINavigationController *rootNav = [[UINavigationController alloc]initWithRootViewController:gameLoginVC];
    [self presentViewController:rootNav animated:YES completion:nil];
    
}
@end
