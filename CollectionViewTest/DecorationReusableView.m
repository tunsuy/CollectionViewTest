//
//  DecorationReusableView.m
//  CollectionViewTest
//
//  Created by tunsuy on 18/4/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "DecorationReusableView.h"

@implementation DecorationReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CALayer *layer = [CALayer layer];
        NSString *imageFile = [[NSBundle mainBundle] pathForResource:@"IMG2" ofType:@"jpg"];
        NSData *imageData = [NSData dataWithContentsOfFile:imageFile];
        layer.contents = imageData;
        [self.layer addSublayer:layer];
    }
    return self;
}

@end
