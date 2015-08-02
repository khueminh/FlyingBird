//
//  ViewController.m
//  FlyingBird
//
//  Created by Nguyen Minh Khue on 8/2/15.
//  Copyright (c) 2015 Nguyen Minh Khue. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
{
    UIImageView *bird;
    AVAudioPlayer *audio;
    
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawJungle];
    [self drawBird];
    [self flyUpAndDown];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Son ca 01" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:path];
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                   error:nil];
    audio.numberOfLoops = -1; //Infinite
    [audio play];

}

- (void)drawJungle{
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jungle.jpg"]];
    
    background.frame = self.view.bounds;
    background.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:background];
    
}

-(void) drawBird{
    bird = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 110, 68)];
    
    bird.animationImages= @[[UIImage imageNamed:@"bird0.png"],
                            [UIImage imageNamed:@"bird1.png"],
                            [UIImage imageNamed:@"bird2.png"],
                            [UIImage imageNamed:@"bird3.png"],
                            [UIImage imageNamed:@"bird4.png"],
                            [UIImage imageNamed:@"bird5.png"]];
    
    bird.animationRepeatCount = -1; //Repeat Forever
    bird.animationDuration = 1; //1s for 6 images
    
    [self.view addSubview:bird];
    [bird startAnimating];
    
}

-(void) flyUpAndDown{
    bird.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:5 animations:^{
        bird.center = CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height);
    }completion:^(BOOL finished) {
        bird.transform=CGAffineTransformConcat(CGAffineTransformMakeScale(-1, 1)  //Bay cheo tu tren xuong duoi, tu trai qua phai
                                               , CGAffineTransformMakeRotation(M_PI_4)); //Xoay 1/4
        [UIView animateWithDuration:5 animations:^{
            bird.center = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self flyUpAndDown];
        }];
    }];
}

-(void) viewWillDisappear:(BOOL) animated{
    [audio stop];
}


@end
