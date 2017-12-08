//
//  SYTableViewCell.m
//  SelectTableViewCell
//
//  Created by chenshunyi on 2017/12/8.
//  Copyright © 2017年 house365. All rights reserved.
//

#import "SYTableViewCell.h"

@implementation SYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews){
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (self.selected) {
                        image.image=[UIImage imageNamed:@"favEditSelect.png"];
                    }else{
                        image.image=[UIImage imageNamed:@"favEditUnSelect.png"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews){
                if ([view isKindOfClass: [UIImageView class]]) {
                    UIImageView *image=(UIImageView *)view;
                    if (!self.selected) {
                        image.image=[UIImage imageNamed:@"favEditUnSelect.png"];
                    }else{
                        image.image=[UIImage imageNamed:@"favEditSelect.png"];
                    }
                }
            }
        }
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
