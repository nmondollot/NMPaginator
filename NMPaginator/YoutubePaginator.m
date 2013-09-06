//
// Created by Felipe Docil on 9/4/13.
// Copyright (c) 2013 Nicolas Mondollot. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "YoutubePaginator.h"
#import "YoutubeFetcher.h"

static NSString *const kChannelId = @"UCARqCFEQ1qKsZTHLqMqYuDw";

@implementation YoutubePaginator

#pragma - Fetch Youtube Videos

- (void)fetchResultsWithPage:(NSInteger *)pageToken pageSize:(NSInteger)pageSize
{
	dispatch_queue_t fetchQ = dispatch_queue_create("Youtube fetcher", NULL);
	dispatch_async(fetchQ, ^{
		NSDictionary *jsonData = [YoutubeFetcher videosWithChannelID:kChannelId pageToken:pageToken pageSize:pageSize];

		dispatch_sync(dispatch_get_main_queue(), ^{
			NSArray *videos = jsonData[@"items"];
			NSInteger total = [jsonData[@"pageInfo"][@"totalResults"] intValue];

			[self receivedResults:videos total:total];
		});
	});
	dispatch_release(fetchQ);
}

@end