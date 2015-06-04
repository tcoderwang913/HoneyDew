//
//  DishTableViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 6/3/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "DishTableViewCell.h"
const static CGFloat kDishCellMargin = 20;

@implementation DishTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _dishView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _dishLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dishDescription = [[UILabel alloc] initWithFrame:CGRectZero];
    _dishPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:_dishView];
    [self addSubview:_dishLabel];
    [self addSubview:_dishDescription];
    [self addSubview:_dishPrice];
  }
  return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  _dishView.frame = CGRectMake(kDishCellMargin, kDishCellMargin, 60, 60);
  // TODO: finish other views
}

@end
