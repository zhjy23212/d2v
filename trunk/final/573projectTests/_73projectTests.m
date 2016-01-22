/*
 Copyright (c) 5/5/2015 AO Li, Liang Yung Huang, Jiyang Zhou. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "gateinformation.h"
#import "processingGate.h"
#import "workViewController.h"


@interface _73projectTests : XCTestCase

@end

@implementation _73projectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


- (void)testCompnentIn {
    
   // gateinformation *gate = [[gateinformation alloc]init];
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    workViewController *workview = [board instantiateViewControllerWithIdentifier:@"WorkView"];
    //[workview performSelector:@selector(loadView)];
   // [workview performSelectorOnMainThread:@selector(viewDidLoad) withObject:nil waitUntilDone:YES];
    [workview view];
    XCTAssertTrue(workview.table.hidden,@"no");
    
    //UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    
   // viewfortest = board.instantiateInitialViewController() as ViewController
    
 //   viewfortest.loadView()
 //   XCTAssertFalse(viewfortest.buttonhw1.hidden, "No image display!")
    

}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
