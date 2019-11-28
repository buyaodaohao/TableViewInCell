//
//  AnotherMainContentCell.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2019/11/28.
//  Copyright © 2019 云联智慧. All rights reserved.
//

#import "AnotherMainContentCell.h"
/** 设置嵌套的tableView的固定高度*/
#define TABLEVIEW_IN_CELL_H 100.0
@interface AnotherMainContentCell ()<UITableViewDataSource, UITableViewDelegate>
/**头像*/
@property(nonatomic,strong)UIButton *headIconButton;
/**姓名*/
@property(nonatomic,strong)UIButton *nameButton;
/**闹钟图标*/
@property(nonatomic,strong)UIImageView *timeIconImageView;
/**时间显示*/
@property(nonatomic,strong)UILabel *timeLabel;
/**内容*/
@property(nonatomic,strong)UILabel *contentLabel;
/**下方意见栏底部背景*/
@property(nonatomic,strong)UIImageView *backgroundImageView;
/**意见栏，第一条意见发表者的头像*/
@property(nonatomic,strong)UIButton *opinionHeadIconButton;
/**意见栏，第一条意见发表者的姓名*/
@property(nonatomic,strong)UIButton *opinionNameButton;
/**意见栏，第一条意见附件图标*/
@property(nonatomic,strong)UIButton *opinionAttachmentButton;
/**意见栏，第一条意见中闹钟图标*/
@property(nonatomic,strong)UIImageView *opinionTimeIconImageView;
/**意见栏，第一条意见中显示时间的label*/
@property(nonatomic,strong)UILabel *opinionTimeLabel;
/**意见栏，第一条意见内容*/
@property(nonatomic,strong)UILabel *opinionContentLabel;
/**意见栏，展开剩余意见按钮*/
@property(nonatomic,strong)UIButton *unfoldButton;
/**下方盛装关注、意见、发送三个按钮的UIView*/
@property(nonatomic,strong)UIView *bottomActionView;
/**关注*/
@property(nonatomic,strong)UIButton *attentionButton;
/**意见*/
@property(nonatomic,strong)UIButton *opinionButton;
/**发送*/
@property(nonatomic,strong)UIButton *sendButton;
/**cell之间的分割域*/
@property(nonatomic,strong)UIView *separationView;
/**显示意见的tableView*/
@property(nonatomic,strong)UITableView *tableView;
/**存放意见模型的数组，元素类型为OpinionModel*/
@property(nonatomic,strong)NSMutableArray *opinionsArray;

@end
@implementation AnotherMainContentCell

-(NSMutableArray *)opinionsArray
{
    if(!_opinionsArray)
    {
        _opinionsArray = [NSMutableArray array];
    }
    return _opinionsArray;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /**头像*/
        _headIconButton = [[UIButton alloc]init];
        [self.contentView addSubview:_headIconButton];
        /**姓名*/
        _nameButton = [[UIButton alloc]init];
        [self.contentView addSubview:_nameButton];
        /**闹钟图标*/
        _timeIconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_timeIconImageView];
        /**时间显示*/
        _timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_timeLabel];
        /**内容*/
        _contentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_contentLabel];
        /**下方意见栏底部背景*/
        _backgroundImageView = [[UIImageView alloc]init];
        _backgroundImageView.hidden = YES;
        [self.contentView addSubview:_backgroundImageView];
        /**意见栏，第一条意见发表者的头像*/
        _opinionHeadIconButton = [[UIButton alloc]init];
        [_backgroundImageView addSubview:_opinionHeadIconButton];
        /**意见栏，第一条意见发表者的姓名*/
        _opinionNameButton = [[UIButton alloc]init];
        [_backgroundImageView addSubview:_opinionNameButton];
        /**意见栏，第一条意见附件图标*/
        _opinionAttachmentButton = [[UIButton alloc]init];
        [_backgroundImageView addSubview:_opinionAttachmentButton];
        /**意见栏，第一条意见中闹钟图标*/
        _opinionTimeIconImageView = [[UIImageView alloc]init];
        [_backgroundImageView addSubview:_opinionTimeIconImageView];
        /**意见栏，第一条意见中显示时间的label*/
        _opinionTimeLabel = [[UILabel alloc]init];
        [_backgroundImageView addSubview:_opinionTimeLabel];
        /**意见栏，第一条意见内容*/
        _opinionContentLabel = [[UILabel alloc]init];
        [_backgroundImageView addSubview:_opinionContentLabel];
        /**展开剩余意见按钮*/
        _unfoldButton = [[UIButton alloc]init];
        [_backgroundImageView addSubview:_unfoldButton];
        /**下方盛装关注、意见、发送三个按钮的UIView*/
        _bottomActionView = [[UIView alloc]init];
        [self.contentView addSubview:_bottomActionView];
        /**关注*/
        _attentionButton = [[UIButton alloc]init];
        [_bottomActionView addSubview:_attentionButton];
        /**意见*/
        _opinionButton = [[UIButton alloc]init];
        [_bottomActionView addSubview:_opinionButton];
        /**发送*/
        _sendButton = [[UIButton alloc]init];
        [_bottomActionView addSubview:_sendButton];
        /**cell之间的分割域*/
        _separationView = [[UIView alloc]init];
        [self.contentView addSubview:_separationView];
        /**显示意见的tableView*/
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        
        //        _tableView.scrollEnabled = NO;
        _tableView.hidden = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[OpinionCell class] forCellReuseIdentifier:@"OpinionCell"];
        [_backgroundImageView addSubview:_tableView];
    }
    return self;
}
+(CGFloat)getCommenListCellHeightFromModel:(CommenModel *)model
{
    CGFloat subH = 0.0;
    
    NSString *contentBrief = model.itemsContent;
    CGSize contentSize = [contentBrief boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - (68.0 + 57.0) / 3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size;
    
    subH = contentSize.height;
    subH = (39.0 + 36.0 + 102.0) / 3.0 + subH;
    
    if(model.countComment >= 1)
    {
        OpinionModel *opinionModel = [OpinionModel createOpinionModelFromDic:model.comment];
        
        
        NSString *opinionContentStr = opinionModel.itemsContent;
        CGSize opinionContentSize = [opinionContentStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 54.0 / 3.0 - 45.0 / 3.0 - 96.0 / 3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:45.0 / 3.0]} context:nil].size;
        subH = 18.0 / 3.0 + (27.0 + 27.0 + 102.0 + 24.0) / 3.0 + opinionContentSize.height + subH;
        if(model.countComment == 1)//不用显示  展开剩余意见按钮。
        {
            subH = 27.0 / 3.0 + (114.0 + 39.0 + 36.0) / 3.0 + subH;
        }
        else//显示  展开剩余意见按钮
        {
            subH = 33.0 / 3.0 + 114.0 / 3.0 + 38.0 / 3.0 + (114.0 + 39.0 + 36.0) / 3.0 + subH;
            if(model.showChildTableView)
            {
                subH = subH + model.childTableViewHeight + 33.0 / 3.0 + 36.0 / 3.0;
            }
        }
    }
    else
    {
        subH = (114.0 + 39.0 + 36.0) / 3.0 + subH;
    }
    return subH;
}
-(void)layoutSubviews
{
    NSString *nameStr = _contentModel.name;
    
    /**头像*/
    UIImage *placeholderImage =[UIImage imageNamed:@"user-default-icon"];
    
    [_headIconButton setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_contentModel.itemsContent] placeholderImage:placeholderImage];
    
    _headIconButton.frame = CGRectMake(65.0 / 3.0, 39.0 / 3.0, 102.0 / 3.0, 102.0 / 3.0);
    _headIconButton.layer.cornerRadius = 102.0 / 2.0 / 3.0;
    _headIconButton.layer.masksToBounds = YES;
    
    
    CGSize nameSize = [nameStr boundingRectWithSize:CGSizeMake(300, 48.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size;
    _nameButton.frame = CGRectMake(_headIconButton.frame.origin.x + _headIconButton.frame.size.width + 33.0 / 3.0, 66.0 / 3.0, nameSize.width, 48.0 / 3.0);
    _nameButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_nameButton setTitle:nameStr forState:UIControlStateNormal];
    [_nameButton setTitleColor:[UIColor colorWithRed:(CGFloat)51/255 green:(CGFloat)51/255 blue:(CGFloat)51/255 alpha:1.0] forState:UIControlStateNormal];
    NSString *timeStr = _contentModel.time;
    
    CGSize timeSize = [timeStr boundingRectWithSize:CGSizeMake(300, 27.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:27.0 / 3.0]} context:nil].size;
    _timeLabel.frame = CGRectMake(self.frame.size.width - 16 - timeSize.width, (75 / 2.0 + 39.0) / 3.0, timeSize.width, 27.0 / 3.0);
    _timeLabel.font = [UIFont systemFontOfSize:9.0];
    _timeLabel.textColor = [UIColor colorWithRed:(CGFloat)153 / 255 green:(CGFloat)153 / 255 blue:(CGFloat)153 / 255 alpha:1.0];
    _timeLabel.text = timeStr;
    
    _timeIconImageView.frame = CGRectMake(_timeLabel.frame.origin.x - 24.0 / 3.0 - 33.0 / 3.0, _timeLabel.frame.origin.y - 1, 33.0 / 3.0, 33.0 / 3.0);
    _timeIconImageView.image = [UIImage imageNamed:@"clock"];
    _timeIconImageView.layer.cornerRadius = 33.0 / 2.0 / 3.0;
    _timeIconImageView.layer.masksToBounds = YES;
    
    NSString *contentBrief = _contentModel.itemsContent;
    CGSize contentSize = [contentBrief boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - (68.0 + 57.0) / 3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size;
    _contentLabel.frame = CGRectMake(68.0 / 3.0, _headIconButton.frame.origin.y + _headIconButton.frame.size.height + 36.0 / 3.0, [UIScreen mainScreen].bounds.size.width - (68.0 + 57.0) / 3.0, contentSize.height);
    _contentLabel.numberOfLines = 0;
    
    _contentLabel.font = [UIFont systemFontOfSize:16.0];
    _contentLabel.text = contentBrief;
    _contentLabel.textColor = [UIColor colorWithRed:(CGFloat)51/255 green:(CGFloat)51/255 blue:(CGFloat)51/255 alpha:1.0];
    _contentLabel.userInteractionEnabled = YES;
    
    if(_contentModel.countComment >= 1)
    {
        _backgroundImageView.hidden = NO;
        _backgroundImageView.userInteractionEnabled = YES;
        OpinionModel *opinionModel = [OpinionModel createOpinionModelFromDic:_contentModel.comment];
        _opinionHeadIconButton.frame = CGRectMake(54.0 / 3.0, 27.0 / 3.0 + 27.0 / 3.0, 102.0 / 3.0, 102.0 / 3.0);
        
        UIImage *placeholderImage =[UIImage imageNamed:@"user-default-icon"];
        
        [_opinionHeadIconButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:opinionModel.userIcon] placeholderImage:placeholderImage];
        _opinionHeadIconButton.layer.cornerRadius = 102.0 /2.0 / 3.0;
        _opinionHeadIconButton.layer.masksToBounds = YES;
        
        NSString *nameStr = opinionModel.name;
        CGSize nameSize = [nameStr boundingRectWithSize:CGSizeMake(300, 48.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size;
        _opinionNameButton.frame = CGRectMake(_opinionHeadIconButton.frame.origin.x + _opinionHeadIconButton.frame.size.width + 33.0 / 3.0, 54.0 / 3.0 + 27.0 / 3.0, nameSize.width, 48.0 / 3.0);
        _opinionNameButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_opinionNameButton setTitle:nameStr forState:UIControlStateNormal];
        [_opinionNameButton setTitleColor:[UIColor colorWithRed:(CGFloat)51/255 green:(CGFloat)51/255 blue:(CGFloat)51/255 alpha:1.0] forState:UIControlStateNormal];
        
        
        _opinionAttachmentButton.frame = CGRectMake(_opinionNameButton.frame.origin.x + _opinionNameButton.frame.size.width + 35.0 / 3.0, 51.0 / 3.0 + 27.0 / 3.0, 54.0 / 3.0, 54.0 / 3.0);
        
        _opinionAttachmentButton.layer.cornerRadius = 54.0 / 2.0 / 3.0;
        _opinionAttachmentButton.layer.masksToBounds = YES;
        
        NSString *timeStr = opinionModel.time;
        /**文件 时间全部按照返回的字符串
         
         timeStr = [TimeHelp formatShowDateTime:timeStr];*/
        CGSize timeSize = [timeStr boundingRectWithSize:CGSizeMake(300, 27.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:9.0]} context:nil].size;
        
        _opinionTimeLabel.frame = CGRectMake(self.frame.size.width - 48.0 / 3.0 - timeSize.width - 96.0 / 3.0, (75 / 2.0 + 27.0) / 3.0 + 27.0 / 3.0, timeSize.width, 27.0 / 3.0);
        _opinionTimeLabel.font = [UIFont systemFontOfSize:9.0];
        _opinionTimeLabel.textColor = [UIColor colorWithRed:(CGFloat)153 / 255 green:(CGFloat)153 / 255 blue:(CGFloat)153 / 255 alpha:1.0];
        _opinionTimeLabel.text = timeStr;
        
        _opinionTimeIconImageView.frame = CGRectMake(_opinionTimeLabel.frame.origin.x - 24.0 / 3.0 - 33.0 / 3.0, _opinionTimeLabel.frame.origin.y - 1, 33.0 / 3.0, 33.0 / 3.0);
        _opinionTimeIconImageView.image = [UIImage imageNamed:@"clock"];
        _opinionTimeIconImageView.layer.cornerRadius = 33.0 / 2.0 / 3.0;
        _opinionTimeIconImageView.layer.masksToBounds = YES;
        CGFloat nextY = _opinionHeadIconButton.frame.origin.y + _opinionHeadIconButton.frame.size.height + 24.0 / 3.0;
        
        NSString *opinionContentStr = opinionModel.itemsContent;
        CGSize opinionContentSize = [opinionContentStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 54.0 / 3.0 - 45.0 / 3.0 - 96.0 / 3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0]} context:nil].size;
        _opinionContentLabel.frame = CGRectMake(54.0 / 3.0, nextY, [UIScreen mainScreen].bounds.size.width - 54.0 / 3.0 - 45.0 / 3.0 - 96.0 / 3.0, opinionContentSize.height);
        _opinionContentLabel.font = [UIFont systemFontOfSize:15.0];
        _opinionContentLabel.textColor = [UIColor colorWithRed:(CGFloat)133 / 255 green:(CGFloat)147 / 255 blue:(CGFloat)181 / 255 alpha:1.0];
        _opinionContentLabel.text = opinionContentStr;
        _opinionContentLabel.numberOfLines = 0;
        
        CGFloat top =16; // 顶端盖高度
        CGFloat bottom =16; // 底端盖高度
        CGFloat left =16; // 左端盖宽度
        CGFloat right = 16; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        _backgroundImageView.image = [[UIImage imageNamed:@"chatBg"] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        if(_contentModel.countComment == 1)//不用显示  展开剩余意见按钮。
        {
            _backgroundImageView.frame = CGRectMake(48.0 / 3.0, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 18.0 / 3.0, [UIScreen mainScreen].bounds.size.width - 96.0 / 3.0, 27.0 / 3.0 + _opinionContentLabel.frame.origin.y + _opinionContentLabel.frame.size.height);
            _unfoldButton.hidden = YES;
        }
        else//显示  展开剩余意见按钮
        {
            _unfoldButton.frame = CGRectMake(76.0 / 3.0, _opinionContentLabel.frame.size.height + _opinionContentLabel.frame.origin.y + 33.0 / 3.0, [UIScreen mainScreen].bounds.size.width - 96.0 / 3.0 - 76 * 2 / 3.0, 114.0 / 3.0);
            _unfoldButton.hidden = NO;
            _unfoldButton.backgroundColor = [UIColor whiteColor];
            _unfoldButton.layer.borderColor = [UIColor colorWithRed:(CGFloat)245 / 255 green:(CGFloat)245 / 255 blue:(CGFloat)245 / 255 alpha:1.0].CGColor;
            _unfoldButton.layer.borderWidth = 0.6;
            [_unfoldButton setTitle:@"展开剩余意见..." forState:UIControlStateNormal];
            [_unfoldButton setTitle:@"收起剩余意见..." forState:UIControlStateSelected];
            [_unfoldButton addTarget:self action:@selector(showRestOpinions:) forControlEvents:UIControlEventTouchUpInside];
            _unfoldButton.titleLabel.font = [UIFont systemFontOfSize:42.0 / 3.0];
            [_unfoldButton setTitleColor:[UIColor colorWithRed:(CGFloat)118 / 255 green:(CGFloat)131 / 255 blue:(CGFloat)164 / 255 alpha:1.0] forState:UIControlStateNormal];
            _tableView.hidden = _contentModel.showChildTableView?NO:YES;
            //NSLog(@" _tableView.hidden = %d", _tableView.hidden);
            _unfoldButton.selected = _contentModel.showChildTableView;
            if(_tableView.hidden)
            {
                _backgroundImageView.frame = CGRectMake(48.0 / 3.0, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 18.0 / 3.0, [UIScreen mainScreen].bounds.size.width - 96.0 / 3.0, 27.0 / 3.0 + _unfoldButton.frame.origin.y + _unfoldButton.frame.size.height + 38.0 / 3.0);
            }
            else
            {
                _tableView.frame = CGRectMake(0, _unfoldButton.frame.origin.y + _unfoldButton.frame.size.height + 33.0 / 3.0, SCREEN_WIDTH - 96.0 / 3.0, _contentModel.childTableViewHeight);
                _backgroundImageView.frame = CGRectMake(48.0 / 3.0, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 18.0 / 3.0, [UIScreen mainScreen].bounds.size.width - 96.0 / 3.0, 27.0 / 3.0 + _tableView.frame.origin.y + _tableView.frame.size.height + 38.0 / 3.0);
                
                self.opinionsArray = _contentModel.opinionsArray;
                [_tableView reloadData];
            }
        }
    }
    else
    {
        _backgroundImageView.hidden = YES;
    }
    //下方 关注、意见、发送
    CGFloat actionBtnW = ([UIScreen mainScreen].bounds.size.width - 2) / 3.0;
    
    CGRect frame = CGRectZero;
    
    
    
    CGFloat actionBtnH = 114.0 / 3.0;
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.6)];
    topLine.backgroundColor = [UIColor colorWithRed:(CGFloat)235/255 green:(CGFloat)235/255 blue:(CGFloat)235/255 alpha:1.0];
    [_bottomActionView addSubview:topLine];
    
    
    
    //关注
    _attentionButton.frame = CGRectMake(0, 1, actionBtnW, actionBtnH - 1);
    CGSize tempSize = [@"关注" boundingRectWithSize:CGSizeMake(3030, 45.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:45.0 / 3.0]} context:nil].size;
    [_attentionButton setImageEdgeInsets:UIEdgeInsetsMake((actionBtnH - 14) * 0.5, (actionBtnW - 14 - tempSize.width - 9) * 0.5, (actionBtnH - 14) * 0.5, _attentionButton.frame.size.width - (actionBtnW - 14 - tempSize.width - 9) * 0.5 - 14)];
    _attentionButton.titleLabel.font = [UIFont systemFontOfSize:45.0 / 3.0];
    
    
    [_attentionButton setImage:[UIImage imageNamed:@"xinHui"] forState:UIControlStateNormal];
    [_attentionButton setImage:[UIImage imageNamed:@"xin"] forState:UIControlStateSelected];
    [_attentionButton setTitle:@"关注" forState:UIControlStateNormal];
    [_attentionButton addTarget:self action:@selector(clickToAttention:) forControlEvents:UIControlEventTouchUpInside];
    [_attentionButton setTitleColor:[UIColor colorWithRed:(CGFloat)153 / 255 green:(CGFloat)153 / 255 blue:(CGFloat)153 / 255 alpha:1.0] forState:UIControlStateNormal];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(_attentionButton.frame.origin.x + _attentionButton.frame.size.width, (actionBtnH - 1 - 15) * 0.5, 0.6, 15)];
    line1.backgroundColor = [UIColor colorWithRed:(CGFloat)235/255 green:(CGFloat)235/255 blue:(CGFloat)235/255 alpha:1.0];
    [_bottomActionView addSubview:line1];
    
    
    
    //意见
    _opinionButton.frame = CGRectMake(line1.frame.origin.x + line1.frame.size.width, _attentionButton.frame.origin.y, actionBtnW, actionBtnH - 1);
    [_opinionButton setImageEdgeInsets:UIEdgeInsetsMake((actionBtnH - 14) * 0.5, (actionBtnW - 14 - tempSize.width - 9) * 0.5, (actionBtnH - 14) * 0.5, _opinionButton.frame.size.width - (actionBtnW - 14 - tempSize.width - 9) * 0.5 - 14)];
    _opinionButton.titleLabel.font = [UIFont systemFontOfSize:45.0 / 3.0];
    [_opinionButton setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
    [_opinionButton setImage:[UIImage imageNamed:@"write-click"] forState:UIControlStateSelected];
    [_opinionButton setTitle:@"意见" forState:UIControlStateNormal];
    [_opinionButton addTarget:self action:@selector(clickToPublishOpinion:) forControlEvents:UIControlEventTouchUpInside];
    [_opinionButton setTitleColor:[UIColor colorWithRed:(CGFloat)153 / 255 green:(CGFloat)153 / 255 blue:(CGFloat)153 / 255 alpha:1.0] forState:UIControlStateNormal];
    frame =_opinionButton.frame;
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x + frame.size.width, (actionBtnH - 1 - 15) * 0.5, 0.6, 15)];
    line2.backgroundColor = [UIColor colorWithRed:(CGFloat)235/255 green:(CGFloat)235/255 blue:(CGFloat)235/255 alpha:1.0];
    [_bottomActionView addSubview:line2];
    
    //发送
    _sendButton.frame = CGRectMake(line2.frame.origin.x + line2.frame.size.width, _attentionButton.frame.origin.y, actionBtnW, actionBtnH - 1);
    [_sendButton setImageEdgeInsets:UIEdgeInsetsMake((actionBtnH - 14) * 0.5, (actionBtnW - 14 - tempSize.width - 9) * 0.5, (actionBtnH - 14) * 0.5, _sendButton.frame.size.width - (actionBtnW - 14 - tempSize.width - 9) * 0.5 - 14)];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:45.0 / 3.0];
    [_sendButton setImage:[UIImage imageNamed:@"transmit"] forState:UIControlStateNormal];
    [_sendButton setImage:[UIImage imageNamed:@"transmit-click"] forState:UIControlStateHighlighted];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(clickToSend:) forControlEvents:UIControlEventTouchUpInside];
    [_sendButton setTitleColor:[UIColor colorWithRed:(CGFloat)153 / 255 green:(CGFloat)153 / 255 blue:(CGFloat)153 / 255 alpha:1.0] forState:UIControlStateNormal];
    
    if(_backgroundImageView.hidden)//没有意见
    {
        _bottomActionView.frame = CGRectMake(0, _contentLabel.frame.origin.y + _contentLabel.frame.size.height + 39.0 / 3.0, [UIScreen mainScreen].bounds.size.width, actionBtnH);
        
    }
    else
    {
        _bottomActionView.frame = CGRectMake(0, _backgroundImageView.frame.origin.y + _backgroundImageView.frame.size.height + 39.0 / 3.0, [UIScreen mainScreen].bounds.size.width, actionBtnH);
    }
    _separationView.frame = CGRectMake(0, _bottomActionView.frame.origin.y + _bottomActionView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 36.0 / 3.0);
    _separationView.backgroundColor = [UIColor colorWithRed:(CGFloat)248 / 255 green:(CGFloat)248 / 255 blue:(CGFloat)248 / 255 alpha:1.0];
}



-(void)showRestOpinions:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self fetchCommentFromServer];
    }else{
        _contentModel.showChildTableView = NO;
        _tableView.hidden = YES;
        if([_delegate respondsToSelector:@selector(reloadCellHeightForModel:tableViewHeight:atIndexPath:)])
        {
            
            [_delegate reloadCellHeightForModel:_contentModel tableViewHeight:0 atIndexPath:_indexPath];
        }
    }
}

-(void)fetchCommentFromServer
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"opinionData" ofType:@"json"];
    NSData *pathData = [[NSData alloc]initWithContentsOfFile:path];
    NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:pathData options:NSJSONReadingMutableContainers error:nil];
    CGFloat tableViewH = 0;
    [self.opinionsArray removeAllObjects];
    for(int i = 0;i < tempArray.count;i++)
    {
        NSDictionary *dic = (NSDictionary *)tempArray[i];
        OpinionModel *model = [OpinionModel createOpinionModelFromDic:dic];
        
        if(i > 0)
        {
            CGFloat cellH = [OpinionCell getOpinionCellHeightWithModel:model];
            tableViewH += cellH;
            
        }
        [self.opinionsArray addObject:model];
    }
    NSString *heightStr = [NSString stringWithFormat:@"%.2f",tableViewH];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCellHeight" object:nil userInfo:@{@"H":heightStr}];
    
    _contentModel.childTableViewHeight = TABLEVIEW_IN_CELL_H;
    _contentModel.showChildTableView = YES;
    _contentModel.opinionsArray = self.opinionsArray;
    _tableView.hidden = NO;
    _tableView.frame = CGRectMake(0, _unfoldButton.frame.origin.y + _unfoldButton.frame.size.height + 33.0 / 3.0, _backgroundImageView.frame.size.width, tableViewH);
    if([_delegate respondsToSelector:@selector(reloadCellHeightForModel:tableViewHeight:atIndexPath:)])
    {
        [_delegate reloadCellHeightForModel:_contentModel tableViewHeight:tableViewH atIndexPath:_indexPath];
    }
}


#pragma mark -- UITableViewDataSource, UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.opinionsArray.count > 1?(self.opinionsArray.count - 1):0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpinionModel *model = (OpinionModel *)self.opinionsArray[indexPath.row + 1];
    return [OpinionCell getOpinionCellHeightWithModel:model];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpinionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OpinionCell"];
    OpinionModel *model = (OpinionModel *)self.opinionsArray[indexPath.row + 1];
    cell.opinionModel = model;
    return cell;
}

-(void)clickToPublishOpinion:(UIButton *)sender
{
    NSLog(@"填写意见");
}
-(void)clickToSend:(UIButton *)sender
{
    NSLog(@"点击发送");
}
-(void)clickToAttention:(UIButton *)sender
{
    NSLog(@"关注");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"scrollView = %@",scrollView);
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CAN_NOT_SCROLL" object:nil];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    NSLog(@"scrollViewWillEndDragging");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CAN_SCROLL" object:nil];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}

@end
