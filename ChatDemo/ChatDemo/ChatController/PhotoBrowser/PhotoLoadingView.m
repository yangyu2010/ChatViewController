//
//  PhotoLoadingView.m
//  GetFriends
//
//  Created by Yu Yang on 2017/8/28.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "PhotoLoadingView.h"

@implementation PhotoLoadingView

#pragma mark- Init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.progress = 0.0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.progress = 0.0;
    }
    return self;
}

#pragma mark- Set
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    
    [self setNeedsDisplay];
}



#pragma mark- Draw
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 3;
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = (2 * M_PI) * self.progress + startAngle;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path addLineToPoint:center];
    [path closePath];
    
    [[UIColor whiteColor] setFill];
    
    [path fill];
}


@end
