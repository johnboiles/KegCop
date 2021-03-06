//
//  ViewControllerSerialConsole.m
//  KegCop
//
//  Created by capin on 7/30/12.
//

#import "ViewControllerSerialConsole.h"

@implementation ViewControllerSerialConsole

@synthesize textEntry = _textEntry;
@synthesize btnSend = _btnSend;
@synthesize serialView = _serialView;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    serial = [[JailbrokenSerial alloc] init];
    serial.debug = true;
    serial.nonBlock = true;
    serial.receiver = self;
    text = [[NSMutableString alloc] initWithString:@""];
}
    
- (void)viewDidUnload
{
    [self setTextEntry:nil];
    [self setBtnSend:nil];
    [self setSerialView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)donePressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];    
}

- (IBAction)sendString:(id)sender {
    // dismiss keyboard
    [self.textEntry resignFirstResponder];
    [serial write:[_textEntry text]];
    _textEntry.text = @"";
    
}

- (IBAction)openSerial:(id)sender
{
    [serial open:B2400];
    NSLog(@"%c", [serial isOpened]);
    if(serial.isOpened)
    {
        [_textEntry becomeFirstResponder];
    }
}

- (IBAction)closeSerial:(id)sender
{
    [serial close];
}

# pragma mark - JailbrokenSerialDelegate
- (void) JailbrokenSerialReceived:(char)ch {
    [text appendFormat:@"%c", ch];
    _serialView.text = text;
}

@end
