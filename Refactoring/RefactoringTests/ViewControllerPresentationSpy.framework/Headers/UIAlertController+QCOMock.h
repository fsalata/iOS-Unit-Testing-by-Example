/***
 * Excerpted from "iOS Unit Testing by Example",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/jrlegios for more book information.
***/
//  ViewControllerPresentationSpy by Jon Reid, https://qualitycoding.org/
//  Copyright 2020 Quality Coding, Inc. See LICENSE.txt

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const QCOMockAlertControllerPresentedNotification;

@interface UIAlertController (QCOMock)
+ (void)qcoMock_swizzle;
@end

NS_ASSUME_NONNULL_END
