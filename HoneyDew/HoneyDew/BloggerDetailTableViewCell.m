//
//  BloggerDetailTableViewCell.m
//  HoneyDew
//
//  Created by Wei Liu on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "BloggerDetailTableViewCell.h"

const static CGFloat kBloggerCellMargin = 10;
const static CGFloat kCellIconSide = 30;
const static CGFloat kCellTextWidth = 250;

@implementation BloggerDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    _cellIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
    _mainText = [[UILabel alloc] initWithFrame:CGRectZero];
    _mainText.textColor = [UIColor blackColor];
    _mainText.font = [UIFont systemFontOfSize:25];
    _detailText = [[UILabel alloc] initWithFrame:CGRectZero];
    _detailText.textColor = [UIColor blackColor];
    _detailText.font = [UIFont systemFontOfSize:10];
    [self addSubview:_cellIcon];
    [self addSubview:_mainText];
    [self addSubview:_detailText];
  }
  return self;
}

- (void)configureCellForType:(NSUInteger)type {
  switch (type) {
    case BloggerDetailCellTypeMainMenu:
    {
      _currentType = BloggerDetailCellTypeMainMenu;
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      _currentType = BloggerDetailCellTypeMore;
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      _currentType = BloggerDetailCellTypePrice;
    }
      break;
    default:
      break;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  switch (_currentType) {
    case BloggerDetailCellTypeMainMenu:
    {
      
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      
    }
      break;
    default:
      break;
  }
  _cellIcon.frame = CGRectMake(kBloggerCellMargin, 5, kCellIconSide, kCellIconSide);
  _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 2, kCellTextWidth, 25);
  _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 30, kCellTextWidth, 12);
}

@end
