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

#import "workViewController.h"
#import "gateinformation.h"
#import "processingGate.h"
#import "GenerateVerilog.h"


@interface workViewController ()




@end




@implementation workViewController{
    int arraynumber;
    int commandtype,force;
    int gatenumber;
    char a;
    NSMutableArray *gategroup;
    NSMutableArray *labelgroup;
    NSMutableArray *wiregroup;
    NSMutableArray *onlygate;
    NSMutableArray *onlygateport;
    NSMutableArray *inputValue;
    NSMutableArray *inputgate;
    NSMutableArray *outputgate;
    NSMutableArray *outputlabel;
    NSMutableArray *inputcopy;
    NSMutableArray *outputcopy;
    NSMutableArray *latencylabel;
    NSString *s;
    NSString *ina;
    NSString *inb;
    CGPoint startposition;
    CGPoint endposition;
    NSString *tempLabel;
    UILabel *delaylb;
    NSString *temps;
    
    int checkconnectstart,checkconnectend,checkconnect;
    int inputindex, outputIndex;
    int outputlabelcheck;
    int checkdelay;
    float latency;
    
    NSMutableArray *gateinfo;
    
   
}


@synthesize gate,table,deletgate,done,edit,connect,file,testbutton, verilog;

- (void)viewDidLoad {
    //inital all vaule to the design broad
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gateinfo=[[NSMutableArray alloc]init];
    
    checkconnect=0;
    checkconnectend=0;
    checkconnectstart=0;
    checkdelay = 0;
    outputlabelcheck = 0;
    testbutton.hidden = true;
    connect.hidden = true;
    
    
    force=0;
   
    
    commandtype=0;////0:do nothing      1:edit       2:delete       3:connect
    
    
    self.gatearray=@[@"Input",@"Output",@"Add",@"Sub",@"Inv",@"And",@"Or"];
    x=340;
    y=160;
    gatenumber=1;
    a='A';
    table.hidden=TRUE;
    gategroup=[[NSMutableArray alloc]init];
    
    wiregroup=[[NSMutableArray alloc]init];
    inputcopy = [[NSMutableArray alloc]init];

  
    labelgroup=[[NSMutableArray alloc]init];
    
    onlygate = [[NSMutableArray alloc]init];
    onlygateport = [[NSMutableArray alloc]init];
    inputValue = [[NSMutableArray alloc]init];
    inputgate = [[NSMutableArray alloc]init];
    outputgate = [[NSMutableArray alloc]init];
    outputlabel = [[NSMutableArray alloc]init];
    outputcopy = [[NSMutableArray alloc]init];
    latencylabel = [[NSMutableArray alloc]init];
    
 
    inputindex = 0;
    outputIndex = 0;
    
    done.hidden=true;
    gate.hidden=true;
    verilog.hidden = true;
    delaylb = [[UILabel alloc]initWithFrame:CGRectMake(260, 0, 200, 20)];
    [self.view addSubview:delaylb];
    delaylb.hidden = true;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)gatetap:(id)sender {
    //show the table to create the gate
     table.hidden=false;

}

- (IBAction)edittap:(id)sender {
    //start the edit function
    commandtype=1;
    edit.hidden=true;
    done.hidden=false;
    gate.hidden=false;
    deletgate.hidden=true;
    testbutton.hidden = true;
}
- (IBAction)donetap:(id)sender {
    //compelte the edit or connecton
    commandtype=0;
//  edit.hidden=false;
    deletgate.hidden=false;
    gate.hidden=true;
    connect.hidden=false;
    testbutton.hidden = false;
    force=0;
}

- (IBAction)tapdelete:(id)sender {
    //delete anything on the design broad

}




///table function implement start

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.gatearray count];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //when select file, do action
    arraynumber=(int)indexPath.row;
    return 	indexPath;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *checkidf=@"checkidf";
    UITableViewCell *gatecell=[tableView dequeueReusableCellWithIdentifier:checkidf];
    if(gatecell==nil){
        gatecell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:checkidf];
    }
    gatecell.textLabel.text=self.gatearray[indexPath.row];
    return gatecell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //create the gate and put the gate in the array
    gateinformation *gateobjec=[[gateinformation alloc]init];
    showlabel=nil;
    showlabel2=nil;
    showlabel3=nil;
    NSString* filename=nil;
    
    if (indexPath.row==0) {
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 26, 40)];
        show.image=[UIImage imageNamed:@"input1.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(8, 25, 12, 13)];
        filename=@"input";
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        
        UILabel *tflabel = [[UILabel alloc]initWithFrame:CGRectMake(0, inputindex, 20, 20)];
        NSString *tflabeltext = [NSString stringWithFormat:@"%c:", a];
        tflabel.text = tflabeltext;
        [self.view addSubview:tflabel];
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(20, inputindex, 50, 20)];
        tf.placeholder = @"value";
        tf.backgroundColor = [UIColor grayColor];
        [tf setKeyboardType:UIKeyboardTypeNumberPad];
        tf.enabled = YES;
        [self.view addSubview:tf];
        [labelgroup addObject:showlabel];
        [inputValue addObject:tf];
        
        
        inputindex = inputindex + 25;
        
        
        a++;
       
        
        
    }else if (indexPath.row==1){
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 26, 40)];
        show.image=[UIImage imageNamed:@"output1.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(8, 25, 12, 13)];
        filename=@"output";
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(75, outputIndex, 180, 20)];
        
       // lb.backgroundColor = [UIColor blueColor];
        lb.text = s;
        
        
        [self.view addSubview:lb];
        
        lb.hidden = YES;
        [outputlabel addObject:lb];
        
        outputIndex = outputIndex + 25;
        a++;
        [labelgroup addObject:showlabel];
        
    }else if (indexPath.row==2){
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 72, 52)];
        show.image=[UIImage imageNamed:@"addgate.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(65, -10, 12, 14)];
        showlabel2=[[UILabel alloc]initWithFrame:CGRectMake(-10, 50, 12, 14)];
        showlabel3=[[UILabel alloc]initWithFrame:CGRectMake(-10, -10, 12, 14)];
        filename=@"add";
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel2.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel3.text=s;
        a++;
        [labelgroup addObject:showlabel];
        [labelgroup addObject:showlabel2];
        [labelgroup addObject:showlabel3];
        
        
    }else if (indexPath.row==3){
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 72, 52)];
        show.image=[UIImage imageNamed:@"subgate.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(65, -10, 12, 14)];
        showlabel2=[[UILabel alloc]initWithFrame:CGRectMake(-10, 50, 12, 14)];
        showlabel3=[[UILabel alloc]initWithFrame:CGRectMake(-10, -10, 12, 14)];
        filename=@"sub";
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel2.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel3.text=s;
        a++;
        [labelgroup addObject:showlabel];
        [labelgroup addObject:showlabel2];
        [labelgroup addObject:showlabel3];
        
        
        
    }else if (indexPath.row==4){
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 72, 52)];
        show.image=[UIImage imageNamed:@"invgate1.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(65, -10, 12, 14)];
        showlabel2=[[UILabel alloc]initWithFrame:CGRectMake(-10, 0, 12, 14)];
        filename=@"inv";
       
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel2.text=s;
        a++;
      
        [labelgroup addObject:showlabel];
        [labelgroup addObject:showlabel2];
    
        
        
        
    }else if (indexPath.row==5){
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 72, 52)];
        show.image=[UIImage imageNamed:@"andgate1.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(65, -10, 12, 14)];
        showlabel2=[[UILabel alloc]initWithFrame:CGRectMake(-10, 50, 12, 14)];
        showlabel3=[[UILabel alloc]initWithFrame:CGRectMake(-10, -10, 12, 14)];
        filename=@"and";
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel2.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel3.text=s;
        a++;
        [labelgroup addObject:showlabel];
        [labelgroup addObject:showlabel2];
        [labelgroup addObject:showlabel3];
        
        
    }else if (indexPath.row==6){
        
        show =[[UIImageView alloc]initWithFrame:CGRectMake(x, y, 72, 52)];
        show.image=[UIImage imageNamed:@"orgate1.png"];
        showlabel=[[UILabel alloc]initWithFrame:CGRectMake(65, -10, 12, 14)];
        showlabel2=[[UILabel alloc]initWithFrame:CGRectMake(-10, 50, 12, 14)];
        showlabel3=[[UILabel alloc]initWithFrame:CGRectMake(-10, -10, 12, 14)];
        filename=@"or";
        s = [NSString stringWithFormat:@"%c", a];
        showlabel.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel2.text=s;
        a++;
        s = [NSString stringWithFormat:@"%c", a];
        showlabel3.text=s;
        a++;
        [labelgroup addObject:showlabel];
        [labelgroup addObject:showlabel2];
        [labelgroup addObject:showlabel3];
        
        
        
    }
      //  show.image=[UIImage imageNamed:@"addgate.png"];
    
    show.userInteractionEnabled=YES;
    showlabel.userInteractionEnabled=YES;
    showlabel2.userInteractionEnabled=YES;
    showlabel3.userInteractionEnabled=YES;
    
    
    
    [self.view addSubview:show];
    if(indexPath.row==0 ){
        [show addSubview:showlabel];
        [gateobjec setout:showlabel.text];
    }else if(indexPath.row==1){
        [show addSubview:showlabel];
        [gateobjec setina:showlabel.text];
    
    }else if (indexPath.row==4){
        [show addSubview:showlabel];
        [show addSubview:showlabel2];
        [gateobjec setout:showlabel.text];
        [gateobjec setina:showlabel2.text];
    
    }else{
        [show addSubview:showlabel];
        [show addSubview:showlabel2];
        [show addSubview:showlabel3];
        [gateobjec setout:showlabel.text];
        [gateobjec setina:showlabel2.text];
        [gateobjec setinb:showlabel3.text];
        
        
    }
    
    [gateobjec setgate:filename];
    [gateobjec setgateindex:gatenumber];
    gatenumber++;
    [gateobjec setimage:show];
    [gateinfo addObject:gateobjec];
    [gategroup addObject:show];
    table.hidden=TRUE;
    if([gateinfo count] > 6){
        
        NSString *AlerttitleString = @"This app only support six components!";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:  AlerttitleString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
        commandtype=0;
        deletgate.hidden=false;
        gate.hidden=true;
        connect.hidden=false;
        testbutton.hidden = false;
        force=0;
        
    }
    
}
///table function implement end






//drag function implement start
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches]anyObject];
    int index=(int)[gateinfo count],start;
    UIImageView *img;

  //  NSLog(@"self:%@",[touch view]);
  //  NSLog(@"subviewaaaaaaaaaaaaaaaaaaaaaa:%@",[touch view].subviews);
    if (commandtype==1&&force==0) {////edit gate
        
        for (start=0; start<index; start++) {
            if ([touch view]==[gateinfo[start] getimage]) {
                img=[gateinfo[start] getimage];
                CGPoint location=[touch locationInView:self.view];
                img.center=location;
                
          //      NSLog(@"self:%@",img);
            }
        }
        
        
      
            //    for (UILabel *label in [touch view].subviews){
                    
         //       }
    }
    
    
    
    
    if (force==5) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(10.0, 10.0)];
        [path addLineToPoint:CGPointMake(200.0, 200.0)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
        shapeLayer.lineWidth = 3.0;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
        
        [self.view.layer addSublayer:shapeLayer];
   //     NSLog(@"%@",gategroup[0].subviews);
    }
    
}
//drag function implement end






///connection function implement start
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches]anyObject];
    int index=(int)[gateinfo count],start;
 
    
    CGPoint location=[touch locationInView:self.view];
    NSLog(@"touch:(%f,%f)",location.x,location.y);
    if(index>0){
     NSLog(@"img:(%f,%f)",[gateinfo[0] getimage].center.x,[gateinfo[0] getimage].center.y);
    
    }
    [self.view endEditing:YES];
    if (force==1) {
        
        for(UILabel *txt in labelgroup){
            NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
            ///////label 1 to check
            
            for(start=0;start<index;start++){
                
                if (txt.text==[gateinfo[start] getoutput]||txt.text==[gateinfo[start] getinputa]||txt.text==[gateinfo[start] getinputb]) {
                    
                    
                    if (txt.center.x==71) {////ouput for andgate
                        if(((location.x<(50+[gateinfo[start] getimage].center.x+18))&&(location.x>(50+[gateinfo[start] getimage].center.x-18)))&&((location.y<(-3+[gateinfo[start] getimage].center.y+18))&&(location.y>(-3+[gateinfo[start] getimage].center.y-18)))){
                            
                            
                            
                            startposition=CGPointMake([gateinfo[start] getimage].center.x+33, [gateinfo[start] getimage].center.y);
                            
                            
                            ina=txt.text;
                            
                            
                            checkconnectstart=1;
                            NSLog(@"%@",txt.text);
                            //     NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
                            
                        }
                        
                    }else if (txt.center.x==14) {
                        
                        if(((location.x<([gateinfo[start] getimage].center.x+18))&&(location.x>([gateinfo[start] getimage].center.x-18)))&&((location.y<([gateinfo[start] getimage].center.y+18))&&(location.y>([gateinfo[start] getimage].center.y-18)))){
                            checkconnectstart=1;
                            
                            ina=txt.text;
                            NSLog(@"%@",txt.text);
                            startposition=CGPointMake([gateinfo[start] getimage].center.x, [gateinfo[start] getimage].center.y-10);
                            
                        }
                        
                        
                        
                    }else if (txt.center.y==57&&txt.center.x==-4) {////inputa for andgate
                        
                        if(((location.x<(-50+[gateinfo[start] getimage].center.x+18))&&(location.x>(-50+[gateinfo[start] getimage].center.x-18)))&&((location.y<(20+[gateinfo[start] getimage].center.y+18))&&(location.y>(20+[gateinfo[start] getimage].center.y-18)))){
                            checkconnectstart=1;
                            ina=txt.text;
                            NSLog(@"%@",txt.text);
                            startposition=CGPointMake([gateinfo[start] getimage].center.x-35, [gateinfo[start] getimage].center.y+7);
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                    }else if (txt.center.x==-4&&txt.center.y==-3) {///inputb for andgate
                        
                        if(((location.x<(-50+[gateinfo[start] getimage].center.x+18))&&(location.x>(-50+[gateinfo[start] getimage].center.x-18)))&&((location.y<(-25+[gateinfo[start] getimage].center.y+18))&&(location.y>(-25+[gateinfo[start] getimage].center.y-18)))){
                            ina=txt.text;
                            NSLog(@"%@",txt.text);
                            //     NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
                            checkconnectstart=1;
                            
                            startposition=CGPointMake([gateinfo[start] getimage].center.x-35, [gateinfo[start] getimage].center.y-10);
                            
                            
                            
                        }
                        
                    }else if (txt.center.y==7) {///inv input
                        
                        
                        if(((location.x<(-40+[gateinfo[start] getimage].center.x+18))&&(location.x>(-40+[gateinfo[start] getimage].center.x-18)))&&((location.y<(-3+[gateinfo[start] getimage].center.y+18))&&(location.y>(-3+[gateinfo[start] getimage].center.y-18)))){
                            ina=txt.text;
                            NSLog(@"%@",txt.text);
                            //     NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
                            checkconnectstart=1;
                            startposition=CGPointMake([gateinfo[start] getimage].center.x-35, [gateinfo[start] getimage].center.y);
                        }
                        
                    }else{
                        
                        checkconnect=0;
                        checkconnectstart=0;
                        
                    }
                    
                }
                
            }
            
        }
    }
    

    
  //  NSLog(@"%@",[touch view]);

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    
    int index=(int)[gateinfo count],start;
    
    
    CGPoint location=[touch locationInView:self.view];
    
    if (force==1) {
        
        for(UILabel *txt in labelgroup){
            //    NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
            ///////label 1 to check
            
            for(start=0;start<index;start++){
                
                if (txt.text==[gateinfo[start] getoutput]||txt.text==[gateinfo[start] getinputa]||txt.text==[gateinfo[start] getinputb]) {
                    
                    
                    if (txt.center.x==71) {////ouput for andgate
                        if(((location.x<(50+[gateinfo[start] getimage].center.x+18))&&(location.x>(50+[gateinfo[start] getimage].center.x-18)))&&((location.y<(-3+[gateinfo[start] getimage].center.y+18))&&(location.y>(-3+[gateinfo[start] getimage].center.y-18)))){
                            inb=txt.text;
                            
                            
                            endposition=CGPointMake([gateinfo[start] getimage].center.x+33, [gateinfo[start] getimage].center.y);
                            
                            
                            
                            
                            
                            checkconnectend=1;
                            NSLog(@"%@",txt.text);
                            //     NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
                            
                        }
                        
                    }else if (txt.center.x==14) {
                        
                        if(((location.x<([gateinfo[start] getimage].center.x+18))&&(location.x>([gateinfo[start] getimage].center.x-18)))&&((location.y<([gateinfo[start] getimage].center.y+18))&&(location.y>([gateinfo[start] getimage].center.y-18)))){
                            checkconnectend=1;
                            inb=txt.text;
                            NSLog(@"%@",txt.text);
                            endposition=CGPointMake([gateinfo[start] getimage].center.x, [gateinfo[start] getimage].center.y-10);
                            
                        }
                        
                        
                        
                    }else if (txt.center.y==57&&txt.center.x==-4) {////inputa for andgate
                        
                        if(((location.x<(-50+[gateinfo[start] getimage].center.x+18))&&(location.x>(-50+[gateinfo[start] getimage].center.x-18)))&&((location.y<(20+[gateinfo[start] getimage].center.y+18))&&(location.y>(20+[gateinfo[start] getimage].center.y-18)))){
                            checkconnectend=1;
                            inb=txt.text;
                            NSLog(@"%@",txt.text);
                            endposition=CGPointMake([gateinfo[start] getimage].center.x-35, [gateinfo[start] getimage].center.y+7);
                            
                        }
                        
                        
                    }else if (txt.center.x==-4&&txt.center.y==-3) {///inputb for andgate
                        
                        if(((location.x<(-50+[gateinfo[start] getimage].center.x+18))&&(location.x>(-50+[gateinfo[start] getimage].center.x-18)))&&((location.y<(-25+[gateinfo[start] getimage].center.y+18))&&(location.y>(-25+[gateinfo[start] getimage].center.y-18)))){
                            
                            NSLog(@"%@",txt.text);
                            //     NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
                            checkconnectend=1;
                            inb=txt.text;
                            endposition=CGPointMake([gateinfo[start] getimage].center.x-35, [gateinfo[start] getimage].center.y-10);
                            
                            
                            
                        }
                        
                    }else if (txt.center.y==7) {///inv input
                        
                        
                        if(((location.x<(-40+[gateinfo[start] getimage].center.x+18))&&(location.x>(-40+[gateinfo[start] getimage].center.x-18)))&&((location.y<(-3+[gateinfo[start] getimage].center.y+18))&&(location.y>(-3+[gateinfo[start] getimage].center.y-18)))){
                            inb=txt.text;
                            NSLog(@"%@",txt.text);
                            //     NSLog(@"txt:(%f,%f)",txt.center.x,txt.center.y);
                            checkconnectend=1;
                            endposition=CGPointMake([gateinfo[start] getimage].center.x-35, [gateinfo[start] getimage].center.y);
                            
                            
                            
                        }
                        
                        
                        
                    }else{
                        
                        checkconnect=0;
                        checkconnectend=0;
                        checkconnectstart=0;
                        
                    }
                }
            }
        }
        
        /////////////////////wire start
        
        NSLog(@"%d,%d",checkconnectstart,checkconnectend);
        
        if (checkconnectend==1&&checkconnectstart==1) {
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(startposition.x, startposition.y)];
            [path addLineToPoint:CGPointMake(endposition.x, endposition.y)];
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = [path CGPath];
            shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
            shapeLayer.lineWidth = 3.0;
            shapeLayer.fillColor = [[UIColor clearColor] CGColor];
            
            [wiregroup addObject:shapeLayer];
            
            [self.view.layer addSublayer:shapeLayer];
            
            
            s=[NSString stringWithFormat:@"%c",a];
            gateinformation *gateobjec=[[gateinformation alloc]init];
            [gateobjec setgate:@"wire"];
            [gateobjec setina:ina];
            [gateobjec setinb:inb];
            [gateobjec setwire:s];
            [gateinfo addObject:gateobjec];
            for(gateinformation *gatecheck in gateinfo){
                if (ina==[gatecheck getoutput]) {
                    [gatecheck addoutconnect:s];
                }
                if(inb==[gatecheck getinputa]){
                    [gatecheck setinaconnect:s];
                }else if (inb==[gatecheck getinputb]){
                    [gatecheck setinbconnect:s];
                
                }
            
            }
            
            a++;
            checkconnectend=0;
            checkconnectstart=0;
            }
        
    }
    
 //   NSLog(@"%@",[touch view]);
}
///connection function implement end





////
- (IBAction)connecttap:(id)sender {
    //the button to start connection function
    edit.hidden=true;
    connect.hidden=true;
    deletgate.hidden=true;
    testbutton.hidden = true;
    
    force=1;
}
- (IBAction)filetap:(id)sender {
    
    

    
    
}
- (IBAction)verilogtap:(id)sender {
    //show the verilog file
}

- (IBAction)fortest:(id)sender {
    //the compile and test button, share all information of the gate to help coding
    
    
    for(UITextField *tf in inputValue){
        [inputcopy addObject:tf];
    }
    
    NSLog(@"sdaaaaaaaaaassdasdasdasd");
    for (gateinformation *allgate in gateinfo) {
        if([[allgate getgatetype] isEqualToString:@"wire"]){
            continue;
        }
        if([[allgate getgatetype] isEqualToString:@"input"]){
            for (UITextField *tf in inputcopy) {
                [allgate setInputValue:tf.text.intValue];
                [inputcopy removeObject:tf];
                break;
            }
        }
    }
    
    for (gateinformation *allgate in gateinfo) {
        NSLog(@"%d",[allgate getValue]);
    }
    
    
    for(gateinformation *allgate in gateinfo){
        if([[allgate getgatetype] isEqualToString:@"wire"]){
            continue;
        }
        
        if ([[allgate getgatetype] isEqualToString:@"input"] || [[allgate getgatetype] isEqualToString:@"output"]) {
            if ([[allgate getgatetype] isEqualToString:@"input"]) {
                [inputgate addObject:allgate];
            }else if([[allgate getgatetype] isEqualToString:@"output"]){
                [outputgate addObject:allgate];
            }
            
            [onlygateport addObject:allgate];
            
        }else{
        
            [onlygate addObject:allgate];
            [onlygateport addObject:allgate];
        
        }
        
    }
    if([processingGate ifAnyGateEmpty:onlygate]){
        //insert alert for the port not conncet well.
        NSLog(@"error");
        NSString *AlerttitleString = @"Has empty port, please check again!";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:  AlerttitleString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
        [alert show];
        return;
        
    }else{
        NSLog(@"nooooooooooooo error");
        verilog.hidden = false;
    
    }
    
    
    for(gateinformation *allgate in onlygate){
        

        
        NSLog(@"It is NO.%d component",[allgate getindex]);
        NSLog(@"It is %@",[allgate getgatetype]);
        NSLog(@"The wire name is %@",[allgate getwire]);
        NSLog(@"Output:%@,InputA:%@,InputB:%@",[allgate getoutput],[allgate getinputa],[allgate getinputb]);
        NSLog(@"Output connection:%@",[allgate getoutputconnect]);
        NSLog(@"InputA connection:%@",[allgate getinputaconnect]);
        NSLog(@"hhhhhhhhhhh    InputB connectiob:%@",[allgate pred]);
        NSLog(@"\r\n\r\n");
        NSLog(@"self distance:%f",[allgate distance]);
    }
     //NSLog(@"Value:%f", [gateinfo ]);
    float nn = [processingGate getLatency:onlygate];
    NSLog(@"Latency:%f", nn);
    NSLog(@"Empty:%d",[processingGate ifAnyGateEmpty:gateinfo]);

        
        [processingGate FinalCalculateAllOfValue:onlygateport];
        for (gateinformation* thegate in onlygateport) {
            NSLog(@"%d value is  %d", (int)thegate.indexnumber, (int)thegate.compValue);
        }
        
        

   
    /////////////////////////////////////////////////
    //output label value
    
    for(gateinformation *thegate in onlygateport){
        if ([[thegate getgatetype] isEqualToString:@"output"]){
            [outputcopy addObject:thegate];
        }
    
    }
    
    for(UILabel *lb in outputlabel){
        
        for(gateinformation *allgate in outputcopy){
            lb.hidden = NO;
            //////////////////////
            //insert value here
            if (outputlabelcheck == 0) {
                NSString *title = [[NSString alloc]initWithFormat:@"%@", lb.text];
                tempLabel = title;
                NSString *ssss = [[NSString alloc]initWithFormat:@"%@ : %d",lb.text ,[allgate getValue]];
                lb.text = ssss;
                outputlabelcheck = 1;
            }else if (outputlabelcheck == 1){
                NSString *secondTap = [[NSString alloc]initWithFormat:@"%@ : %d",tempLabel ,[allgate getValue]];
                lb.text = secondTap;
            }
            
            //////////////////////
            
            [outputcopy removeObject:allgate];
            break;
            
        }
    }
    
    //////////////////////////////
    //delay output label
    if (checkdelay == 0) {
        latency = nn;
        checkdelay = 1;
    }

    temps = [[NSString alloc]initWithFormat:@"Latency : %fns",latency ];
    delaylb.text = temps;
    delaylb.hidden = false;
    
    
    /////////////////////////////
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showverilog"]){
        GeneralVerilog *targetcontroller= [segue destinationViewController];
        [targetcontroller setCmpnntNm:gateinfo];
    }
}


@end






















































