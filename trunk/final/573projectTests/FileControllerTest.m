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
#import "AppDelegate.h"
#import "gateinformation.h"
#import "fileViewController.h"
@interface FileControllerTest : XCTestCase
{
@private
    AppDelegate *app_delegate;
    fileViewController *fileListTableView_controller;
    UIView *filePageView;
    UIStoryboard *board;
    NSString *Name;
    NSString *Path;
    NSString *FullName;
    
}
@end

@implementation FileControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    app_delegate         = [[UIApplication sharedApplication] delegate];
    //test array
    board = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    fileListTableView_controller = [board instantiateViewControllerWithIdentifier:@"fileview"];
    filePageView = fileListTableView_controller.view;
    Name = @"Verilog.v";
    Path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    FullName = [Path stringByAppendingPathComponent:Name];
    //if (![[NSFileManager defaultManager] fileExistsAtPath:sVrlgFileName]){
    [[NSFileManager defaultManager]createFileAtPath:FullName contents:nil attributes:nil];
    
    
    
    NSDirectoryEnumerator *DirEnum;
    
    DirEnum = [[NSFileManager defaultManager] enumeratorAtPath:Path];
    
    NSString *file;
    
    while((file=[DirEnum nextObject]))     //visit the document's path
        
    {
        
        if([[file pathExtension] isEqualToString:@"v"])   //get all v files
            
        {
            
            //[array addObject:[docPath stringByAppendingPathComponent:file]]; //save to the array
            
            [fileListTableView_controller.filelist addObject:file];
            
        }
        
    }
    //fileListTableView_controller.filelist=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:Path error:nil];
    

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testTable{
    XCTAssertFalse(fileListTableView_controller.table.hidden,@"Gate Table need display.");
}


- (void)testCreatVerilogFile{
    [fileListTableView_controller performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:FullName], @"failed Creat Verilog File");
}

- (void)testTableCell{
 
    XCTAssertNotNil(fileListTableView_controller.filelist, @"failed Creat Verilog File");
}
-(void)testandselect{
    NSString *selectedFileNameShouldBe=[fileListTableView_controller.filelist objectAtIndex: 0];
    if ([selectedFileNameShouldBe  isEqual: @".DS_Store"]) {
        selectedFileNameShouldBe = [fileListTableView_controller.filelist objectAtIndex: 1];
    }
    //NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    //[fileListTableView_controller tableView:fileListTableView_controller.table didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([Name isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}




- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
