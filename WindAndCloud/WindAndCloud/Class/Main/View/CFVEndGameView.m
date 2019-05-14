//
//  CFVEndGameView.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/25.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVEndGameView.h"

@implementation CFVEndGameView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [CFVEndGameView viewFromNibNamed:@"CFVEndGameView" owner:self];
    }
    return self;
}
@end
