#import "HttpRedditClient.h"


@implementation HttpRedditClient

- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionBlock)callback
{
    NSString *url = @"http://www.reddit.com/subreddits/popular.json";
    NSURL *redditURL = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:redditURL];

    [self performRequest:request callback:callback];
}

- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(JSONPostsFetchCompletionBlock)callback
{
    NSString *url = [NSString stringWithFormat:@"http://www.reddit.com/r/%@/hot.json", subreddit];
    NSURL *redditURL = [[NSURL alloc] initWithString:url];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:redditURL];

    [self performRequest:request callback:callback];
}

- (void)performRequest:(NSURLRequest *)request callback:(void(^)(NSDictionary *))callback
{

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];



    __block NSDictionary *JSONResponse;
    NSURLSessionDataTask *jsonData = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
        callback(JSONResponse);
    }];

    [jsonData resume];
}


@end