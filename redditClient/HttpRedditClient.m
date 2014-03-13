#import "HttpRedditClient.h"


@implementation HttpRedditClient

- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionBlock)callback
{

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    NSURL *redditURL = [[NSURL alloc] initWithString:@"http://www.reddit.com/subreddits/popular.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:redditURL];

    __block NSDictionary *subredditsJson;

    NSURLSessionDataTask *jsonData = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        subredditsJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
        callback(subredditsJson);
    }];

    [jsonData resume];
}

@end