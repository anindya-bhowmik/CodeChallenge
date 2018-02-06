//
//  ApiRequest.h
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Api.h"


@protocol ApiRequestingDelegate <NSObject>
@optional
- (void)internetConnectivityError;
- (void)repositoryFetchCompleted:(NSArray*)repositoryInfo;
- (void)failedToLoadData;
@end

typedef enum{
    HTTP_OK,
    HTTP_CONTENT_NOT_FOUND,
    HTTP_BAD_REQUEST,
    HTTP_UNAUTHORIZE,
    HTTP_SERVER_ERROR,
    HTTP_NG
}HTTPResut;

@interface ApiRequest : NSObject{
    NSDictionary *dataDictionary;
}
@property (nonatomic,strong) id<ApiRequestingDelegate>delegate;
- (void)fetchXingRepositoryInfoFrom:(NSInteger)page;
@end
