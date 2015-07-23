//
//  OSFWebViewWithComment.m
//  OSF
//
//  Created by 赵锋 on 15/7/23.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFWebViewWithComment.h"

@interface OSFWebViewWithComment ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *detailWebView;
@property(nonatomic, strong)UIButton *commentBtn;

@end

@implementation OSFWebViewWithComment

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.detailWebView];
        [self addSubview:self.commentBtn];
        [self initConstraints];
    }
    return self;
}

-(void)initConstraints
{
    
}


-(UIWebView *)detailWebView
{
    if (_detailWebView==nil) {
        
        UIWebView *webView=[[UIWebView alloc] init];
        [webView loadHTMLString:self.htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
        webView.delegate=self;
        webView.opaque=NO;
        
        
        
        _detailWebView=webView;
    }
    
    return _detailWebView;
}

-(UIButton *)commentBtn
{
    if (_commentBtn==nil) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:@"评论" forState:UIControlStateNormal];
        btn.backgroundColor=[UIColor lightGrayColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(commentDone) forControlEvents:UIControlEventTouchUpInside];
        
        
        _commentBtn=btn;
    }
    return _commentBtn;
}

#pragma mark -- webView delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

#pragma mark -- action
-(void)commentDone
{
    
}
@end
