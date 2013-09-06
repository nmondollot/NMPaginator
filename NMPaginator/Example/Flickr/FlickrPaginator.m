//
//  FlickrPaginator.m
//  NMPaginator
//
//  Created by Nicolas Mondollot on 08/04/12.
//  Copyright (c) 2012 Nicolas Mondollot. All rights reserved.
//

#import "FlickrPaginator.h"
#import "FlickrFetcher.h"

@implementation FlickrPaginator

# pragma - fetch flickr photos

- (void)fetchResultsWithPage:(NSInteger)page pageSize:(NSInteger)pageSize
{
    // do request on async thread
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSDictionary *jsonData = [FlickrFetcher photosWithSearchText:@"paginator" page:page pageSize:pageSize];
        
        // go back to main thread before adding results
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSArray *photos = [jsonData valueForKeyPath:@"photos.photo"];
            NSInteger total = [[jsonData valueForKeyPath:@"photos.total"] intValue];

            [self receivedResults:photos total:total];
        });
    });
    dispatch_release(fetchQ);
}


@end
