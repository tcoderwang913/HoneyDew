//
//  BloggerDetailTableViewCell.h
//  HoneyDew
//
//  Created by Wei Liu on 5/8/15.
//  Copyright (c) 2015 Song Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

typedef enum : NSUInteger {
  BloggerDetailCellTypeMapView,
  BloggerDetailCellTypeMapText,
  BloggerDetailCellTypeMapDirection,
  BloggerDetailCellTypeMainMenu,
  BloggerDetailCellTypePrice,
  BloggerDetailCellTypeMore,
  BloggerDetailCellTypeCall
} BloggerDetailCellType;

typedef enum : NSUInteger {
  BloggerCellSectionTypeMap,
  BloggerCellSectionTypeInfo
} BloggerCellSectionType;

@interface BloggerDetailTableViewCell : UITableViewCell <MKMapViewDelegate>
@property (nonatomic, strong) UIImageView *cellIcon;
@property (nonatomic, strong) UILabel *mainText;
@property (nonatomic, strong) UILabel *detailText;
@property (nonatomic) BloggerDetailCellType currentType;
// TODO: mapView should be extracted
@property (nonatomic, strong) MKMapView *mapView;

+ (CGFloat)heightForCellWithType:(NSUInteger)type atSection:(NSUInteger)section;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)configureMapCellForType:(NSUInteger)type;
- (void)configureInfoCellForType:(NSUInteger)type;
@end
