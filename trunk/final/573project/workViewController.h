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
#import "processingGate.h"


int gatex;
int gatey;

@interface workViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    int x,y;
   
    UIImageView *show;
    UILabel *showlabel,*showlabel2,*showlabel3;

}

@property (nonatomic, weak)IBOutlet UIButton *verilog;
-(IBAction)verilogtap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *gate;

@property (weak, nonatomic) IBOutlet UIButton *file;
- (IBAction)filetap:(id)sender;

- (IBAction)fortest:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *deletgate;
@property (weak, nonatomic) IBOutlet UIButton *edit;

- (IBAction)tapdelete:(id)sender;
@property(copy,nonatomic) NSArray *gatearray;
@property (weak, nonatomic) IBOutlet UIButton *connect;
- (IBAction)connecttap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *testbutton;

@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)gatetap:(id)sender;
- (IBAction)edittap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *done;
- (IBAction)donetap:(id)sender;

@end
