//
//  InnerTableCanScrollViewController.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2019/11/28.
//  Copyright © 2019 云联智慧. All rights reserved.
//

#import "InnerTableCanScrollViewController.h"
#import "AnotherMainContentCell.h"
@interface InnerTableCanScrollViewController ()<PullListTableDelegate,UITableViewDelegate,UITableViewDataSource,AnotherMainContentCellDelegate>
@property(nonatomic,strong)PullListTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation InnerTableCanScrollViewController
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
    // Do any additional setup after loading the view.
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
    UIView *naviBar = [self createTopNaviBarWithTitle:@"列表"];
    [self.view addSubview:naviBar];
    self.tableView = [[PullListTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight- SafeAreaBottomHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.pullListDelegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView setupRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewCanNotScroll) name:@"CAN_NOT_SCROLL" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewCanScroll) name:@"CAN_SCROLL" object:nil];
}
-(void)setTableViewCanNotScroll
{
    self.tableView.scrollEnabled = NO;
}
-(void)setTableViewCanScroll
{
    self.tableView.scrollEnabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UIButton *backBottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_Y, 60, 44)];
    backBottomBtn.backgroundColor = [UIColor clearColor];
    [backBottomBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:backBottomBtn];
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(36.0 / 3.0,SCREEN_Y+ (44-66.0 / 3.0)/2, 66.0 / 3.0, 66.0 / 3.0)];
    [backButton setImage:[UIImage imageNamed:@"Right-icon"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [naviBar addSubview:backButton];
    return naviBar;
}
-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    AnotherMainContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; //出列可重用的cell
    if (cell == nil)
    {
        cell = [[AnotherMainContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
