//
//  ReaderDocumentTests.m
//  Reader Tests
//
//  Created by Mehdi Mulani on 18/04/2015.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ReaderDocument.h"

@interface ReaderDocumentTests : XCTestCase

@end

@implementation ReaderDocumentTests

- (void)testPDFValidityChecks
{
  NSString *validPDFPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestDocument" ofType:@"pdf"];
  XCTAssertNotNil([ReaderDocument withDocumentFilePath:validPDFPath password:nil]);

  NSString *validPDFWithBadExtension = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestDocumentWithBadExtension" ofType:@"abc"];
  XCTAssertNotNil([ReaderDocument withDocumentFilePath:validPDFWithBadExtension password:nil]);

  NSString *notPDFPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"FakePDF" ofType:@"rtf"];
  XCTAssertNil([ReaderDocument withDocumentFilePath:notPDFPath password:nil]);

  NSString *fakePDFPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"FakePDF" ofType:@"pdf"];
  XCTAssertNil([ReaderDocument withDocumentFilePath:fakePDFPath password:nil]);
}

- (void)testNumberOfPages
{
  NSString *onePager = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestDocument" ofType:@"pdf"];
  ReaderDocument *document = [ReaderDocument withDocumentFilePath:onePager password:nil];
  XCTAssertEqualObjects([document pageCount], @1);

  NSString *sevenPager = [[NSBundle bundleForClass:[self class]] pathForResource:@"TestDocumentWithSevenPages" ofType:@"pdf"];
  document = [ReaderDocument withDocumentFilePath:sevenPager password:nil];
  XCTAssertEqualObjects([document pageCount], @7);
}

@end
