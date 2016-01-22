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

#import "processingGate.h"

@implementation processingGate

NSMutableArray *theGateList;
NSMutableArray *topo_sort;
NSMutableArray *IOGateArray;

//self.gatearray=@[@"Input",@"Output",@"Add",@"Sub",@"Inv",@"And",@"Or"];
//check the Gates in the array contain any port not connnected
+(BOOL)ifAnyGateEmpty:(NSMutableArray *)gatelist{
    theGateList=[gatelist mutableCopy];
    for (int i=0; i<gatelist.count; i++) {
        gateinformation * thiscomponent = gatelist[i];
        if ([thiscomponent.gatetype isEqual:@"add"]||[thiscomponent.gatetype isEqual:@"sub"]||[thiscomponent.gatetype isEqual:@"and"]||[thiscomponent.gatetype isEqual:@"or"]) {
            if ((thiscomponent.inputaconnect==nil)||(thiscomponent.inputbconnect==nil)||(thiscomponent.outputconnect.count==0)) {
                return YES;
            }
            
            
            
        }else if ([thiscomponent.gatetype isEqual:@"inv"]){
            if ((thiscomponent.inputaconnect==nil)||(thiscomponent.outputconnect.count==0)) {
                return YES;
            }
        }
    }
    return false;
}

//arrange the gates to have the correct info of its pred or succ
+(void)connectMod{
    for(gateinformation *gate in theGateList){
        if ([gate.gatetype  isEqual: @"inv"]) {
            NSString* inputToFind = gate.inputaconnect;
            //NSMutableArray* outputToFind = gate.outputconnect;
            for(gateinformation* subgate in theGateList){
                if (subgate!=gate) {
                    for(NSString* outputname in subgate.outputconnect){
                    if ((outputname == inputToFind)&![gate.pred containsObject:subgate]) {
                        [gate.pred addObject:subgate];
                    }
                    }
                    //using to find pred gate
                    
                    //using to find succ gate
                    for (NSString* thisoutput in gate.outputconnect) {
                        if ((subgate.inputaconnect==thisoutput||subgate.inputbconnect==thisoutput)&![gate.succ containsObject:subgate]) {
                            [gate.succ addObject:subgate];
                        }
                    }
                    
                }
            }
        }//end of arrange inv
        
        if ([gate.gatetype isEqual:@"add"]||[gate.gatetype isEqual:@"sub"]||[gate.gatetype isEqual:@"or"]||[gate.gatetype isEqual:@"and"]) {
            NSString *inputAtoFind = gate.inputaconnect;
            NSString *inputBtoFind = gate.inputbconnect;
            NSMutableArray *outputTofind = gate.outputconnect;
            for (gateinformation* subgate in theGateList) {
                if (subgate!=gate) {
                    for (NSString* outputname in subgate.outputconnect) {
                        if (![gate.pred containsObject:subgate]&(outputname==inputAtoFind||outputname==inputBtoFind)) {
                            [gate.pred addObject:subgate];
                            
                        }
                        

                    }
                    
                    for (NSString* selfoutputname in outputTofind) {
                        if (![gate.succ containsObject:subgate]&(subgate.inputaconnect==selfoutputname||subgate.inputbconnect==selfoutputname) ){
                            [gate.succ addObject:subgate];
                        }
                    }
                                    }
            }
        }
        
    }
}
// to calculate the latency result, should use the array that only contain gates
+(float) getLatency:(NSMutableArray *)gateList{
    topo_sort = [[NSMutableArray alloc] init];
    [self connectMod];
    [self t_sort];
    
    float latency =0;
    NSMutableArray *dist = [[NSMutableArray alloc] init];
    for (NSInteger i= 0; i<topo_sort.count; i++) {
        gateinformation* thisgate = topo_sort[i];
        
        if (thisgate.succ.count==0) {
            [dist addObject:[NSNumber numberWithFloat:thisgate.distance]];
            //thisgate.distance=thisgate.delay;
        }
        if (thisgate.succ.count!=0) {
            for(int i =0;i<thisgate.succ.count;i++){
                gateinformation* subgate = thisgate.succ[i];
                if ((thisgate.distance+subgate.delay)>subgate.distance) {
                    subgate.distance=thisgate.distance+subgate.delay;
                    
                }
            }
        }
    }
    for (int i=0; i<dist.count; i++) {
        if (latency<[[dist objectAtIndex:i] floatValue]) {
            latency=[[dist objectAtIndex:i] floatValue];
        }
    }
    return latency;
}


//tvisit and tsort is topological sort algorithm to get the order to process its calculate order
+(void)Tvisit:(gateinformation*)model{
    model.color=grey;
    if (model.succ.count!=0) {
        for (int tvs =0; tvs<model.succ.count; tvs++) {
            gateinformation *subgate = model.succ[tvs];
            if (subgate.color==white) {
                [self Tvisit:subgate];
            }
        }
    }
    model.color=black;
    [topo_sort insertObject:model atIndex:0];
}

+(void) t_sort{
    for (int i = 0 ; i<theGateList.count; i++) {
        gateinformation *thisGate = theGateList[i];
        if (thisGate.color==white) {
            [self Tvisit:thisGate];
        }
    }
}

//calculate the value of the whole circuit, notice the parameter should contain input and output, what's more important, should do it after **getLatency** completed!!!
+(void)FinalCalculateAllOfValue:(NSMutableArray*)theGateWithIO{
    IOGateArray = [theGateWithIO mutableCopy];
    [self setTheValueFromInput:theGateWithIO];
    [self setValueForGates:topo_sort];
    [self setValueForIOutput:theGateWithIO];
    NSLog(@"Done check the value");
}


//to pass the input value to the following gate
+(void) setTheValueFromInput:(NSMutableArray*)IOGateList{
    for (gateinformation* theInputGate in IOGateList) {
        if ([theInputGate.gatetype isEqualToString:@"input"]) {
            for (gateinformation* subgate in IOGateList) {
                if (subgate != theInputGate) {
                    for (NSString* outputname in theInputGate.outputconnect) {
                        if (subgate.inputaconnect == outputname) {
                            subgate.inputValueA = theInputGate.compValue;
                        }
                        if (subgate.inputbconnect == outputname) {
                            subgate.inputValueB =theInputGate.compValue;
                        }
                    }
                }
                
            }
        }
        

    }
}
//calculate the value for each gate
+(void)setValueForGates:(NSMutableArray*)topo_list{
    for (NSInteger i=0; i<topo_list.count; i++) {
        gateinformation* calThisGate =topo_list[i];
       // if (calThisGate.compValue==0) {
            calThisGate.compValue = [self calculateFor:calThisGate typeOfGate:calThisGate.gatetype];
            if (calThisGate.succ.count!=0) {
                for (gateinformation* followingGate in calThisGate.succ) {
                    if ([calThisGate.outputconnect containsObject:followingGate.inputaconnect]) {
                        followingGate.inputValueA=calThisGate.compValue;
                    }
                    if ([calThisGate.outputconnect containsObject:followingGate.inputbconnect]) {
                        followingGate.inputValueB=calThisGate.compValue;
                    }
                }
            }
       // }
    }
}

//to pass the pred's value into output
+(void)setValueForIOutput:(NSMutableArray*)IOGateList{
    for (gateinformation* theInputGate in IOGateList) {
     
    if ([theInputGate.gatetype isEqualToString:@"output"]) {
        for (gateinformation* subgate in IOGateList) {
            if (subgate!= theInputGate) {
                for (NSString* outputname in subgate.outputconnect) {
                    if (outputname ==theInputGate.inputaconnect) {
                        theInputGate.compValue = subgate.compValue;
                    }
                }
            }
        }
    }
    }
}

//calculate the value of each component based on its gatetype
//notice the inv will return an unsigned 8 bit binary to decimal
+(NSInteger)calculateFor:(gateinformation*)thegateToValue typeOfGate: (NSString*)type{
    NSInteger calResult ;
    if ([type isEqual:@"inv"]) {
        calResult = (~(int)thegateToValue.inputValueA)&0xff;
        
    }else if ([type isEqualToString:@"add"]){
        calResult = (int)thegateToValue.inputValueA +(int)thegateToValue.inputValueB;
    }else if ([type isEqualToString:@"sub"]){
        calResult = (int)thegateToValue.inputValueA -(int)thegateToValue.inputValueB;
    }else if ([type isEqualToString:@"and"]){
        calResult = (int)thegateToValue.inputValueA&(int)thegateToValue.inputValueB;
    }else if([type isEqualToString:@"or"]){
        calResult = (int)thegateToValue.inputValueA | (int)thegateToValue.inputValueB;
    }
    return calResult;
    
}



//will only output 8 bit binary string
+(NSMutableString*)intToBinary:(int)numberToConvert{
    NSMutableString* result = [NSMutableString string];
    int copynum = numberToConvert;
    for(NSInteger i = 0; i < 8 ; i++) {
        // Prepend "0" or "1", depending on the bit
        [result insertString:((copynum & 1) ? @"1" : @"0") atIndex:0];
        copynum >>= 1;
    }
    return result;
}

@end
