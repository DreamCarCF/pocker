//
//  CFVIntergalView.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/25.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVIntergalView.h"

@implementation CFVIntergalView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [CFVIntergalView viewFromNibNamed:@"CFVIntergalView" owner:self];
    }
    return self;
}

@end
