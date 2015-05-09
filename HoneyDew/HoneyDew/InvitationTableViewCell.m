//
//  InvitationTableViewCell.m
//  HoneyDew
//
//  Created by Song Wang on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import "InvitationTableViewCell.h"

static CGFloat kMargin = 10.0f;

@implementation InvitationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.dateLabel];
  }
  return self;
}

- (UILabel *)nameLabel
{
  if (_nameLabel == nil) {
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _nameLabel.numberOfLines = 0;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
  }
  return _nameLabel;
}

- (UILabel *)dateLabel
{
  if (_dateLabel == nil) {
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dateLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    _dateLabel.textAlignment = NSTextAlignmentLeft;
    _dateLabel.numberOfLines = 0;
  }
  return _dateLabel;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  CGSize sizeOfNameLabel = [self.nameLabel sizeThatFits:self.contentView.bounds.size];
  self.nameLabel.frame = CGRectMake(kMargin, kMargin, sizeOfNameLabel.width, sizeOfNameLabel.height);
  CGSize sizeOfDateLabel = [self.dateLabel sizeThatFits:self.contentView.bounds.size];
  self.dateLabel.frame = CGRectMake(self.nameLabel.frame.size.width + kMargin, kMargin, sizeOfDateLabel.width, sizeOfDateLabel.height);
}



@end
