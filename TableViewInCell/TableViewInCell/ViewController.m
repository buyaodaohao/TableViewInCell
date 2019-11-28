//
//  ViewController.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/14.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import "ViewController.h"
#import "InnerTableFixedViewController.h"
#import "InnerTableCanScrollViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *naviBar = [self createTopNaviBarWithTitle:@"示例"];
    [self.view addSubview:naviBar];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, naviBar.frame.origin.y + naviBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - SafeAreaBottomHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}
#pragma mark----导航栏
-(UIView *)createTopNaviBarWithTitle:(NSString *)title
{
    UIView *naviBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    UIColor *naviColor = [UIColor colorWithRed:(CGFloat)84/255 green:(CGFloat)184/255 blue:(CGFloat)240/255 alpha:1.0];
    naviBar.backgroundColor = naviColor;
    if(title.length)
    {
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40.0 - 40.0, 132.0 / 3.0)];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment =  NSTextAlignmentCenter;
        [titleLabel setCenter:CGPointMake(naviBar.center.x, naviBar.center.y + SCREEN_Y / 2.0)];
        [naviBar addSubview:titleLabel];
        titleLabel.hidden = NO;
        titleLabel.text = title;
    }else{
        
    }
    return naviBar;
}
#pragma mark <UITableViewDelegate,UITableViewDataSource>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row)
    {
        case 0:
            {
                cell.textLabel.text = @"嵌套的tableView高度固定，内容可以滚动";
            }
            break;
        case 1:
        {
            cell.textLabel.text = @"嵌套的tableView高度不定，不可以滚动";
        }
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row)
    {
        case 0:
        {
            InnerTableCanScrollViewController *innerTableCanScrollVC = [InnerTableCanScrollViewController new];
            [self presentViewController:innerTableCanScrollVC animated:YES completion:nil];
        }
            break;
        case 1:
        {
            InnerTableFixedViewController *innerTableFixedVC = [InnerTableFixedViewController new];
            [self presentViewController:innerTableFixedVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
