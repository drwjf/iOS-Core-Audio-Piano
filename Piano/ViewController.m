//
//  ViewController.m
//  Piano
//
//  Created by Sam Meech-Ward on 2014-12-08.
//  Copyright (c) 2014 Sam Meech-Ward. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.instrumentController = [[AudioInstrumentController alloc] initWithInstrument:InstrumentWurley];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //adjust the piano view to the center\
    not the best place to put it, works for this example
    [self adjustPianoViewToPercent:50.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Piano View Delegate

-(void)pianoView:(PianoView *)piano keyDown:(int)key {
    // Find the frequency using the piano key number
    // Equation found at http://en.wikipedia.org/wiki/Piano_key_frequencies
    double frequency = pow(pow(2, 1.0/12.0), key-49)*440;
    
    // Play the frequency
    [self.instrumentController playFrequency:frequency];
    
    NSLog(@"piano key down: %i, frequency: %f", key, frequency);
}

-(void)pianoView:(PianoView *)piano keyUp:(int)key {
    
}

#pragma mark - Actions

- (IBAction)sliderValueChanged:(UISlider *)sender {
    [self adjustPianoViewToPercent:sender.value];
}

- (IBAction)pianoChanged:(UISegmentedControl *)sender {
    // Determine the instrument from the segment control
    Instrument instrument;
    switch (sender.selectedSegmentIndex) {
        case 0:
            instrument = InstrumentWurley;
            break;
        case 1:
            instrument = InstrumentRhodey;
            break;
        case 2:
            instrument = InstrumentTubeBell;
            break;
        case 3:
            instrument = InstrumentSitar;
            break;
        default:
            instrument = InstrumentWurley;
            break;
    }
    
    // Set the current instrument
    [self.instrumentController setCurrentInstrument:instrument];
}

#pragma mark - Piano Scroll View

-(void)adjustPianoViewToPercent:(float)percent {
    // Adjust the position of the piano view using a percentage, \
    0 = piano displays the first keys on the left, \
    100 = piano displayes the last keys on the right
    float maxContentOffset = self.pianoView.bounds.size.width-self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(maxContentOffset*(percent/100), 0) animated:NO];
}

@end
