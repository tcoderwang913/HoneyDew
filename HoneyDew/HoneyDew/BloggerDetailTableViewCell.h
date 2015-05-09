//
//  BloggerDetailTableViewCell.h
//  HoneyDew
//
//  Created by Wei Liu on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BloggerDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellIcon;
@property (nonatomic, strong) UILabel *mainText;
@property (nonatomic, strong) UILabel *detailText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
