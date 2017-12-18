//
//  CMTubeListCustomTableCell.m
//  CityMapperChallenge
//
//  Created by Nilofar Vahab poor on 17/12/2017.
//  Copyright © 2017 Nilofar Vahab poor. All rights reserved.
//

#import "CMTubeListCustomTableCell.h"

@implementation CMTubeListCustomTableCell

+ (CGFloat) dynamicHeight {
    return 200;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.facilitiesStackView.axis = UILayoutConstraintAxisHorizontal;
    self.facilitiesStackView.alignment = UIStackViewAlignmentFill;
    self.facilitiesStackView.distribution = UIStackViewDistributionFill;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
