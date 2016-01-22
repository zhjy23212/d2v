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
#import "workViewController.h"
#import "GenerateVerilog.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "gateinformation.h"
@interface GenerateVerilogTest : XCTestCase
{
	@private
    AppDelegate *app_delegate;
    GeneralVerilog *GeneralVerilogController;
    UIView *GenerateView;
    
    NSMutableArray *testarray;
    NSMutableArray *testarrayaddandor;

}
@end

@implementation GenerateVerilogTest

- (void)setUp {
    [super setUp];
    app_delegate         = [[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GeneralVerilogController = [storyboard instantiateViewControllerWithIdentifier:@"GenerateView"];
    GenerateView = GeneralVerilogController.view;
    
    //set multiple array components inv sub
    gateinformation *gate=[[gateinformation alloc]init];
    testarray=[[NSMutableArray alloc]init];
    for (int row =0 ; row<9; row++) {
        gate=[[gateinformation alloc]init];
        if(row==0){
            [gate setgate:@"input"];
            [gate setout:@"A"];
            [testarray addObject:gate];
        }else if(row==1){
            [gate setgate:@"inv"];
            [gate setout:@"B"];
            [gate setina:@"C"];
            [gate setInputaconnect:@"I"];
            [testarray addObject:gate];
        }else if (row == 2){
            [gate setgate:@"sub"];
            [gate setout:@"D"];
            [gate setina:@"E"];
            [gate setinb:@"F"];
            [gate setInputaconnect:@"K"];
            [gate setInputbconnect: @"J"];
            [testarray addObject:gate];
        }else if (row == 3){
            [gate setgate:@"input"];
            [gate setout:@"G"];
            [testarray addObject:gate];
        }else if (row==4){
            [gate setgate:@"output"];
            [gate setina:@"H"];
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
            [gate setina:@"H"];
            [gate setinb:@"D"];
            [gate setwire:@"L"];
            [testarray addObject:gate];
        }
        
        //set
        gateinformation *gate2=[[gateinformation alloc]init];
        testarrayaddandor =[[NSMutableArray alloc]init];
        for (int row =0 ; row<13; row++) {
            gate2=[[gateinformation alloc]init];
            if(row==0){
                [gate2 setgate:@"input"];
                [gate2 setout:@"A"];
                [testarrayaddandor addObject:gate2];
            }else if(row==1){
                [gate2 setgate:@"add"];
                [gate2 setout:@"B"];
                [gate2 setina:@"C"];
                [gate2 setinb:@"D"];
                [testarrayaddandor addObject:gate2];
            }else if (row == 2){
                [gate2 setgate:@"and"];
                [gate2 setout:@"E"];
                [gate2 setina:@"F"];
                [gate2 setinb:@"G"];
                [testarrayaddandor addObject:gate2];
            }else if (row == 3){
                [gate2 setgate:@"or"];
                [gate2 setina:@"I"];
                [gate2 setinb:@"J"];
                [gate2 setout:@"H"];
                [testarrayaddandor addObject:gate2];
            }else if (row==4){
                [gate2 setgate:@"output"];
                [gate2 setina:@"K"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 5){
                [gate2 setgate:@"input"];
                [gate2 setout:@"L"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 6){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"A"];
                [gate2 setinb:@"D"];
                [gate2 setwire:@"M"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 7){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"L"];
                [gate2 setinb:@"C"];
                [gate2 setwire:@"N"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 8){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"B"];
                [gate2 setinb:@"G"];
                [gate2 setwire:@"O"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 9){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"L"];
                [gate2 setinb:@"F"];
                [gate2 setwire:@"P"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 10){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"E"];
                [gate2 setinb:@"J"];
                [gate2 setwire:@"Q"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 11){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"L"];
                [gate2 setinb:@"I"];
                [gate2 setwire:@"R"];
                [testarrayaddandor addObject:gate2];
            }
            else if (row == 12){
                [gate2 setgate:@"wire"];
                [gate2 setina:@"K"];
                [gate2 setinb:@"H"];
                [gate2 setwire:@"S"];
                [testarrayaddandor addObject:gate2];
            }
    }
   
}
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

// test creat Verilog File
- (void)testCreatVerilogFile{
    /*NSFileManager *fileManager=[[NSFileManager alloc] init];
    NSError *error;
     if ([fileManager fileExistsAtPath:GeneralVerilogController.sDocPath])
     {
     [fileManager removeItemAtPath:GeneralVerilogController.sDocPath error:&error];
     }*/
    [GeneralVerilogController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:GeneralVerilogController.sVrlgFileName], @"failed Creat Verilog File");
}


-(void)testtextview{
    XCTAssertNotNil(GeneralVerilogController.VerilogView, "Verilog View is nil");
}

-(void)testverilogfile{
    XCTAssertNotNil(GeneralVerilogController.sVrlgFileName, "Verilog file is not nil");
}

-(void)testResult{
    NSString* fileContents = [NSString stringWithContentsOfFile:GeneralVerilogController.sVrlgFileName
                              encoding:NSUTF8StringEncoding error:nil];
    XCTAssertNotNil(fileContents, "The verilog file content is nil");
}

//test Text View content, with inv and sub components
-(void)testTextViewContentinvsub{
    GeneralVerilogController.CmpnntNm = [[NSMutableArray alloc]init];
    GeneralVerilogController.CmpnntNm=testarray;
    [GeneralVerilogController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [GeneralVerilogController GnrtVrlgFirst];
    //[GeneralVerilogController GnrtVrlgSecond];
    NSString *teststring;
    teststring = @"A,G,H); \ninput [0:7] A,G; \ninput clk;\noutput reg [0:7] H; \nreg [0:7] C,B,E,F,D,I,J,K,L; \nalways @(posedge clk)\nbegin\n	I<=A; \n	C<=I; \n	B<=~C; \n	J<=B; \n	F<=J; \n	D<=E-F; \n	K<=G; \n	E<=K; \n	L<=D; \n	H<=L; \nend\nendmodule\n";
    NSString *test;
    test= [GeneralVerilogController.sModule stringByAppendingString:teststring];
    XCTAssertTrue([GeneralVerilogController.VerilogView.text isEqualToString:test ], "Verilog text wrong");
}

//test Verilog file content, with inv and sub components
-(void)testVerilogFileContextinvsub{
 GeneralVerilogController.CmpnntNm = [[NSMutableArray alloc]init];
 GeneralVerilogController.CmpnntNm=testarray;
 [GeneralVerilogController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
 [GeneralVerilogController GnrtVrlgFirst];
 NSString *TestContent = [NSString stringWithContentsOfFile:GeneralVerilogController.sVrlgFileName encoding:NSUTF8StringEncoding error:nil];
 //[GeneralVerilogController GnrtVrlgSecond];
 NSString *teststring;
 teststring = @"A,G,H); \ninput [0:7] A,G; \ninput clk;\nreg [0:7] C,B,E,F,D,I,J,K,L; \noutput reg [0:7] H; \nalways @(posedge clk)\nbegin\n	I<=A; \n	C<=I; \n	B<=~C; \n	J<=B; \n	F<=J; \n	D<=E-F; \n	K<=G; \n	E<=K; \n	L<=D; \n	H<=L; \nend\nendmodule\n";
 NSString *test;
 test= [GeneralVerilogController.sModule stringByAppendingString:teststring];
 
 XCTAssertTrue([TestContent isEqualToString:test ], "Verilog text wrong");
}

//test Text View content, with add, and, and or components
-(void)testTextViewContentaddandor{
    //[GeneralVerilogController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    [GeneralVerilogController viewDidLoad];
    GeneralVerilogController.CmpnntNm = [[NSMutableArray alloc]init];
    GeneralVerilogController.VerilogView.text = nil;
    GeneralVerilogController.CmpnntNm=testarrayaddandor;
    [GeneralVerilogController GnrtVrlgFirst];
    NSString *teststring;
    teststring = @"A,L,K); \ninput [0:7] A,L; \ninput clk;\noutput reg [0:7] K; \nreg [0:7] C,D,B,F,G,E,I,J,H,M,N,O,P,Q,R,S; \nalways @(posedge clk)\nbegin\n	M<=A; \n	D<=M; \n	B<=C+D; \n	O<=B; \n	G<=O; \n	E<=F&G; \n	Q<=E; \n	J<=Q; \n	H<=I|J; \n	S<=H; \n	K<=S; \n	N<=L; \n	C<=N; \n	P<=L; \n	F<=P; \n	R<=L; \n	I<=R; \nend\nendmodule\n";
    NSString *test;
    test= [GeneralVerilogController.sModule stringByAppendingString:teststring];
    XCTAssertTrue([GeneralVerilogController.VerilogView.text isEqualToString:test ], "Verilog text wrong");
}
//test verilog file content, with add, and, and or components
-(void)testVerilogFileContextaddandor{
    GeneralVerilogController.CmpnntNm = [[NSMutableArray alloc]init];
    GeneralVerilogController.CmpnntNm=testarrayaddandor;
    [GeneralVerilogController performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    NSError *error;
    if([[NSFileManager defaultManager] fileExistsAtPath:GeneralVerilogController.sVrlgFileName]){
    [[NSFileManager defaultManager] removeItemAtPath:GeneralVerilogController.sVrlgFileName error:&error];
    }
    [GeneralVerilogController viewDidLoad];
    //[GeneralVerilogController GnrtVrlgFirst];
    NSString *TestContent = [NSString stringWithContentsOfFile:GeneralVerilogController.sVrlgFileName encoding:NSUTF8StringEncoding error:nil];
    //[GeneralVerilogController GnrtVrlgSecond];
    NSString *teststring;
    teststring = @"A,L,K); \ninput [0:7] A,L; \ninput clk;\nreg [0:7] C,D,B,F,G,E,I,J,H,M,N,O,P,Q,R,S; \noutput reg [0:7] K; \nalways @(posedge clk)\nbegin\n	M<=A; \n	D<=M; \n	B<=C+D; \n	O<=B; \n	G<=O; \n	E<=F&G; \n	Q<=E; \n	J<=Q; \n	H<=I|J; \n	S<=H; \n	K<=S; \n	N<=L; \n	C<=N; \n	P<=L; \n	F<=P; \n	R<=L; \n	I<=R; \nend\nendmodule\n";
    NSString *test;
    test= [GeneralVerilogController.sModule stringByAppendingString:teststring];
    XCTAssertTrue([TestContent isEqualToString:test ], "Verilog text wrong");
}

@end
