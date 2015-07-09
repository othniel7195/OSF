//
//  OSFNumFlagView.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFNumFlagView.h"
#import "OLog.h"
#import "OColors.h"

@interface OSFNumFlagView ()

@property(nonatomic, assign,readwrite) CGFloat radius;
@property(nonatomic, copy,readwrite) NSString * answerNum;
@property(nonatomic, assign,readwrite) NSInteger questionStatus;

@property(nonatomic, strong)UILabel *infoLabel;
///问题状态
@property(nonatomic, copy) NSString *questionStatusInfo;
///标签背景颜色
@property(nonatomic, strong)UIColor *flagBackgroundColor;


@end

@implementation OSFNumFlagView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[self initWithFrame:frame cornerRadius:2.0];
    if (self) {
        
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius
{
    self=[super initWithFrame:frame];
    if (self) {
        
        _radius=cornerRadius;
        [self addSubview:self.infoLabel];
        
        [self initConstraints];
    }
    
    return self;
}

-(void)numFlagAnswerNum:(NSString *)answerNum questionStatus:(NSInteger)questionStatus
{
    _answerNum=answerNum;
    _questionStatus=questionStatus;
    
    switch (_questionStatus) {
        case OSFQuestionNoAnswer:case OSFQuestionNoResolve:
        {
            self.questionStatusInfo=@"回答";
        }
            break;
        case OSFQuestionHasResolve:
        {
            self.questionStatusInfo=@"解决";
        }
            break;
    }
    
    self.flagBackgroundColor=[OColors OSFQuestionFlagBackgroundColo:_questionStatus];
    
    self.backgroundColor=self.flagBackgroundColor;
    
    
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=self.radius;
    NSString *info =[NSString stringWithFormat:@"%@\n%@",self.answerNum,self.questionStatusInfo];
    NSMutableAttributedString *attrs=[[NSMutableAttributedString alloc] initWithString:info];
    [attrs addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0] range:NSMakeRange(0, self.answerNum.length)];
    [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0] range:NSMakeRange(self.answerNum.length+1, self.questionStatusInfo.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0f;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attrs addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, info.length)];
    
    
    self.infoLabel.attributedText=attrs;
}

#pragma mark ---布局
-(void)initConstraints
{
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(2, 2, 2, 2));
    }];
}

#pragma mark --视图
-(UILabel *)infoLabel
{
    if (_infoLabel==nil) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor=[UIColor clearColor];
        label.numberOfLines=2;
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        
        _infoLabel=label;
    }
    return _infoLabel;
}



@end
