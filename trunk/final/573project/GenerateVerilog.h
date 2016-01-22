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
#import "gateinformation.h"

@interface GeneralVerilog : UIViewController

{
    //file handler
    NSFileManager *FileManager;
    
    //define document path
    NSString *sDocPath;
    
    //verilog file name
    NSString *svrlgName;
    NSString *sVrlgFileName;
    
    //write model
    
    NSString *sfirstLine;
    
    //write part
    NSString *sInputa;
    NSString *sInputb;
    NSString *sOutPut;
    //NSString *sWireName;
    NSString *sWire;
    NSString *sWrtCmpnnt;
    NSString *sWrieInput;
    NSString *sWireOutput;
    NSString *sWrtWire; // write wire
    
    //write reg
    NSString *sWrtReg;
    
    NSString *sInputString;
    NSString *sInputStringtwo;
    NSString *sOutputString;
    NSString *sWireString;
    NSString *sOutputSt;
    NSString *sInputSt;
    
    
    //set bits
    NSString *sSetBits;
    
    //set symbol
    NSString *sAdd;
    NSString *sSub;
    NSString *sEqu;
    NSString *sSemicolon;
    NSString *sAnd;
    NSString *sOr;
    NSString *sInv;
    NSString *sComma;
    
    //get wire output, input
    NSString *sWrInput;
    NSString *sWrOutput;
    NSString *sWrName;
    
    //text view string
    NSString *sTextWiewShow;
    NSString *sTestCmpnnt;
    int T;

}
@property (nonatomic, strong) NSFileHandle *verilogfileHandle;
@property (nonatomic, strong) NSMutableArray *CmpnntNm;
@property (nonatomic, strong) NSString *sVrlgFileName;
@property (nonatomic, strong) NSString *sDocPath;
@property (nonatomic, strong) NSString *sModule;;
@property (strong, nonatomic) IBOutlet UITextView *VerilogView;
@property UIAlertView *alert;

@property (nonatomic, weak)IBOutlet UIButton *Back;
-(IBAction)Backtap:(id)sender;
-(void)GnrtVrlgFirst;
-(void)GnrtVrlgSecond;
@end

