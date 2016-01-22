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
#import "handbookViewController.h"
#import "AppDelegate.h"

@interface Handbooktest : XCTestCase
{
@private
    AppDelegate *app_delegate;
    handbookViewController *hbViewController;
    UIView *hbView;
}
@end

@implementation Handbooktest

- (void)setUp {
    [super setUp];
    app_delegate         = [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    hbViewController = [storyboard instantiateViewControllerWithIdentifier:@"HandbooView"];
    hbView = hbViewController.view;
    [hbViewController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];

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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

-(void)testhbcontrollerload{
    XCTAssertTrue((hbViewController), @"load failed");
}

-(void)testtableviewload{
    XCTAssertNotNil(hbViewController.MenuTableViewList, @"View not initiated properly");
}

//test each button return to right name in the table list
//instruction
-(void)testinstructionselect{
    NSString *selectedFileNameShouldBe=[hbViewController.example objectAtIndex: 0];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletype isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}
//add
-(void)testaddselect{
    NSString *selectedFileNameShouldBe=[hbViewController.example objectAtIndex: 1];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:1 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletype isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}
//sub
-(void)testsubselect{
    NSString *selectedFileNameShouldBe=[hbViewController.example objectAtIndex: 2];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:2 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletype isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}
//inv
-(void)testinvselect{
    NSString *selectedFileNameShouldBe=[hbViewController.example objectAtIndex: 3];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:3 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletype isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}
//and
-(void)testandselect{
    NSString *selectedFileNameShouldBe=[hbViewController.example objectAtIndex: 4];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:4 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletype isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}
-(void)testorselect{
    NSString *selectedFileNameShouldBe=[hbViewController.example objectAtIndex: 5];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:5 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletype isEqualToString:selectedFileNameShouldBe], @"testSelect failed.");
}
//test the text content after click each button
//instruction
-(void)testinstructioncontent{
    NSString *Instruction = [[NSString alloc] initWithFormat:@"Basic Instruction: \n 	This app support building circuit schematic and convert into verilog code output. \n	The circuit should not be a cyclic circuit( output connect to a previous input). \n 	The value for input is 8 bit. \n 	When using the inverter, the result is unsigned.\n	The maximum components number is 6.\n\nButton Function: \n 	Handbook: Show hand book \n 	Start: Show work board to design schematic\n 	Edit: After click it, GateList button show \n 	GateList: Choose the gate which user want to add\n 	DeleteAll: Delete all items\n 	Wire: Begin to connect components\n 	Done: After chose components, click this 		       button. Then the wire button will show. \n 	Simulate: Show Latency, Output Value, and check 		    schematic\n	VerilogCode: Show the Verilog HDL code\n 	FilesList: After click it, user can choose a file to Email it\nDesign Steps:\n	1. Click Start button.\n	2. Click Edit button.\n	3. Click GateList button. Then choose several components. The component can be draged.\n	4. After chose components, click this button. Then the wire button will show.\n	5. Click the wire button, long press from one component's port to another component's port, the wire is generated.\n	6. Type the input value in the input label.\n	7. Click the Simulate button, the circuit latency, output Value, and check schematic.\n	8. Click VerilgCode button, the Verilog HDL code show. Then click Back button. 9. Click FilesList button, choosing a file to email.\n	10. Click DeleteAll button to delete all design. Then begin to design a new one.\n"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:0 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletext.text isEqualToString:Instruction], @"Wrong Text");
}
//add
-(void)testadd{
     NSString *Add = [[NSString alloc] initWithFormat:@"module ADD(a,b,sum); \n	input [7:0] a,b; \n	output reg [31:0] sum; \n	always@(a,b)begin \n		sum<=a+b; \n	end \nendmodule"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:1 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletext.text isEqualToString:Add], @"Wrong Text");
}
//sub
-(void)testsub{
    NSString *Sub = [[NSString alloc] initWithFormat:@"module SUB(a,b,diff);\n	input [7:0]a; \n	input [7:0]b; \n	output reg [7:0] diff; \n	always@(a,b)begin \n		diff<=a-b; \n	end \nendmodule"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:2 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletext.text isEqualToString:Sub], @"Wrong Text");
}
//inv
-(void)testInv{
    NSString *Inv = [[NSString alloc] initWithFormat:@"module Inv(a,b,prod); \n	input [7:0] a; \n	output reg [7:0] b; \n	always@(a,b)begin \n		a<=~b; \n	end \nendmodule"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:3 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletext.text isEqualToString:Inv], @"Wrong Text");
}
//and
-(void)testAnd{
     NSString *And = [[NSString alloc] initWithFormat:@"module And(a,b,prod); \n	input [7:0] a,b; \n	output reg Result; \n	always@(a,b)begin \n		Result<=a&b; \n	end \nendmodule"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:4 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletext.text isEqualToString:And], @"Wrong Text");
}
//or
-(void)testOr{
   NSString *Or = [[NSString alloc] initWithFormat:@"module Or(a,b,prod); \n	input [7:0] a,b; \n	output reg Result; \n	always@(a,b)begin \n		Result<=a|b; \n	end \nendmodule"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:5 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.exampletext.text isEqualToString:Or], @"Wrong Text");
}
//test the image after click each button
//add
-(void)testaddimage{
    UIImage *image;
    image = [UIImage imageNamed:@"addgate.png"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:1 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
     XCTAssertTrue([hbViewController.gateimage.image isEqual:image], @"Wrong image");
}
//sub
-(void)testsubimage{
    UIImage *image;
    image = [UIImage imageNamed:@"subgate.png"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:2 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.gateimage.image isEqual:image], @"Wrong image");
}
//inv
-(void)testInvimage{
    UIImage *image;
    image = [UIImage imageNamed:@"invgate.png"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:3 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.gateimage.image isEqual:image], @"Wrong image");
}
//and
-(void)testAndimage{
    UIImage *image;
    image = [UIImage imageNamed:@"andgate.png"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:4 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.gateimage.image isEqual:image], @"Wrong image");
}
//or
-(void)testOrimage{
    UIImage *image;
    image = [UIImage imageNamed:@"orgate.png"];
    NSIndexPath *selectedIndexPath= [NSIndexPath indexPathForRow:5 inSection:0];
    [hbViewController tableView:hbViewController.MenuTableViewList didSelectRowAtIndexPath:selectedIndexPath];
    XCTAssertTrue([hbViewController.gateimage.image isEqual:image], @"Wrong image");
}
@end
