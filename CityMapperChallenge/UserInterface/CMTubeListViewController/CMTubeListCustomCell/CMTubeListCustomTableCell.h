//
//  CMTubeListCustomTableCell.h
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTubeListCustomTableCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *stationName;
@property (nonatomic, strong) IBOutlet UIStackView *facilitiesStackView;


+ (CGFloat) dynamicHeight;

@end
