//
// Created by Felipe Docil on 9/4/13.
// Copyright (c) 2013 Nicolas Mondollot. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#define YOUTUBE_VIDEO_TITLE @"title"

@interface YoutubeFetcher : NSObject

+ (NSDictionary *)videosWithChannelID:(NSString * const)channelId pageToken:(NSInteger *)pageToken pageSize:(NSInteger)pageSize;

@end