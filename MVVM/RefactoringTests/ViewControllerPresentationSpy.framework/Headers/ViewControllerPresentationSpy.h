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

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double ViewControllerPresentationSpyVersionNumber;
FOUNDATION_EXPORT const unsigned char ViewControllerPresentationSpyVersionString[];

#import "QCOMockPopoverPresentationController.h"
#import "UIAlertAction+QCOMock.h"
#import "UIAlertController+QCOMock.h"
#import "UIViewController+QCOMock.h"
