//
//  ViewController.m
//  RunningLed
//
//  Created by tubjng on 6/17/15.
//  Copyright (c) 2015 tubjng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin;
    int _numberofball,_numberofballys;
    CGFloat _space;
    CGFloat _balldiameter;
    NSTimer *_timer;
    int lastOnLED;
    int _tag;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _margin =40.0;
    _balldiameter =24.0;
    lastOnLED =-1;
    _numberofball = 8;
    _numberofballys =8;
    [self drawrowofball:_numberofball drawrowofbally:_numberofballys]; //Chu viet cai g`i the nay?
    
    [self checksizeofapp];
    _timer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningled) userInfo:nil repeats:true];
    
    //[self numberofballvsspace];
    //[self  placeGreyBallAtX:100 andY:100 withTag:1];
}
-(void) runningled{
    if (lastOnLED != -1) {
        [self turnOffLed:lastOnLED];
    }
    if (lastOnLED!= _numberofball -1) {
        lastOnLED++;
    }else{
        lastOnLED=0;
    }
    [self turnOnLed:lastOnLED];
    
}


-(void) turnOnLed: (int) index{
    UIView* view = [self.view viewWithTag:index+100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball =(UIImageView*) view;
        ball.image=[UIImage imageNamed:@"green"];
        
    }


}
-(void) turnOffLed: (int) index{
    UIView* view =[self.view viewWithTag:index+100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball =(UIImageView*) view;
        ball.image=[UIImage imageNamed:@"grey"];
        
    }

    
    
}
-(void) placeGreyBallAtX: (CGFloat) x
                    andY: (CGFloat) y
                 withTag: (int)tag
{
    [super viewDidLoad];
    UIImageView* ball =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grey"]];
    ball.center =CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    NSLog(@"w=%3.0f, h =%3.0f",ball.bounds.size.width,ball.bounds.size.height);
}
-(CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n{
    return (self.view.bounds.size.width -2 *_margin)/(n-1);
}
-(CGFloat)spaceYBetweenBallCenterWhenNunberBallIsKnown:(int)n
{
    return (self.view.bounds.size.height-2*_margin)/(n-1);
}
-(void) numberofballvsspace{
    bool stop = false;
    int n=3;
    while (!stop) {
        CGFloat space =[self spaceBetweenBallCenterWhenNumberBallIsKnown:n];
        if(space <_balldiameter){
            stop= true;
            
        }else{
            NSLog(@"Number of ball %d, space between ball center %3.0f",n,space);
        }
        n++;
        
    }
}
// H`am n`ay viet nhu the nay co may cho sai
-(void) drawrowofball: (int) numberballx
       drawrowofbally: (int) numberbally{
    CGFloat spacex = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberballx];
    CGFloat spacey =[self spaceBetweenBallCenterWhenNumberBallIsKnown:numberbally];
    for(int j=0;j<numberbally;j++){
        for (int i=0; i<numberballx; i++) {
            _tag=_tag+1;
        [self placeGreyBallAtX:_margin+i*spacex
                            andY:_margin+j*spacey+100
                        withTag:_tag+100];  //1 + 100 là gì. nó phải là i + 100. Nếu có thêm hàng cọt thì còn khác nữa
    }
}
}
-(void) checksizeofapp{
    CGSize size= self.view.bounds.size;
    NSLog(@"width =%3.0f, height =%3.0f",size.width,size.height);
}

@end
