//
//  OSFSearchBarView.m
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFSearchBarView.h"
#import "OColors.h"
#import "UIImage+ImageWithColor.h"
@interface OSFSearchBarView ()<UISearchBarDelegate>

@property(nonatomic, strong)UISearchBar *searchBar;

@end

@implementation OSFSearchBarView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.7];
        
        [self addSubview:self.searchBar];
        
        [self initConstraints];
    }
    return self;
}


#pragma mark -- 布局
-(void)initConstraints
{
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, 40));
        make.top.mas_equalTo(0);
    }];
}

#pragma mark -- 视图

-(UISearchBar *)searchBar
{
    if (!_searchBar) {
        UISearchBar *search=[[UISearchBar alloc] initWithFrame:CGRectZero];
        search.delegate=self;
        search.searchBarStyle=UISearchBarStyleDefault;
        [search setBackgroundImage:[self searchBackgroundImage] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        _searchBar=search;
    }
    
    return _searchBar;
}

-(UIImage *)searchBackgroundImage
{
  return   [UIImage imageWithColor:[OColors OSFNavBarColor] size:CGSizeMake(self.bounds.size.width, 40)];
}

#pragma mark -- 属性赋值
-(void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder!=_placeholder) {
        _placeholder=placeholder;
        
        self.searchBar.placeholder=_placeholder;
    }
}

#pragma mark -- searchbar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

@end
