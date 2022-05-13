//
//  MAPicListTableViewCell.m
//  MutualAid
//
//  Created by foyoodo on 2022/5/13.
//

#import "MAPicListTableViewCell.h"

@implementation MAPicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageView.layer.masksToBounds = YES;
    self.picImageView.layer.cornerRadius = 4;
}

@end
