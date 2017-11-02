//
//  VoiceRecordContentView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "VoiceRecordContentView.h"
#import "VoiceRecordPowerAnimationView.h"

@implementation VoiceRecordContentView
@end

#pragma mark- 正在录制显示的View
@interface VoiceRecordingView ()

@property (nonatomic, strong) UIImageView *imgVRecord;
@property (nonatomic, strong) UILabel *lblContent;
@property (nonatomic, strong) VoiceRecordPowerAnimationView *powerView;

@end

@implementation VoiceRecordingView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}

#pragma mark- UI
- (void)viewConfig {
    
    if (_lblContent == nil) {
        _lblContent = [[UILabel alloc] initWithFrame:CGRectZero];
        _lblContent.backgroundColor = [UIColor clearColor];
        _lblContent.text = @"Slide up to cancel";
        _lblContent.textColor = [UIColor whiteColor];
        _lblContent.textAlignment = NSTextAlignmentCenter;
        _lblContent.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:_lblContent];
    }
    if (_imgVRecord == nil) {
        _imgVRecord = [[UIImageView alloc] init];
        _imgVRecord.backgroundColor = [UIColor clearColor];
        _imgVRecord.image = [UIImage imageNamed:@"ic_record"];
        [self addSubview:_imgVRecord];
    }
    if (_powerView == nil) {
        _powerView = [[VoiceRecordPowerAnimationView alloc] init];
        _powerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_powerView];
    }
    
    [_powerView updateWithPower:0];
}

#pragma mark- Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lblContentHeight = 26.0;
    _lblContent.frame = CGRectMake(0, self.bounds.size.width - lblContentHeight - 5, self.bounds.size.width, lblContentHeight);
    
    _imgVRecord.frame = CGRectMake(0, 0, _imgVRecord.image.size.width, _imgVRecord.image.size.height);
    _imgVRecord.center = CGPointMake(self.bounds.size.width * 0.5 - 15, self.bounds.size.height * 0.5);
    
    _powerView.frame = CGRectMake(CGRectGetMaxX(_imgVRecord.frame) + 10, CGRectGetMaxY(_imgVRecord.frame) - 55, 18, 55);

}

#pragma mark- Public
- (void)updateWithPower:(float)power {
    [_powerView updateWithPower:power];
}

@end


#pragma mark- 显示 取消 的View
@interface VoiceRecordReleaseToCancelView()
/// 撤销的图片
@property (nonatomic, strong) UIImageView *imgVRecord;
/// 撤销的文字
@property (nonatomic, strong) UILabel *lblContent;
@end

@implementation VoiceRecordReleaseToCancelView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}

#pragma mark- UI
- (void)viewConfig {
    
    if (_lblContent == nil) {
        _lblContent = [[UILabel alloc] initWithFrame:CGRectZero];
        _lblContent.backgroundColor = [UIColor redColor];
        _lblContent.text = @"Release to cancel";
        _lblContent.textColor = [UIColor whiteColor];
        _lblContent.textAlignment = NSTextAlignmentCenter;
        _lblContent.font = [UIFont boldSystemFontOfSize:14];
        _lblContent.layer.cornerRadius = 2;
        _lblContent.clipsToBounds = YES;
        [self addSubview:_lblContent];
    }
    
    if (_imgVRecord == nil) {
        _imgVRecord = [[UIImageView alloc] init];
        _imgVRecord.backgroundColor = [UIColor clearColor];
        _imgVRecord.image = [UIImage imageNamed:@"RecordCancel"];
        [self addSubview:_imgVRecord];
    }
}

#pragma mark- Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lblContentHeight = 26.0;
    _lblContent.frame = CGRectMake(0, self.bounds.size.width - lblContentHeight, self.bounds.size.width, lblContentHeight);
    
    _imgVRecord.frame = CGRectMake(0, 0, _imgVRecord.image.size.width, _imgVRecord.image.size.height);
    _imgVRecord.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

@end

#pragma mark- 倒计时用的View
@interface VoiceRecordCountingView ()
/// 倒计时内容
@property (nonatomic, strong) UILabel *lblContent;
/// 倒计时的个数显示
@property (nonatomic, strong) UILabel *lblRemainTime;
@end

@implementation VoiceRecordCountingView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}

#pragma mark- UI
- (void)viewConfig {
    
    if (_lblContent == nil) {
        _lblContent = [[UILabel alloc] initWithFrame:CGRectZero];
        _lblContent.backgroundColor = [UIColor redColor];
        _lblContent.text = @"Release to cancel";
        _lblContent.textColor = [UIColor whiteColor];
        _lblContent.textAlignment = NSTextAlignmentCenter;
        _lblContent.font = [UIFont boldSystemFontOfSize:14];
        _lblContent.layer.cornerRadius = 2;
        _lblContent.clipsToBounds = YES;
        [self addSubview:_lblContent];
    }
    
    if (_lblRemainTime == nil) {
        _lblRemainTime = [[UILabel alloc] init];
        _lblRemainTime.backgroundColor = [UIColor clearColor];
        _lblRemainTime.font = [UIFont boldSystemFontOfSize:80];
        _lblRemainTime.textColor = [UIColor whiteColor];
        _lblRemainTime.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lblRemainTime];
    }
}

#pragma mark- Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lblContentHeight = 26.0;
    _lblContent.frame = CGRectMake(0, self.bounds.size.width - lblContentHeight, self.bounds.size.width, lblContentHeight);
    
    _lblRemainTime.frame = CGRectMake(0, 0, self.bounds.size.width, 80);
    _lblRemainTime.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

#pragma mark- Public
- (void)updateWithRemainTime:(float)remainTime {
    _lblRemainTime.text = [NSString stringWithFormat:@"%d",(int)remainTime];
}

@end

#pragma mark- 提示错误的View 录制时间太短
@interface VoiceRecordTipView ()
/// 图片
@property (nonatomic, strong) UIImageView *imgVIcon;
/// 文字
@property (nonatomic, strong) UILabel *lblContent;
@end

@implementation VoiceRecordTipView
#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}

#pragma mark- UI
- (void)viewConfig {
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    self.layer.cornerRadius = 6;
    
    if (_lblContent == nil) {
        _lblContent = [[UILabel alloc] initWithFrame:self.bounds];
        _lblContent.backgroundColor = [UIColor clearColor];
        _lblContent.textColor = [UIColor whiteColor];
        _lblContent.textAlignment = NSTextAlignmentCenter;
        _lblContent.font = [UIFont systemFontOfSize:14];
        _lblContent.text = @"Message Too Short";
        [self addSubview:_lblContent];
    }
    
    if (_imgVIcon == nil) {
        _imgVIcon = [UIImageView new];
        _imgVIcon.backgroundColor = [UIColor clearColor];
        _imgVIcon.image = [UIImage imageNamed:@"ic_record_too_short"];
        [self addSubview:_imgVIcon];
    }
}

#pragma mark- Layout
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lblContentHeight = 26.0;
    _lblContent.frame = CGRectMake(0, self.bounds.size.width - lblContentHeight, self.bounds.size.width, lblContentHeight);
    
    _imgVIcon.frame = CGRectMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5, _imgVIcon.image.size.width, _imgVIcon.image.size.height);
}

#pragma mark- Public
- (void)showWithMessage:(NSString *)ms {
    _lblContent.text = ms;
}

@end
