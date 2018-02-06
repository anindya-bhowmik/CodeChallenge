//
//  Api.h
//  Xing_iOS_Test
//
//  Created by Anindya on 2/2/18.
//  Copyright © 2018 Anindya. All rights reserved.
//


#ifndef Api_h
#define Api_h


#define BaseAPI  @"https://api.github.com/users/xing/repos?access_token=09f51c47b00835fda9c5638bb2771250accc6ae5&page="





#define HTTP_POST          @"POST"
#define HTTP_GET           @"GET"
#define HTTP_PUT           @"PUT"
#define HTTP_DELETE        @"DELETE"


#define  RESPONSE_CODE_OK  200
#define  RESPONSE_CODE_CREATED  201
#define  RESPONSE_CODE_NO_CONTENT  204
#define  RESPONSE_CODE_NOT  304
#define  RESPONSE_CODE_BAD_REQUEST  400
#define  RESPONSE_CODE_UNAUTHORIZED  401
#define  RESPONSE_CODE_FORBIDDEN 403
#define  RESPONSE_CODE_NOT_FOUND  404
#define  RESPONSE_CODE_CONFLICT_PROPERTY  409
#define  RESPONSE_CODE_ENHANCE_YOUR_CALM  420
#define  RESPONSE_CODE_INTERNAL_SERVER_ERROR  500
#define  RESPONSE_CODE_BAD_GATEWAY  502
#define  RESPONSE_CODE_SERVICE_UNAVAILABLE 503
#define  NO_INTERNET_CONNECTIVITY  -1009



#endif /* Api_h */
