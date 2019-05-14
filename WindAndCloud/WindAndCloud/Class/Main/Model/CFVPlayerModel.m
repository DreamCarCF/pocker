//
//  CFVPlayerModel.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/20.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVPlayerModel.h"

@implementation CFVPlayerModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pockerBoxModel = [[CFVBoxPockerModel alloc]init];
       
    }
    return self;
}
@end
