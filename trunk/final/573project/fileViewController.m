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



#import "fileViewController.h"



@interface fileViewController ()



@end



@implementation fileViewController{
    
    
    
    //   NSArray *filelist;
    
    NSString *filenametxt,*filenamemat;
    
    int indexnumber;
    
    NSFileManager *fileManager;
    
    
    
}

@synthesize path;

@synthesize documenpath;

@synthesize senditem, deleteitem, filelist;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    senditem.hidden=TRUE;
    
    deleteitem.hidden = TRUE;
    
    
    
    
    
    filelist = [[NSMutableArray array]init];
    
    path= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    documenpath=[path objectAtIndex:0];
    
    NSDirectoryEnumerator *DirEnum;
    
    fileManager=[NSFileManager defaultManager];
    
    DirEnum = [fileManager enumeratorAtPath:documenpath];
    
    //FileManager = [[NSFileManager alloc] init];
    
    NSString *file;
    
    while((file=[DirEnum nextObject]))     //visit the document's path
        
    {
        
        if([[file pathExtension] isEqualToString:@"v"])   //get all v files
            
        {
            
            //[array addObject:[docPath stringByAppendingPathComponent:file]]; //save to the array
            
            [filelist addObject:file];
            
        }
        
    }
    
    //filelist=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documenpath error:nil];
    
    //fileManager = [NSFileManager defaultManager];
    
    
    
    // Do any additional setup after loading the view.
    
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







- (IBAction)backaction:(id)sender {
    
}

/////table view start





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //get table section row
    
    
    
    return [filelist count];
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //get table cell
    
    static NSString *simpleidef=@"simpleidef";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleidef];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleidef];
        
        
        
    }
    
    cell.textLabel.text=filelist[indexPath.row];
    
    
    
    return cell;
    
}



-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //when select file, do action
    
    indexnumber=(int)indexPath.row;
    
    return indexPath;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //show file
    
    senditem.hidden=false;
    
    deleteitem.hidden = false;
    
    
    
    
    
}





///table view end



//mail send start

- (IBAction)deleteaction:(id)sender {
    
    NSError *error;
    
    NSString *filePath = [documenpath stringByAppendingPathComponent:[filelist objectAtIndex:indexnumber]];
    
    [fileManager removeItemAtPath:filePath error:&error];
    
    deleteitem.hidden = TRUE;
    
    
    
    [super viewDidLoad];
    
    senditem.hidden=TRUE;
    
    deleteitem.hidden = TRUE;
    
    
    
    path= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    documenpath=[path objectAtIndex:0];
    
    filelist = [[NSMutableArray array]init];
    
    NSDirectoryEnumerator *DirEnumtwo;
    
    DirEnumtwo = [fileManager enumeratorAtPath:documenpath];
    
    NSString *filetwo;
    
    while((filetwo=[DirEnumtwo nextObject]))     //visit the document's path
        
    {
        
        if([[filetwo pathExtension] isEqualToString:@"v"])   //get all v
            
        {
            
            //[array addObject:[docPath stringByAppendingPathComponent:file]]; //save to the array
            
            [filelist addObject:filetwo];
            
        }
        
    }
    
    //filelist=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:documenpath error:nil];
    
    fileManager = [NSFileManager defaultManager];
    
    
    
    [self.table reloadData];
    
    
    
    
    
}



- (IBAction)sendaction:(id)sender {
    
    MFMailComposeViewController *mailcontroller = [[MFMailComposeViewController alloc]init];
    
    [mailcontroller setMailComposeDelegate:self];
    
    if ([MFMailComposeViewController canSendMail]) {
        
        [mailcontroller setToRecipients:[NSArray arrayWithObjects:@"example.com", nil]];
        
        [mailcontroller setSubject:@"123test"];
        
        [mailcontroller setMessageBody:@"your file\r\n" isHTML:NO];
        
        [mailcontroller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        
        
        
        
        
        
        NSString *filePath = [documenpath stringByAppendingPathComponent:[filelist objectAtIndex:indexnumber]];
        
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        
        
        
        
        
        
        [mailcontroller addAttachmentData:fileData mimeType:@"txt" fileName:[filelist objectAtIndex:indexnumber]];
        
        
        
        [self presentViewController:mailcontroller animated:YES completion:nil];}
    
}



-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    //return viewtable after sent mail
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//mail send end



@end

