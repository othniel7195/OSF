//
//  OSFWebViewWithComment.m
//  OSF
//
//  Created by 赵锋 on 15/7/23.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFWebViewWithComment.h"
#import "SKTagView.h"
#import "OLog.h"
#import "OSFHtmlParse.h"
#import "OColors.h"
#import "OLog.h"
@interface OSFWebViewWithComment ()<UIWebViewDelegate>

@property(nonatomic, strong)UIWebView *detailWebView;
@property(nonatomic, strong)UIButton *commentBtn;
@property(nonatomic, strong)SKTagView *tagView;
@property(nonatomic, strong)MASConstraint *webHeight;
@end

@implementation OSFWebViewWithComment

-(instancetype)initWithFrame:(CGRect)frame hasTags:(BOOL)hasTags
{
    self=[super initWithFrame:frame];
    if (self) {
        
        _hasTags=hasTags;
        self.backgroundColor=[UIColor whiteColor];
        if (_hasTags) {
            [self addSubview:self.tagView];
        }
        [self addSubview:self.commentBtn];
    
        
    }
    return self;
}

-(void)updateConstraints
{
    
    [self.detailWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.width.mas_equalTo(self.bounds.size.width);
        make.centerX.mas_equalTo(self);
        self.webHeight = make.height.mas_equalTo(1);
    }];
    
    if (self.hasTags) {
        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailWebView.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        [self.commentBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tagView.mas_bottom).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
    }
    else{
        [self.commentBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.detailWebView.mas_bottom).offset(10);
            make.right.mas_equalTo(self).offset(-10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self).offset(-10);
        }];
        
    }

 
    [super updateConstraints];
}


-(UIWebView *)detailWebView
{
    if (_detailWebView==nil) {
        
        UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, 1)];
        webView.delegate=self;
        webView.opaque = NO;
        webView.multipleTouchEnabled = NO;
        webView.backgroundColor=[UIColor yellowColor];
        webView.scrollView.bounces=NO;
        webView.scalesPageToFit=NO;
        webView.contentMode=UIViewContentModeCenter;
        webView.scrollView.showsHorizontalScrollIndicator=NO;
        webView.scrollView.showsVerticalScrollIndicator=NO;
        
        _detailWebView=webView;
        [self addSubview:_detailWebView];
        [_detailWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
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

-(SKTagView *)tagView
{
    if (!_tagView) {
        SKTagView *tv=[[SKTagView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width-20, 20)];
        tv.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-20;
        tv.padding= UIEdgeInsetsMake(2, 2, 2, 2);
        tv.insets= 5;
        tv.lineSpace= 5;
        _tagView=tv;
    }
    
    return _tagView;
}
-(void)setHtmlString:(NSString *)htmlString
{
    _htmlString=htmlString;
    
    [self.detailWebView loadHTMLString:[[OSFHtmlParse sharedHtmlParse] formatHTMLFromMarkdown:_htmlString] baseURL:[[NSBundle mainBundle] bundleURL]];
    
}
#pragma mark -- tags
-(CGFloat)calulateHeightWithTags:(NSArray *)tags
{
    return 100.0;
}

#pragma mark -- webView delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
  
}

#pragma mark -- action
-(void)commentDone
{
    
}

-(void)setTags:(NSArray *)tags
{
    if (_tags!=tags) {
        _tags=tags;
        
        [self.tagView removeAllTags];
        [OLog showMessage:@"web comment  -- %@",_tags];
        [_tags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SKTag *tag = [SKTag tagWithText:obj];
            tag.textColor = [UIColor whiteColor];
            tag.fontSize = 12;
            tag.padding = UIEdgeInsetsMake(2, 2, 2, 2);
            tag.bgColor = [OColors OSFRandomColor];
            tag.cornerRadius = 4;
            tag.enable = YES;
            
            [self.tagView addTag:tag];
        }];
    }
}

#pragma mark --kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    UIScrollView *sv=object;
    
    [OLog showMessage:@"newSize:%@ ",NSStringFromCGSize(sv.contentSize)];
    self.webHeight.mas_equalTo(sv.contentSize.height);
    
}
-(void)dealloc
{
    [self.detailWebView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

@end
