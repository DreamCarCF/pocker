//
//  CFVCommonBottomView.m
//  WindAndCloud
//
//  Created by cfv on 2019/4/17.
//  Copyright © 2019 SpeedUp. All rights reserved.
//

#import "CFVCommonBottomView.h"

@implementation CFVCommonBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [CFVCommonBottomView viewFromNibNamed:@"CFVCommonBottomView" owner:self];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.fireTimeLabel.clipsToBounds = YES;
    self.remainNumLabel.clipsToBounds = YES;
    self.integralNumLabel.clipsToBounds = YES;
    
    self.fireTimeLabel.layer.borderWidth = 0.5;
    self.remainNumLabel.layer.borderWidth = 0.5;
    self.integralNumLabel.layer.borderWidth = 0.5;
    
    self.fireTimeLabel.layer.borderColor = [UIColor colorWithWhite:1 alpha:0].CGColor;
    self.integralNumLabel.layer.borderColor = [UIColor colorWithWhite:1 alpha:0].CGColor;
    self.remainNumLabel.layer.borderColor = [UIColor colorWithWhite:1 alpha:0].CGColor;
    
    self.fireTimeLabel.layer.cornerRadius = 10;
    self.remainNumLabel.layer.cornerRadius = 10;
    self.integralNumLabel.layer.cornerRadius = 10;
    
    
    self.integralNumLabel.text = @"0000";
    self.remainNumLabel.text = @"52";
}




@end
