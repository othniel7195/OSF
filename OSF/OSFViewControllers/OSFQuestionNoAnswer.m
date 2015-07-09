//
//  OSFQuestionNoAnswer.m
//  OSF
//
//  Created by 赵锋 on 15/7/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionNoAnswer.h"
#import "OSFCellCollection.h"
@interface OSFQuestionNoAnswer ()
@property(nonatomic,strong)NSMutableDictionary *cellHeights;
@end

@implementation OSFQuestionNoAnswer

- (void)viewDidLoad {
    [super viewDidLoad];
    [OSFCellCollection registerQuestionCell:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell=[OSFCellCollection cellForQuestion:tableView indexPath:indexPath answerNum:@"0" questionStatus:0 userName:@"未解答的" date:@"一天前" content:@"未解答的问题，我不知道如何打开keyboard得开关什么的 导致keyboard打不开，一片底色灰的"];
    
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
    return  [[self.cellHeights objectForKey:cellHeightKey] floatValue];
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

@end
