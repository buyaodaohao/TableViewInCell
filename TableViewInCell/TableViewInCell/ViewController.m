//
//  ViewController.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/14.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<PullListTableDelegate,UITableViewDelegate,UITableViewDataSource,MainContentCellDelegate>
@property(nonatomic,strong)PullListTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController
-(NSMutableArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"json"];
    NSData *pathData = [[NSData alloc]initWithContentsOfFile:path];
    NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:pathData options:NSJSONReadingMutableContainers error:nil];
    for(int i = 0;i < tempArray.count;i++)
    {
        NSDictionary *itemDic = (NSDictionary *)tempArray[i];
        CommenModel *model = [CommenModel createCommenModelWithModelDic:itemDic];
        [self.dataArray addObject:model];
    }
    [self addTopNaviBarWithTitle:@"列表"];
    self.tableView = [[PullListTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight- SafeAreaBottomHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pullListDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView setupRefresh];
}
#pragma mark----导航栏
-(void)addTopNaviBarWithTitle:(NSString *)title
{
    UIView *naviBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    UIColor *naviColor = [UIColor colorWithRed:(CGFloat)29/255 green:(CGFloat)29/255 blue:(CGFloat)31/255 alpha:1.0];
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
    UIButton *backBottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_Y, 60, 44)];
    backBottomBtn.backgroundColor = [UIColor clearColor];
    [backBottomBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [naviBar addSubview:backBottomBtn];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(36.0 / 3.0,SCREEN_Y+ (44-66.0 / 3.0)/2, 66.0 / 3.0, 66.0 / 3.0)];
    [backButton setImage:[UIImage imageNamed:@"Right-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [naviBar addSubview:backButton];
    [self.view addSubview:naviBar];
}
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark PullListTableDelegate,UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommenModel *model = (CommenModel *)self.dataArray[indexPath.row];
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    MainContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; //出列可重用的cell
    if (cell == nil)
    {
        cell = [[MainContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.contentModel = model;
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommenModel *model = (CommenModel *)self.dataArray[indexPath.row];
    CGFloat subH = 0.0;
    subH = [MainContentCell getCommenListCellHeightFromModel:model];
    return subH;
}

-(void)getHeaderRereshed:(PullListTableView *)tableview
{
    [tableview endHeaderFresh];
}
-(void)getHeaderRereshing:(PullListTableView *)tableview
{
    
}
-(void)getFooterRereshing:(PullListTableView *)tableview
{
    
}
-(void)getFooterRereshed:(PullListTableView *)tableview
{
    [tableview endFooterFresh];
}
-(void)reloadCellHeightForModel:(CommenModel *)model tableViewHeight:(CGFloat)tableViewH atIndexPath:(NSIndexPath *)indexPath
{
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
    [self.tableView reloadData];
}
@end
