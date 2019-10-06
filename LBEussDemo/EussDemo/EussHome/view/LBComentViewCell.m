//
//  LBComentViewCell.m
//  EussDemo
//
//  Created by mc on 2019/10/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "LBComentViewCell.h"
@interface LBComentViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation LBComentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.cornerRadius = 35/2;
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageview;
   
}

-(void)setComment:(LBCommentModel *)comment{
    _comment = comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    if([comment.user.sex isEqualToString:@"m"]){
        self.sexView.image = [UIImage imageNamed:@"Profile_manIcon"];
        
    }else{
        self.sexView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    self.contentLabel.text = comment.content;
    self.userName.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
