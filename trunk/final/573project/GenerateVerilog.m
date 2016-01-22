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

#import "GenerateVerilog.h"
#import "gateinformation.h"
#import "fileViewController.h"
#import  "workViewController.h"
@interface GeneralVerilog()


@end

@implementation GeneralVerilog
@synthesize CmpnntNm;
@synthesize sVrlgFileName;
@synthesize alert;
@synthesize sDocPath;
@synthesize VerilogView;
@synthesize sModule;
- (void)viewDidLoad {
    [super viewDidLoad];
    //init symbol,bits
    sAnd = @"&";
    sSub = @"-";
    sEqu = @"<=";
    sAdd = @"+";
    sOr = @"|";
    sInv = @"~";
    sSemicolon = @"; \n";
    sTextWiewShow = @"";
    sComma = @",";
    sSetBits = @"[0:7] ";
    
    //gateinformation *gateobjct=[[gateinformation alloc]init];
	//verilog file creat
    NSDate *Date=[NSDate date];   //get date to create a full name
    //file name format1
    NSDateFormatter *format1=[[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"dd_MM_yyyy_HH_mm_ss"];
    NSString *DateStr=[format1 stringFromDate:Date];
    svrlgName= [@"Verilog" stringByAppendingString:DateStr];
    svrlgName = [svrlgName stringByAppendingString:@".v"];
    sDocPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    sVrlgFileName = [sDocPath stringByAppendingPathComponent:svrlgName];
    //if (![[NSFileManager defaultManager] fileExistsAtPath:sVrlgFileName]){
    [[NSFileManager defaultManager]createFileAtPath:sVrlgFileName contents:nil attributes:nil];
    //}
    self.verilogfileHandle = [NSFileHandle fileHandleForWritingAtPath:sVrlgFileName];
    NSLog(@"%lu", (unsigned long)[[self CmpnntNm] count]);
    T = 0; //init Test integrate
    // Do any additional setup after loading the view.
    for (gateinformation *firstnum in CmpnntNm) {
        sTestCmpnnt = [firstnum gatetype];
	    if ([sTestCmpnnt  isEqualToString:@"add"]){
            T = 1;
        }
        else if ([sTestCmpnnt  isEqualToString:@"sub"]){
            T = 1;
        }
        else if ([sTestCmpnnt  isEqualToString:@"inv"]){
            T = 1;
        }
        else if([sTestCmpnnt isEqualToString:@"or"]){
            T = 1;
        }
        else if ([sTestCmpnnt isEqualToString:@"and"]){
            T = 1;
        }
    }
    if ([CmpnntNm count] == 0){
        NSString *AlerttitleString = @"Working Board Is Empty";
        alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:  AlerttitleString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
    }
    else if(T==0){
        NSString *AlerttitleString = @"Need Other Components";
        alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:  AlerttitleString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
    }
    else {
    	[self GnrtVrlgFirst];
    }
    
}
- (IBAction)Backtap:(id)sender {
    NSLog(@"Show Work View");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//for module input, output, reg
-(void)GnrtVrlgFirst{
    //set input, output, wire
    NSString *sIn = @"input ";
    NSString *sOut = @"output ";
    NSString *sReg = @"reg ";
    //NSString *sWr = @"wire ";
    NSString *sclk = @"clk;\n";
    sOutputSt = @"";
    sInputSt = @"";
    NSString *svrlgNameSub;
    svrlgNameSub = svrlgName;
    svrlgNameSub = [svrlgNameSub stringByDeletingPathExtension];
    sModule = @"module ";
    sModule = [sModule stringByAppendingString: svrlgNameSub];
    sModule = [sModule stringByAppendingString:@" (clk,"];
    sInputString = [NSString stringWithFormat:@"%@%@", sIn, sSetBits];
    sInputStringtwo = [NSString stringWithFormat:@"%@%@", sIn, sclk];
    sWireString = [NSString stringWithFormat:@"%@%@", sReg, sSetBits];
    sOutputString = [NSString stringWithFormat:@"%@%@%@", sOut, sReg, sSetBits];
    //find input and output for module, input, output, reg
    for (gateinformation *firstnum in CmpnntNm) {
        sWrtCmpnnt = [firstnum gatetype];
        if ([sWrtCmpnnt  isEqualToString:@"output"]) {
            sOutPut = [firstnum getinputa];
            sOutputString = [sOutputString stringByAppendingString:sOutPut];
            sOutputString = [sOutputString stringByAppendingString:sComma];
            sOutputSt = [sOutputSt stringByAppendingString:sOutPut];
            sOutputSt = [sOutputSt stringByAppendingString:sComma];
        }
        else if ([sWrtCmpnnt  isEqualToString:@"input"]){
            sInputa = [firstnum getoutput];
            sInputString = [sInputString stringByAppendingString:sInputa];
            sInputString = [sInputString stringByAppendingString:sComma];
            sInputSt = [sInputSt stringByAppendingString:sInputa];
            sInputSt = [sInputSt stringByAppendingString:sComma];
        }
        else if ([sWrtCmpnnt  isEqualToString:@"add"]){
            sInputa = [firstnum getinputa];
            sInputb = [firstnum getinputb];
            sOutPut = [firstnum getoutput];
            sWireString = [sWireString stringByAppendingString:sInputa];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sInputb];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sOutPut];
            sWireString = [sWireString stringByAppendingString:sComma];
        }
        else if ([sWrtCmpnnt  isEqualToString:@"sub"]){
            sInputa = [firstnum getinputa];
            sInputb = [firstnum getinputb];
            sOutPut = [firstnum getoutput];
            sWireString = [sWireString stringByAppendingString:sInputa];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sInputb];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sOutPut];
            sWireString = [sWireString stringByAppendingString:sComma];
        }
        else if ([sWrtCmpnnt  isEqualToString:@"inv"]){
            sInputa = [firstnum getinputa];
            sOutPut = [firstnum getoutput];
            sWireString = [sWireString stringByAppendingString:sInputa];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sOutPut];
            sWireString = [sWireString stringByAppendingString:sComma];
        }
        else if([sWrtCmpnnt isEqualToString:@"or"]){
            sInputa = [firstnum getinputa];
            sInputb = [firstnum getinputb];
            sOutPut = [firstnum getoutput];
            sWireString = [sWireString stringByAppendingString:sInputa];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sInputb];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sOutPut];
            sWireString = [sWireString stringByAppendingString:sComma];
        }
        else if ([sWrtCmpnnt isEqualToString:@"and"]){
            sInputa = [firstnum getinputa];
            sInputb = [firstnum getinputb];
            sOutPut = [firstnum getoutput];
            sWireString = [sWireString stringByAppendingString:sInputa];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sInputb];
            sWireString = [sWireString stringByAppendingString:sComma];
            sWireString = [sWireString stringByAppendingString:sOutPut];
            sWireString = [sWireString stringByAppendingString:sComma];
        }
        else if ([sWrtCmpnnt isEqualToString:@"wire"]){
            sWrName = [firstnum getwire];
            sWireString = [sWireString stringByAppendingString:sWrName];
            sWireString = [sWireString stringByAppendingString:sComma];
        }
    }
    //reduce the comma
    sInputString=[sInputString substringToIndex:[sInputString length] - 1];
    sOutputString = [sOutputString substringToIndex:[sOutputString length] - 1];
    sWireString = [sWireString substringToIndex:[sWireString length]-1];
    //add semicolon
    sInputString = [sInputString stringByAppendingString:sSemicolon];
    sOutputString = [sOutputString stringByAppendingString:sSemicolon];
    sWireString = [sWireString stringByAppendingString:sSemicolon];
    //revise for module
    sOutputSt = [sOutputSt substringToIndex:[sOutputSt length] - 1];
    sOutputSt = [sOutputSt stringByAppendingString:@")"];
    sOutputSt = [sOutputSt stringByAppendingString:sSemicolon];
    NSString *sAlways = @"always @(posedge clk)\n";
    //NSString *sCutInput = sInputSt;
    //sCutInput = [sCutInput substringToIndex:[sCutInput length] - 1];
    //sAlways = [sAlways stringByAppendingString:sCutInput];
    //sAlways = [sAlways stringByAppendingString:@")\n"];
    sfirstLine = [NSString stringWithFormat:@"%@%@%@", sModule, sInputSt, sOutputSt];
    sTextWiewShow = sfirstLine;
    [self.verilogfileHandle writeData:[sfirstLine dataUsingEncoding:NSUTF8StringEncoding]];
    [self.verilogfileHandle writeData:[sInputString dataUsingEncoding:NSUTF8StringEncoding]];
    [self.verilogfileHandle writeData:[sInputStringtwo dataUsingEncoding:NSUTF8StringEncoding]];
    [self.verilogfileHandle writeData:[sWireString dataUsingEncoding:NSUTF8StringEncoding]];
    [self.verilogfileHandle writeData:[sOutputString dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *second = [NSString stringWithFormat:@"%@%@%@%@",sInputString, sInputStringtwo, sOutputString, sWireString];
    sTextWiewShow = [sTextWiewShow stringByAppendingString:second];
    sTextWiewShow = [sTextWiewShow stringByAppendingString:sAlways];
    NSString *sBegin = @"begin\n";
    sTextWiewShow = [sTextWiewShow stringByAppendingString:sBegin];
    [self.verilogfileHandle writeData:[sAlways dataUsingEncoding:NSUTF8StringEncoding]];
    [self.verilogfileHandle writeData:[sBegin dataUsingEncoding:NSUTF8StringEncoding]];
    [self GnrtVrlgSecond];
}

-(void)GnrtVrlgSecond{
    //for wire all set output
    for (gateinformation *inum in CmpnntNm) {
        sWrtCmpnnt = [inum gatetype];
        
        if ([sWrtCmpnnt  isEqualToString:@"add"]){
            sInputa = [inum getinputa];
            sInputb = [inum getinputb];
            sOutPut = [inum getoutput];
            sWrtCmpnnt = [NSString stringWithFormat:@"	%@%@%@%@%@%@", sOutPut, sEqu, sInputa, sAdd, sInputb, sSemicolon];
            /*NSString *sFirst = [sOutPut stringByAppendingString: sEqu];
            NSString *sSecond = [sFirst stringByAppendingString:sInputa];
            NSString *sThird = [sSecond stringByAppendingString:sAnd];
            NSString *sFourth = [sThird stringByAppendingString:sInputb];
            NSString *sFifth = */
            sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtCmpnnt];
            [self.verilogfileHandle writeData:[sWrtCmpnnt dataUsingEncoding:NSUTF8StringEncoding]];
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sOutPut isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrInput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrOutput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
        }
        else if ([sWrtCmpnnt isEqualToString:@"input"]){
            sOutPut = [inum getoutput];
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sOutPut isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrInput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrOutput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
        }
        else if([sWrtCmpnnt  isEqualToString:@"inv"]){
            sInputa = [inum getinputa];
            sOutPut = [inum getoutput];
            sWrtCmpnnt = [NSString stringWithFormat:@"	%@%@%@%@%@", sOutPut, sEqu, sInv, sInputa, sSemicolon];
            sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtCmpnnt];
            [self.verilogfileHandle writeData:[sWrtCmpnnt dataUsingEncoding:NSUTF8StringEncoding]];
            
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sOutPut isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrInput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrOutput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
        }
        else if ([sWrtCmpnnt isEqualToString:@"sub"]){
            sInputa = [inum getinputa];
            sInputb = [inum getinputb];
            sOutPut = [inum getoutput];
            sWrtCmpnnt = [NSString stringWithFormat:@"	%@%@%@%@%@%@", sOutPut, sEqu, sInputa, sSub, sInputb, sSemicolon];
            sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtCmpnnt];
            [self.verilogfileHandle writeData:[sWrtCmpnnt dataUsingEncoding:NSUTF8StringEncoding]];
            
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sOutPut isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrInput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrOutput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
        }
        else if([sWrtCmpnnt isEqualToString:@"or"]){
            sInputa = [inum getinputa];
            sInputb = [inum getinputb];
            sOutPut = [inum getoutput];
            sWrtCmpnnt = [NSString stringWithFormat:@"	%@%@%@%@%@%@", sOutPut, sEqu, sInputa, sOr, sInputb, sSemicolon];
            sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtCmpnnt];
            [self.verilogfileHandle writeData:[sWrtCmpnnt dataUsingEncoding:NSUTF8StringEncoding]];
            
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sOutPut isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrInput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrOutput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
        }
        else if([sWrtCmpnnt isEqualToString:@"and"]){
            sInputa = [inum getinputa];
            sInputb = [inum getinputb];
            sOutPut = [inum getoutput];
            sWrtCmpnnt = [NSString stringWithFormat:@"	%@%@%@%@%@%@", sOutPut, sEqu, sInputa, sAnd, sInputb, sSemicolon];
            sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtCmpnnt];
            [self.verilogfileHandle writeData:[sWrtCmpnnt dataUsingEncoding:NSUTF8StringEncoding]];
            
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sOutPut isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrInput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrOutput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
    	}
        else if ([sWrtCmpnnt isEqualToString:@"output"]){
            sInputa = [inum getinputa];
            for (gateinformation *secondnum in CmpnntNm) {
                sWrtWire = [secondnum gatetype];
                if ([sWrtWire isEqualToString:@"wire"]) {
                    sWrInput = [secondnum getinputa];
                    sWrOutput = [secondnum getinputb];
                    sWrName = [secondnum getwire];
                    if ([sInputa isEqualToString:sWrInput]) {
                        sWrtReg =  [NSString stringWithFormat:@"	%@%@%@%@", sWrName, sEqu, sWrOutput, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                        sWrtReg = [NSString stringWithFormat:@"	%@%@%@%@", sWrInput, sEqu, sWrName, sSemicolon];
                        sTextWiewShow = [sTextWiewShow stringByAppendingString:sWrtReg];
                        [self.verilogfileHandle writeData:[sWrtReg dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
            }
        }

    }
    NSString *end = @"end\nendmodule\n";
    [self.verilogfileHandle writeData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    sTextWiewShow = [sTextWiewShow stringByAppendingString:end];
    //for text view
    self.VerilogView.text = sTextWiewShow;
    [VerilogView setFont:[UIFont boldSystemFontOfSize:15]];
}



@end


