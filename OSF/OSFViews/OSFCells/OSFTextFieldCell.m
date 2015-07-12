//
//  OSFTextFieldCell.m
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFTextFieldCell.h"
#import "OSFTextFieldDelegate.h"
@interface OSFTextFieldCell ()<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *textField;

@end

@implementation OSFTextFieldCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.textField];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:nil];
        
        [self initConstraints];
    
    }
    return self;
}

#pragma mark -- 布局
-(void)initConstraints
{
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
}

#pragma mark -- 视图
-(UITextField *)textField
{
    if (!_textField) {
        UITextField *tf=[[UITextField alloc] initWithFrame:CGRectZero];
        tf.borderStyle=UITextBorderStyleNone;
        tf.returnKeyType=UIReturnKeyDone;
        tf.font=[UIFont systemFontOfSize:14.0];
        tf.delegate=self;
        
        _textField=tf;
    }
    return _textField;
}

#pragma mark --textfield notication
-(void)textFieldDidChange
{
    if ([self.delegate respondsToSelector:@selector(OSFTextFieldDidChange:tagString:)]) {
        [self.delegate OSFTextFieldDidChange:self.textField.text tagString:self.placeholder];
    }
}

#pragma mark -- textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return  [textField resignFirstResponder];
}

#pragma mark -- 属性赋值
-(void)setTextFieldType:(NSInteger)textFieldType
{
    _textFieldType=textFieldType;
    if (_textFieldType==1) {
        
        self.textField.secureTextEntry=NO;
        
    }else if (_textFieldType==2)
    {
        self.textField.secureTextEntry=YES;
    }
}
-(void)setReturnType:(NSInteger)returnType
{
    _returnType=returnType;
    if (_returnType==1) {
        self.textField.returnKeyType=UIReturnKeyDone;
    }else if(_returnType==2)
    {
        self.textField.returnKeyType=UIReturnKeyNext;
    }
}

-(void)setPlaceholder:(NSString *)placeholder
{
    if (placeholder!=_placeholder) {
        _placeholder=placeholder;
        self.textField.placeholder=_placeholder;
    }
}

#pragma mark --delloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
