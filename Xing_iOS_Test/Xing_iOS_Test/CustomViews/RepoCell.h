//
//  RepoCell.h
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoCell : UICollectionViewCell {
    UILabel *repositoryName;
    UILabel *repositoryDescription;
    UILabel *loginOwner;
}
- (void)setRepositoryName:(NSString*)name;
- (void)setRespositoryDescription:(NSString*)description;
- (void)setOwner:(NSString*)owner;
@end
