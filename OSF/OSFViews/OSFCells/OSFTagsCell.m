//
//  OSFTagsCell.m
//  OSF
//
//  Created by 赵锋 on 15/7/11.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFTagsCell.h"
#import "SKTagView.h"
#import "OColors.h"
@interface OSFTagsCell ()
@property(nonatomic, strong)SKTagView *tagView;
@end

@implementation OSFTagsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.tagView];
        
        [self initConstraints];
    }
    return self;
}

#pragma mark --布局

-(void)initConstraints
{
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.contentView);
    }];
}

#pragma  makr -- 视图
-(SKTagView *)tagView
{
    if (!_tagView) {
        SKTagView *tv=[[SKTagView alloc] initWithFrame:CGRectZero];
        tv.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width;
        tv.padding= UIEdgeInsetsMake(12, 12, 12, 12);
        tv.insets= 15;
        tv.lineSpace= 10;
        __weak OSFTagsCell *WEAKSELF = self;
        tv.didClickTagAtIndex = ^(NSUInteger index)
        {
            [OLog showMessage:@"tag did touch"];
            if ([WEAKSELF.delegate respondsToSelector:@selector(tagDidSelect:tagIndex:)]) {
                [WEAKSELF.delegate tagDidSelect:WEAKSELF.path tagIndex:index];
            }
        };
        
        _tagView=tv;
    }
    
    return _tagView;
}

#pragma mark --属性赋值
-(void)setTags:(NSArray *)tags
{
    if (tags!=_tags) {
        _tags=tags;
        
        [self.tagView removeAllTags];
        
        [_tags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            SKTag *tag = [SKTag tagWithText:obj];
            tag.textColor = [UIColor whiteColor];
            tag.fontSize = 15;
            tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
            tag.bgColor = [OColors OSFRandomColor];
            tag.cornerRadius = 5;
            tag.enable = YES;
            
            [self.tagView addTag:tag];
        }];
    }
}

#pragma mark ---cell高度
-(CGFloat)calulateHeightWithTags:(NSArray *)tags
{
    self.tags=tags;
    
    [self.tagView removeAllTags];
    
    [tags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        SKTag *tag = [SKTag tagWithText:obj];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize = 15;
        tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        tag.bgColor = [OColors OSFRandomColor];
        tag.cornerRadius = 5;
        tag.enable = YES;
        
        [self.tagView addTag:tag];
    }];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
    return size.height+1.0;

}
@end
