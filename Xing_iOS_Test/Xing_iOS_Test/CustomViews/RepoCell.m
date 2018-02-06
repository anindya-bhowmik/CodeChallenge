//
//  RepoCell.m
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//

#import "RepoCell.h"
#define kGapBetweenLabels 10
@implementation RepoCell

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        repositoryName = [[UILabel alloc]initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height/3)];
      //  repositoryName.text = @"sad";
        repositoryName.textAlignment = NSTextAlignmentCenter;
       // repositoryName.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:repositoryName];
        
        repositoryDescription = [[UILabel alloc]initWithFrame:CGRectMake(0,repositoryName.frame.size.height,frame.size.width,frame.size.height/3)];
       // repositoryDescription.text = @"description";
        repositoryDescription.textAlignment = NSTextAlignmentCenter;
       // repositoryDescription.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:repositoryDescription];
        loginOwner = [[UILabel alloc]initWithFrame:CGRectMake(0,repositoryDescription.frame.origin.y+repositoryDescription.frame.size.height,frame.size.width,frame.size.height/3)];
    //    loginOwner.text = @"Xing";
        loginOwner.textAlignment = NSTextAlignmentCenter;
       // loginOwner.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:loginOwner];
    }
    return self;
}

- (void)setRepositoryName:(NSString*)name {
        repositoryName.text = name;
}

- (void)setRespositoryDescription:(NSString*)description {
        repositoryDescription.text = description;
}

- (void)setOwner:(NSString*)owner {
        loginOwner.text = owner;
}

@end
