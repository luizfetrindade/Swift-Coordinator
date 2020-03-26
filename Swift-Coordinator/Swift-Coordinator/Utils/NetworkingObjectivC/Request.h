//
//  Request.h
//  Swift-Coordinator
//
//  Created by Fabricio Pujol on 25/03/20.
//  Copyright © 2020 Luiz Felipe Trindade. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Request : NSObject

- (void)fetchGenres: (int) id request:(id<RequestProtocol>) delegate;
- (void)fetchPopular: (id<RequestProtocol>)delegate;
- (void)fetchNowPlaying: (id<RequestProtocol>)delegate;

+(instancetype)sharedRequestManager;

@end

NS_ASSUME_NONNULL_END
