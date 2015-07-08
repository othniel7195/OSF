//
//  OSFQuestions.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestions.h"
#import "OSFQuestionLatest.h"
#import "Masonry.h"
#import "OColors.h"
@interface OSFQuestions ()
///问题--最新的
@property(nonatomic, strong) OSFQuestionLatest *questionLastest;
@property(nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation OSFQuestions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"问题";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.segmentedControl];
    [self addChildViewController:self.questionLastest];
    [self.view addSubview:self.questionLastest.view];
    
    
    [self layoutPageViews];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- 布局
-(void)layoutPageViews
{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(260, 40));
        make.top.mas_equalTo(5);
    }];
    
    [self.questionLastest.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.segmentedControl.mas_bottom).offset(10);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).offset(55);
    } ];
}

#pragma mark -- 视图
-(OSFQuestionLatest *)questionLastest
{
    if (_questionLastest==nil) {
        OSFQuestionLatest *lastest=[[OSFQuestionLatest alloc] initWithStyle:UITableViewStylePlain];
        
        _questionLastest = lastest;
    }
    
    return _questionLastest;
}

-(UISegmentedControl *)segmentedControl
{
    if (_segmentedControl==nil) {
        UISegmentedControl *segmented=[[UISegmentedControl alloc] initWithItems:@[@"最新的",@"热门的",@"未回答"]];
        [segmented addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
        segmented.selectedSegmentIndex=1;
        segmented.tintColor=[OColors OSFNavBarColor];
        
        _segmentedControl=segmented;
    }
    return _segmentedControl;
}

#pragma mark -- 控件 action
-(void)segmentedControlChange:(UISegmentedControl *)sender
{
    
}

#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFQuestions";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
}

@end
