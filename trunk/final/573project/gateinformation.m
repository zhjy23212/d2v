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

#import "gateinformation.h"

@implementation gateinformation
float delayTable[5] = {1.178,1.584,0.785,0.999,0.234};

-(id)init{
    self=[super init];
    if(self){
        self.indexnumber=0;
        self.gatetype=nil;
        self.output=nil;
        self.inputa=nil;
        self.inputb=nil;
        self.inputaconnect=nil;
        self.inputbconnect=nil;
        self.outputconnect=[[NSMutableArray alloc]init];
        self.gateimage=nil;
        self.wirename=nil;
        self.color=white;
        self.delay=0;
        self.distance=0;
        self.pred=[[NSMutableArray alloc]init];
        self.succ=[[NSMutableArray alloc]init];
        self.compValue = 0;
        self.inputValueA = 0;
        self.inputValueB = 0;
    }

    return self;

}

-(int)getindex{
    return self.indexnumber;
}
-(void)setgateindex:(int)number{
    self.indexnumber=number;
}

-(void)setGateColor:(tVisitColor)changeColor{
    self.color = changeColor;
}

-(NSString*)getgatetype{
    return self.gatetype;
}
-(float)getdelay{
    return self.delay;
}
//ADDER,MINUS, ANDER, ORER,CONVERTER
//self.gatearray=@[@"Input",@"Output",@"Add",@"Sub",@"Inv",@"And",@"Or"];
-(void)setgate:(NSString *)type{
    self.gatetype=type;
    if ([type  isEqual:@"add"]) {
        self.delay=delayTable[0];
        self.distance=delayTable[0];
    }
    if ([type  isEqual:@"sub"]) {
        self.delay=delayTable[1];
        self.distance=delayTable[1];

    }
    if ([type  isEqual:@"and"]) {
        self.delay=delayTable[2];
        self.distance=delayTable[2];

    }
    if ([type  isEqual:@"or"]) {
        self.delay=delayTable[3];
        self.distance=delayTable[3];

    }
    if ([type  isEqual:@"inv"]) {
        self.delay=delayTable[4];
        self.distance=delayTable[4];

    }
}
-(void)setInputValue:(int)value{
    self.compValue = value;
}

-(int)getValue{
    return (int)self.compValue;
}
-(NSString*)getoutput{
    return self.output;
}
-(NSString*)getinputa{
    return self.inputa;
}
-(NSString*)getinputb{
    return self.inputb;
}
-(void)setout:(NSString *)outport{
    self.output=outport;
}
-(void)setina:(NSString *)inport1{
    self.inputa=inport1;
}
-(void)setinb:(NSString *)inport2{
    self.inputb=inport2;
}
-(NSMutableArray*)getoutputconnect{
    return self.outputconnect;
}
-(NSString*)getinputaconnect{
    return self.inputaconnect;
}
-(NSString*)getinputbconnect{
    return self.inputbconnect;
}
-(void)addoutconnect:(NSString *)node{
    [self.outputconnect addObject:node];
}
-(void)setinaconnect:(NSString *)nodea{
    self.inputaconnect=nodea;
}
-(void)setinbconnect:(NSString *)nodeb{
    self.inputbconnect=nodeb;
}

-(UIImageView*)getimage{
    return self.gateimage;
}
-(void)setimage:(UIImageView *)img{
    self.gateimage=img;
}
-(void)setwire:(NSString *)wire{
    self.wirename=wire;
}
-(NSString*)getwire{
    return self.wirename;
}

@end





























