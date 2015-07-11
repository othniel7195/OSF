//
//  OSFLeftViewController.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFLeftViewController.h"
#import "OSFBaseRightViewController.h"
#import "OSFBaseNavigationController.h"
#import "OSFCellCollection.h"
#import "OColors.h"
#import "OSFQuestions.h"
#import "OSFArticles.h"
#import "OSFFinds.h"
#import "OSFUser.h"
typedef NS_ENUM(NSInteger, OSFViewControllerType)
{
    UserAccount,
    Questions,
    Article,
    Find,
};

@interface OSFLeftViewController ()

@property(nonatomic, assign) NSInteger previousRow;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *userHeadUrl;

@property(nonatomic, strong) NSArray *datas;

@property(nonatomic, strong) NSMutableDictionary *cellHeights;

@end

@implementation OSFLeftViewController

-(instancetype)initWithUserName:(NSString *)userName userHeadUrl:(NSString *)userHeadUrl
{
    self=[super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        _userName = userName;
        _userHeadUrl = userHeadUrl;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.previousRow=1;
    
    self.view.backgroundColor=[OColors OSFNavBarColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.datas=@[@"头像",@"问题",@"文章",@"发现"];
    
    
    [self initRegisterCell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - status bar style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark -- 注册cell
- (void)initRegisterCell
{
    //注册用户头像cell
    [OSFCellCollection registerUserHeadCell:self.tableView];
    //注册标签cell
    [OSFCellCollection registerLabelCell:self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    [OLog showMessage:@"%d_",indexPath.row];
    switch (indexPath.row) {
        case UserAccount:
        {
            UIImage *image = [UIImage imageNamed:@"test"];
            cell  = [OSFCellCollection cellForUserHead:tableView indexPath:indexPath headImage:image userName:_userName];
            
        }
            break;
        case Questions:
        {
            UIImage *normalImage = [UIImage imageNamed:@"icon_tab_wenda"];
            UIImage *selectImage = [UIImage imageNamed:@"icon_tab_wenda_active"];
            NSString *labelInfo=self.datas[indexPath.row];
            cell = [OSFCellCollection cellForLabel:tableView indexPath:indexPath normalImage:normalImage selectImage:selectImage labelInfo:labelInfo];
            if (self.previousRow == indexPath.row) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:cellStatus object:@(indexPath.row)];
            }
        }
            break;
        case Article:
        {
            UIImage *normalImage = [UIImage imageNamed:@"icon_tab_qa"];
            UIImage *selectImage = [UIImage imageNamed:@"icon_tab_qa_active"];
            NSString *labelInfo=self.datas[indexPath.row];
            cell = [OSFCellCollection cellForLabel:tableView indexPath:indexPath normalImage:normalImage selectImage:selectImage labelInfo:labelInfo];
          
        }
            break;
        case Find:
        {
            UIImage *normalImage = [UIImage imageNamed:@"icon_tab_discover"];
            UIImage *selectImage = [UIImage imageNamed:@"icon_tab_discover_active"];
            NSString *labelInfo=self.datas[indexPath.row];
            cell = [OSFCellCollection cellForLabel:tableView indexPath:indexPath normalImage:normalImage selectImage:selectImage labelInfo:labelInfo];
           
        }
            break;
    }
    
    NSNumber *cellHeight=[cell valueForKey:@"cellHeight"];
    
    if (self.cellHeights==nil) {
        self.cellHeights=[NSMutableDictionary dictionary];
    }
    NSString *cellHeightKey=[NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
    [self.cellHeights setObject:cellHeight forKey:cellHeightKey];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellHeightKey=[NSString stringWithFormat:@"%ld_%ld",indexPath.section,indexPath.row];
    
    return [[self.cellHeights objectForKey:cellHeightKey] floatValue];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == self.previousRow) {
        
        [self.drawer close];
        
    }
    else {
        
        OSFBaseNavigationController *root=[[OSFBaseNavigationController alloc] initWithRootViewController:[self switchViewControllers:indexPath.row]];
        
        [self.drawer replaceCenterViewControllerWithViewController:root];
        
        if (indexPath.row!=UserAccount) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:cellStatus object:@(indexPath.row)];
            
        }
    }
    
    self.previousRow = indexPath.row;
    
}


#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

- (void)drawerControllerWillClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}


#pragma mark --- viewControllers change

-(OSFBaseViewController *)switchViewControllers:(NSInteger)tag
{
    OSFBaseViewController *base=nil;
    switch (tag) {
        case UserAccount:
        {
            OSFUser *user=[[OSFUser alloc] init];
            base=user;
        }
            break;
        case Questions:
        {
            OSFQuestions *questions=[[OSFQuestions alloc] init];
            base=questions;
        }
            break;
        case Article:
        {
            OSFArticles *article=[[OSFArticles alloc] init];
            base=article;
        }
            break;
        case Find:
        {
            OSFFinds *find=[[OSFFinds alloc] init];
            base=find;
        }
            break;
    }
    
    return base;
}

@end
