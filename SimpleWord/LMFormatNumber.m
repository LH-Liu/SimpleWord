//
//  LMParagraphOrderedList.m
//  SimpleWord
//
//  Created by Chenly on 2016/12/20.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "LMFormatNumber.h"
#import "UIFont+LMText.h"
#import "UIFont+LMText.h"

@interface LMFormatNumber ()

@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation LMFormatNumber

@synthesize view = _view;

- (CGFloat)indent {
    static dispatch_once_t onceToken;
    static CGFloat lineHeight;
    dispatch_once(&onceToken, ^{
        lineHeight = [UIFont lm_systemFont].lineHeight;
    });
    return lineHeight;
}

- (CGFloat)paragraphSpacing {
    return 8.f;
}

- (NSDictionary *)textAttributes {
    
    UIFont *font = [UIFont lm_systemFont];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.paragraphSpacing = [self paragraphSpacing];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName: font,
                                 NSParagraphStyleAttributeName: style,
                                 };
    return attributes;
}

- (UIView *)view {
    if (!_view) {
        _view = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont lm_systemFont];
            label.textAlignment = NSTextAlignmentRight;
            label.frame = CGRectMake(0, 0, [self indent], [self indent]);
            _numberLabel = label;
            self.number = 1;
            
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor clearColor];
            [view addSubview:label];
            view;
        });
    }
    return _view;
}

- (void)setNumber:(NSInteger)number {
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld.", number];
}

- (void)updateDisplayWithParagraph:(LMFormat *)paragraph {    
    if (paragraph.previous.type == LMFormatTypeNumber) {
        self.number = ((LMFormatNumber *)paragraph.previous.style).number + 1;
    }
    else {
        self.number = 1;
    }
}

@end