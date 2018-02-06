//
//  XingRepository.h
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XingRepository : NSObject

@property (nonatomic)NSString *repoName;
@property (nonatomic)NSString *repoDescription;
@property (nonatomic)NSString *repoOwner;
@property (nonatomic)BOOL isForked;

@end
