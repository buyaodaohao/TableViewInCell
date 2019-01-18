//
//  OpinionCell.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import "OpinionCell.h"
@interface OpinionCell ()
/**意见发表者的头像*/
@property(nonatomic,strong)UIButton *opinionHeadIconButton;
/**意见发表者的姓名*/
@property(nonatomic,strong)UIButton *opinionNameButton;

/**意见中闹钟图标*/
@property(nonatomic,strong)UIImageView *opinionTimeIconImageView;
/**意见中显示时间的label*/
@property(nonatomic,strong)UILabel *opinionTimeLabel;
/**意见内容*/
@property(nonatomic,strong)UILabel *opinionContentLabel;
@end
@implementation OpinionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        /**意见发表者的头像*/
        _opinionHeadIconButton = [[UIButton alloc]init];
        [self.contentView addSubview:_opinionHeadIconButton];
        /**意见发表者的姓名*/
        _opinionNameButton = [[UIButton alloc]init];
        [self.contentView addSubview:_opinionNameButton];
        
        /**意见中闹钟图标*/
        _opinionTimeIconImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_opinionTimeIconImageView];
        /**意见中显示时间的label*/
        _opinionTimeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_opinionTimeLabel];
        /**意见内容*/
        _opinionContentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_opinionContentLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)getOpinionCellHeightWithModel:(OpinionModel *)model
{
    CGFloat cellH = 0.0;
    cellH = 27.0 / 3.0 + 102.0 / 3.0 + 24.0 / 3.0 + 27.0 / 3.0;
    NSString *opinionContentStr = model.itemsContent;
    CGSize opinionContentSize = [opinionContentStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 96.0 / 3.0 - 54.0 / 3.0 - 45.0 / 3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:45.0 / 3.0]} context:nil].size;

    cellH = cellH + opinionContentSize.height;
    return cellH;
}
-(void)layoutSubviews
{
    _opinionHeadIconButton.frame = CGRectMake(54.0 / 3.0, 27.0 / 3.0, 102.0 / 3.0, 102.0 / 3.0);
    UIImage *placeholderImage =[UIImage imageNamed:@"user-default-icon"];
    [_opinionHeadIconButton setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:_opinionModel.userIcon] placeholderImage:placeholderImage];
    _opinionHeadIconButton.layer.cornerRadius = 102.0 / 2.0 / 3.0;
    _opinionHeadIconButton.layer.masksToBounds = YES;
    
    NSString *nameStr = _opinionModel.name;
    CGSize nameSize = [nameStr boundingRectWithSize:CGSizeMake(300, 48.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size;
    _opinionNameButton.frame = CGRectMake(_opinionHeadIconButton.frame.origin.x + _opinionHeadIconButton.frame.size.width + 33.0 / 3.0, 54.0 / 3.0, nameSize.width, 48.0 / 3.0);
    _opinionNameButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_opinionNameButton setTitle:nameStr forState:UIControlStateNormal];
    [_opinionNameButton setTitleColor:[UIColor colorWithRed:(CGFloat)51/255 green:(CGFloat)51/255 blue:(CGFloat)51/255 alpha:1.0] forState:UIControlStateNormal];
    
    
    
    NSString *timeStr = _opinionModel.time;
    //    timeStr = [TimeHelp formatShowDateTime:timeStr];
    CGSize timeSize = [timeStr boundingRectWithSize:CGSizeMake(300, 27.0 / 3.0) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:27.0 / 3.0]} context:nil].size;
    _opinionTimeLabel.frame = CGRectMake(self.frame.size.width - 48.0 / 3.0 - timeSize.width, (75 / 2.0 + 27.0) / 3.0, timeSize.width, 27.0 / 3.0);
    _opinionTimeLabel.font = [UIFont systemFontOfSize:9.0];
    _opinionTimeLabel.textColor = [UIColor colorWithRed:(CGFloat)153 / 255 green:(CGFloat)153 / 255 blue:(CGFloat)153 / 255 alpha:1.0];
    _opinionTimeLabel.text = timeStr;
    
    _opinionTimeIconImageView.frame = CGRectMake(_opinionTimeLabel.frame.origin.x - 24.0 / 3.0 - 33.0 / 3.0, _opinionTimeLabel.frame.origin.y - 1, 33.0 / 3.0, 33.0 / 3.0);
    _opinionTimeIconImageView.image = [UIImage imageNamed:@"clock"];
    _opinionTimeIconImageView.layer.cornerRadius = 33.0 / 3.0 / 2.0;
    _opinionTimeIconImageView.layer.masksToBounds = YES;
    CGFloat nextY = _opinionHeadIconButton.frame.origin.y + _opinionHeadIconButton.frame.size.height + 24.0 / 3.0;
    NSString *opinionContentStr = _opinionModel.itemsContent;
    CGSize opinionContentSize = [opinionContentStr boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 54.0 / 3.0 - 45.0 / 3.0 - 96.0 / 3.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0]} context:nil].size;

    
    _opinionContentLabel.frame = CGRectMake(54.0 / 3.0, nextY, [UIScreen mainScreen].bounds.size.width - 54.0 / 3.0 - 45.0 / 3.0 - 96.0 / 3.0, opinionContentSize.height);
    _opinionContentLabel.font = [UIFont systemFontOfSize:15.0];
    _opinionContentLabel.textColor = [UIColor colorWithRed:(CGFloat)133 / 255 green:(CGFloat)147 / 255 blue:(CGFloat)181 / 255 alpha:1.0];
    _opinionContentLabel.text = _opinionModel.itemsContent;
    _opinionContentLabel.numberOfLines = 0;
}
@end
