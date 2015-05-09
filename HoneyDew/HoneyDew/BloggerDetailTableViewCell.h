//
//  BloggerDetailTableViewCell.h
//  HoneyDew
//
//  Created by Wei Liu on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  BloggerDetailCellTypeMainMenu,
  BloggerDetailCellTypePrice,
  BloggerDetailCellTypeMore,
  BloggerDetailCellTypeCall
} BloggerDetailCellType;

@interface BloggerDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellIcon;
@property (nonatomic, strong) UILabel *mainText;
@property (nonatomic, strong) UILabel *detailText;
@property (nonatomic) BloggerDetailCellType currentType;

+ (CGFloat)heightForCellWithType:(NSUInteger)type;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureCellForType:(NSUInteger)type;
@end
