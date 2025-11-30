#import <XCTest/XCTest.h>
#import "NSUserActivity+WMFExtensions.h"


@interface NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test : XCTestCase
@end

@implementation NSUserActivity_WMFExtensions_wmf_activityForWikipediaScheme_Test

- (void)testURLWithoutWikipediaSchemeReturnsNil {
    NSURL *url = [NSURL URLWithString:@"http://www.foo.com"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testInvalidArticleURLReturnsNil {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertNil(activity);
}

- (void)testArticleURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/wiki/Foo"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString, @"https://en.wikipedia.org/wiki/Foo");
}

- (void)testExploreURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://explore"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeExplore);
}

- (void)testHistoryURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://history"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeHistory);
}

- (void)testSavedURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://saved"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeSavedPages);
}

- (void)testPlacesURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
}

- (void)testPlacesURLWithArticle {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?WMFArticleURL=https://en.wikipedia.org/wiki/Amsterdam?wprov=sfti1"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssert([[activity.webpageURL absoluteString] isEqualToString: @"https://en.wikipedia.org/wiki/Amsterdam?wprov=sfti1"]);
}

- (void)testPlacesURLWithCorrectLatitudeAndLongitude {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?latitude=52.3676&longitude=4.9041"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssert([activity.userInfo[WMFPlacesUserInfoKeyLatitude] isEqualToString:@"52.3676"]);
    XCTAssert([activity.userInfo[WMFPlacesUserInfoKeyLongitude] isEqualToString:@"4.9041"]);
}

- (void)testPlacesURLWithOnlyLatitude {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?latitude=52.3676"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertNil(activity.userInfo[WMFPlacesUserInfoKeyLatitude]);
    XCTAssertNil(activity.userInfo[WMFPlacesUserInfoKeyLongitude]);
}

- (void)testPlacesURLWithOnlyLongitude {
    NSURL *url = [NSURL URLWithString:@"wikipedia://places?longitude=4.9041"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypePlaces);
    XCTAssertNil(activity.userInfo[WMFPlacesUserInfoKeyLatitude]);
    XCTAssertNil(activity.userInfo[WMFPlacesUserInfoKeyLongitude]);
}

- (void)testSearchURL {
    NSURL *url = [NSURL URLWithString:@"wikipedia://en.wikipedia.org/w/index.php?search=dog"];
    NSUserActivity *activity = [NSUserActivity wmf_activityForWikipediaScheme:url];
    XCTAssertEqual(activity.wmf_type, WMFUserActivityTypeLink);
    XCTAssertEqualObjects(activity.webpageURL.absoluteString,
                          @"https://en.wikipedia.org/w/index.php?search=dog&title=Special:Search&fulltext=1");
}

@end

