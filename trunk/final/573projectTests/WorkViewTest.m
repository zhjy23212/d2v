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

@interface WorkViewTest : XCTestCase{
    @private
    UIStoryboard *board;
    workViewController *workview;
    UIImageView *show;
    NSMutableArray *testarray;
    NSMutableArray *onlygateport;
    NSMutableArray *onlygate;
    UIImageView *c;
    gateinformation *testgate;

}

@end

@implementation WorkViewTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //test gate array
    gateinformation *gate=[[gateinformation alloc]init];
    NSString *teststr;
    NSMutableArray *output;
    output = [[NSMutableArray alloc]init];
    
    testarray = [[NSMutableArray alloc]init];
    onlygate = [[NSMutableArray alloc]init];
    onlygateport = [[NSMutableArray alloc]init];
    for (int row =0 ; row<9; row++) {
        gate=[[gateinformation alloc]init];
        if(row==0){
            
            show.image=[UIImage imageNamed:@"input1.png"];
            [gate setimage:show];
            [gate setgate:@"input"];
            [gate setout:@"A"];
            [gate setInputValue:5];
            
            teststr = @"I";
            [output addObject:teststr];
            [gate setOutputconnect:output];
            output = [[NSMutableArray alloc]init];
            
            [testarray addObject:gate];
        }else if(row==1){
            
            show.image=[UIImage imageNamed:@"invgate1.png"];
            [gate setimage:show];
            
            [gate setgate:@"inv"];
            [gate setout:@"B"];
            [gate setina:@"C"];
            [gate setInputaconnect:@"I"];
            
            teststr = @"J";
            [output addObject:teststr];
            [gate setOutputconnect:output];
            output = [[NSMutableArray alloc]init];
            
            [testarray addObject:gate];
        }else if (row == 2){
            
            show.image=[UIImage imageNamed:@"subgate.png"];
            [gate setimage:show];
            
            [gate setgate:@"sub"];
            [gate setout:@"D"];
            [gate setina:@"E"];
            [gate setinb:@"F"];
            [gate setInputaconnect:@"K"];
            [gate setInputbconnect: @"J"];
            
            teststr = @"L";
            [output addObject:teststr];
            [gate setOutputconnect:output];
            output = [[NSMutableArray alloc]init];
            
            [testarray addObject:gate];
        }else if (row == 3){
            
            show.image=[UIImage imageNamed:@"input1.png"];
            [gate setimage:show];
            [gate setInputValue:7];
            [gate setgate:@"input"];
            [gate setout:@"G"];
            
            teststr = @"K";
            [output addObject:teststr];
            [gate setOutputconnect:output];
            output = [[NSMutableArray alloc]init];
            
            [testarray addObject:gate];
        }else if (row==4){
            
            show.image=[UIImage imageNamed:@"output1.png"];
            [gate setimage:show];
            
            [gate setgate:@"output"];
            [gate setina:@"H"];
            [gate setInputaconnect:@"L"];
            [testarray addObject:gate];
        }
        else if (row == 5){
            [gate setgate:@"wire"];
            [gate setina:@"A"];
            [gate setinb:@"C"];
            [gate setwire:@"I"];
            [testarray addObject:gate];
        }
        else if (row == 6){
            [gate setgate:@"wire"];
            [gate setina:@"B"];
            [gate setinb:@"F"];
            [gate setwire:@"J"];
            [testarray addObject:gate];
        }
        else if (row == 7){
            [gate setgate:@"wire"];
            [gate setina:@"G"];
            [gate setinb:@"E"];
            [gate setwire:@"K"];
            [testarray addObject:gate];
        }
        else if (row == 8){
            [gate setgate:@"wire"];
            [gate setina:@"D"];
            [gate setinb:@"H"];
            [gate setwire:@"L"];
            [testarray addObject:gate];
        }
        
        
        //test array
        board = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        workview = [board instantiateViewControllerWithIdentifier:@"WorkView"];
        
        //test value use
        for(gateinformation *allgate in testarray){
            if([[allgate getgatetype] isEqualToString:@"wire"]){
                continue;
            }
            
            if ([[allgate getgatetype] isEqualToString:@"input"] || [[allgate getgatetype] isEqualToString:@"output"]) {

                
                [onlygateport addObject:allgate];
                
            }else{
                
                [onlygate addObject:allgate];
                [onlygateport addObject:allgate];
                
            }
            
        }
        
        
    }
}
-(void)testInputValue1{
    testgate = testarray[0];
    XCTAssertTrue([testgate getValue] == 5,@"Input value not correct.");
}

-(void)testInputValue2{
    testgate = testarray[3];
    XCTAssertTrue([testgate getValue] == 7,@"Input value not correct.");
}


-(void)testOutputValue{
    [processingGate getLatency:onlygate];
    [processingGate FinalCalculateAllOfValue:onlygateport];
    testgate = onlygateport[4];
    XCTAssertTrue(testgate.compValue == 0,@"Output value not correct.");
}

-(void)testConnect1{
    testgate = testarray[0];
    XCTAssertTrue([[testgate getoutput]isEqualToString:@"A"],@"Gate not connect well.");
}

-(void)testConnect2{
    testgate = testarray[1];
    XCTAssertTrue([[testgate getoutput]isEqualToString:@"B"]&&[[testgate getinputa]isEqualToString:@"C"]&&[[testgate getinputaconnect]isEqualToString:@"I"],@"Gate not connect well.");
}

-(void)testConnect3{
    testgate = testarray[2];
    XCTAssertTrue([[testgate getoutput]isEqualToString:@"D"]&&[[testgate getinputa]isEqualToString:@"E"]&&[[testgate getinputb]isEqualToString:@"F"]&&[[testgate getinputaconnect]isEqualToString:@"K"]&&[[testgate getinputbconnect]isEqualToString:@"J"],@"Gate not connect well.");
}

-(void)testConnect4{
    testgate = testarray[3];
    XCTAssertTrue([[testgate getoutput]isEqualToString:@"G"],@"Gate not connect well.");
}

-(void)testConnect5{
    testgate = testarray[4];
    XCTAssertTrue([[testgate getinputa]isEqualToString:@"H"],@"Gate not connect well.");
}

-(void)testConnect6{
    testgate = testarray[5];
    XCTAssertTrue([[testgate getinputa]isEqualToString:@"A"]&&[[testgate getinputb]isEqualToString:@"C"],@"Gate not connect well.");
}
-(void)testConnect7{
    testgate = testarray[6];
    XCTAssertTrue([[testgate getinputa]isEqualToString:@"B"]&&[[testgate getinputb]isEqualToString:@"F"],@"Gate not connect well.");
}
-(void)testConnect8{
    testgate = testarray[7];
    XCTAssertTrue([[testgate getinputa]isEqualToString:@"G"]&&[[testgate getinputb]isEqualToString:@"E"],@"Gate not connect well.");
}
-(void)testConnect9{
    testgate = testarray[8];
    XCTAssertTrue([[testgate getinputa]isEqualToString:@"D"]&&[[testgate getinputb]isEqualToString:@"H"],@"Gate not connect well.");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testTable {
    
    [workview view];
    XCTAssertTrue(workview.table.hidden,@"Gate Table does not hide.");
    
    
}

- (void)testGate {
    
    [workview view];
    XCTAssertTrue(workview.gate.hidden,@"Gate button does not hide.");
    
    
}
- (void)testEdit {
    
    [workview view];
    XCTAssertFalse(workview.edit.hidden,@"Edit button need display!");
    
    
}

- (void)testVerilog {
    
    [workview view];
    XCTAssertTrue(workview.verilog.hidden,@"Verilog button does not hide.");
    
    
}

- (void)testDeleteFunction{
    
    testarray = [[NSMutableArray alloc]init];
    XCTAssertTrue([testarray count] == 0,@"Board delete not corretly.");

}

- (void)testComponentInputImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"input1.png"];
    c.image=[UIImage imageNamed:@"input1.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}

- (void)testComponentInvImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"invgate1.png"];
    c.image=[UIImage imageNamed:@"invgate1.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}

- (void)testComponentOutputImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"output1.png"];
    c.image=[UIImage imageNamed:@"output1.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}

- (void)testComponentAndImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"andgate1.png"];
    c.image=[UIImage imageNamed:@"andgate1.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}

- (void)testComponentOrImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"orgate.png"];
    c.image=[UIImage imageNamed:@"orgate.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}
- (void)testComponentAddImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"addgate.png"];
    c.image=[UIImage imageNamed:@"addgate.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}
- (void)testComponentSubImg {
    
    testgate=[[gateinformation alloc]init];
    show.image=[UIImage imageNamed:@"subgate.png"];
    c.image=[UIImage imageNamed:@"subgate.png"];
    [testgate setimage:show];
    show = [testgate getimage];
    XCTAssertTrue(c == show, @"Wrong image");
    
}




- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
