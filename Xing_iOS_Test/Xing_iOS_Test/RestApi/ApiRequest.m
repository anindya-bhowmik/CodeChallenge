//
//  ApiRequest.m
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//


#import "ApiRequest.h"
#import "Reachability.h"

@implementation ApiRequest

@synthesize delegate;

- (void)performApiRequest:(NSURL*)url forMethod:(NSString*)httpMethod completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *defaultConfiguratoin = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguratoin];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:httpMethod];
    [urlRequest setHTTPShouldHandleCookies:NO];
    [urlRequest setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error = nil;
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response, NSError *error){
        dataDictionary = nil;
        completionHandler(data,response,error);
    }];
    [dataTask resume];
}

- (void)fetchXingRepositoryInfoFrom:(NSInteger)page {
   // if([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] != NotReachable) {
        NSString *api = [NSString stringWithFormat:@"%@%ld",BaseAPI,page];
        [self performApiRequest:[NSURL URLWithString:api] forMethod:HTTP_GET completionHandler:^(NSData *data,NSURLResponse *response, NSError *error){
            if(error == nil) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                HTTPResut result = [self httpResultFromStatusCode:httpResponse.statusCode];
                if(result == HTTP_OK) {
                    if([self.delegate respondsToSelector:@selector(repositoryFetchCompleted:)] && data !=nil){
                        [self.delegate repositoryFetchCompleted:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL]];
                    }
                }else {
                    [self errorOccured];
                }
            }else if(error.code == NO_INTERNET_CONNECTIVITY) {
                if([self.delegate respondsToSelector:@selector(internetConnectivityError)]) {
                    [self.delegate internetConnectivityError];
                }
            }
        }];
//    }else {
//        if([self.delegate respondsToSelector:@selector(internetConnectivityError)]) {
//            [self.delegate internetConnectivityError];
//        }
//    }
}

- (void)errorOccured {
    if([self.delegate respondsToSelector:@selector(failedToLoadData)]) {
        [self.delegate failedToLoadData];
    }
}

- (HTTPResut)httpResultFromStatusCode:(NSInteger)responseStatus{
    HTTPResut result;
    switch (responseStatus) {
        case 200:
        case 201:
            result = HTTP_OK;
            break;
        case 400:
            result = HTTP_BAD_REQUEST;
            break;
        case 401:
        case 403:
            result = HTTP_UNAUTHORIZE;
            break;
        case 404:
            result = HTTP_CONTENT_NOT_FOUND;
            break;
        case 500:
        case 502:
        case 503:
            result = HTTP_SERVER_ERROR;
            break;
        default:
            result = HTTP_NG;
            break;
    }
    return result;
}

@end
