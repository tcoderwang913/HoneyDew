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
    _mainText.font = [UIFont systemFontOfSize:20];
    _detailText = [[UILabel alloc] initWithFrame:CGRectZero];
    _detailText.textColor = [UIColor blackColor];
    _detailText.lineBreakMode = NSLineBreakByTruncatingTail;
    _detailText.font = [UIFont systemFontOfSize:12];
    [self addSubview:_cellIcon];
    [self addSubview:_mainText];
    [self addSubview:_detailText];
  }
  return self;
}

- (void)configureCellForType:(NSUInteger)type {
  _detailText.numberOfLines = 1;
  _detailText.hidden = NO;
  switch (type) {
    case BloggerDetailCellTypeMainMenu:
    {
      _currentType = BloggerDetailCellTypeMainMenu;
      _cellIcon.image = [UIImage imageNamed:@"menu.png"];
      _mainText.text = @"Menu";
      _detailText.numberOfLines = 2;
      _detailText.text = @"Roasted Duck, Beef Chow Fun, Sweet & Sour Pork, Soya Duck, Soya Pig Intestine, Thai Style Chicken Feet, Pork Shank In House Sauce";
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      _currentType = BloggerDetailCellTypeMore;
      _cellIcon.image = [UIImage imageNamed:@"more.png"];
      _mainText.text = @"More";
      _detailText.text = @"Website, Ambience, Noise Level";
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      _currentType = BloggerDetailCellTypePrice;
      _cellIcon.image = [UIImage imageNamed:@"price.png"];
      _mainText.text = @"Price $$(10~50)";
      _detailText.hidden = YES;
    }
      break;
    case BloggerDetailCellTypeCall:
    {
      _currentType = BloggerDetailCellTypeCall;
      _cellIcon.image = [UIImage imageNamed:@"call.png"];
      _mainText.text = @"Call (123) 456-7890";
      _detailText.hidden = YES;
    }
      break;
    default:
      break;
  }
}

+ (CGFloat)heightForCellWithType:(NSUInteger)type {
  CGFloat ret = 44;
  switch (type) {
    case BloggerDetailCellTypeMainMenu:
    {
      return 60;
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      return 44;
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      return 40;
    }
      break;
    case BloggerDetailCellTypeCall:
    {
      return 40;
    }
    default:
      break;
  }
  return ret;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  switch (_currentType) {
    case BloggerDetailCellTypeMainMenu:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 15, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 5, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 30, 20);
      _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 28, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 20, 30);
    }
      break;
    case BloggerDetailCellTypePrice:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 5, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 5, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 30, 25);
    }
      break;
    case BloggerDetailCellTypeMore:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 8, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 5, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 30, 20);
      _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 28, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 20, 15);
    }
      break;
    case BloggerDetailCellTypeCall:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 5, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 5, self.frame.size.width - _cellIcon.frame.size.width - kBloggerCellMargin * 2 - 30, 25);
    }
      break;
    default:
    {
      _cellIcon.frame = CGRectMake(kBloggerCellMargin, 5, kCellIconSide, kCellIconSide);
      _mainText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 2, kCellTextWidth, 25);
      _detailText.frame = CGRectMake(_cellIcon.frame.size.width + _cellIcon.frame.origin.x + kBloggerCellMargin, 30, kCellTextWidth, 12);
    }
      break;
  }

}

@end
