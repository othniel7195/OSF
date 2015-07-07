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
typedef NS_ENUM(NSInteger, OSFViewControllerType)
{
    UserAccount,
    Questions
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
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.datas=@[@"头像",@"问题"];
    
    
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
    switch (indexPath.row) {
        case UserAccount:
        {
            UIImage *image = [UIImage imageNamed:@"test"];
            cell  = [OSFCellCollection cellForUserHead:tableView indexPath:indexPath headImage:image userName:_userName];
            
        }
            break;
        default:
        {
            UIImage *normalImage = [UIImage imageNamed:@"test"];
            NSString *labelInfo=self.datas[indexPath.row];
            cell = [OSFCellCollection cellForLabel:tableView indexPath:indexPath normalImage:normalImage selectImage:normalImage labelInfo:labelInfo];
            if (self.previousRow == indexPath.row) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:cellStatus object:@(indexPath.row)];
            }
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
           
        }
            break;
        case Questions:
        {
           
        }
            break;
    }
    
    return base;
}

@end
