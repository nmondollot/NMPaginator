//
// Created by Felipe Docil on 9/4/13.
// Copyright (c) 2013 Nicolas Mondollot. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "YoutubeFetcher.h"
#import "YoutubeAPIKey.h"

static NSString *const kBaseURL = @"https://www.googleapis.com/youtube/v3";

@implementation YoutubeFetcher {

}
+ (NSDictionary *)videosWithChannelID:(NSString * const)channelId pageToken:(NSInteger *)pageToken pageSize:(NSInteger)pageSize
{
	NSString *requestURL = [NSString stringWithFormat:@"%@/search?part=snippet&type=video&order=date&maxResults=%u&page=%p&channelId=%@&key=%@", kBaseURL, pageSize, pageToken, channelId, YoutubeAPIKey];
	return [self executeYoutubeFetch:requestURL];
}


+ (NSDictionary *)executeYoutubeFetch:(NSString *)url
{
	url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), url);
	NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error] : nil;
	if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
	NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
	return results;
}
@end