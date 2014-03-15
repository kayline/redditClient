#import "HttpRedditClient.h"


@implementation HttpRedditClient

- (void)fetchPopularSubredditsWithCallback:(SubredditFetchCompletionHandler)subredditFetchCompletionHandler
{
    NSString *url = @"http://www.reddit.com/subreddits/popular.json";
    NSURL *redditURL = [[NSURL alloc] initWithString:url];

    [self performRequestWithURL:redditURL callback:subredditFetchCompletionHandler];
}

- (void)fetchPostsForSubreddit:(NSString *)subreddit callback:(JSONPostsFetchCompletionHandler)JSONPostsFetchCompletionHandler
{
    NSString *url = [NSString stringWithFormat:@"http://www.reddit.com/r/%@/hot.json", subreddit];
    NSURL *redditURL = [[NSURL alloc] initWithString:url];

    [self performRequestWithURL:redditURL callback:JSONPostsFetchCompletionHandler];
}

#pragma mark - Private

- (void)performRequestWithURL:(NSURL *)url callback:(void(^)(NSDictionary *))callback
{

    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];



    __block NSDictionary *JSONResponse;

    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *e = nil;
        JSONResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
        callback(JSONResponse);
    }];

    [jsonData resume];
}


@end