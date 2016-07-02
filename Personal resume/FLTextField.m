//
//  FLTextField.m
//  01 - 百思不得姐
//
//  Created by fengli on 16/5/26.
//  Copyright © 2016年 fengli. All rights reserved.
//

#import "FLTextField.h"

@implementation FLTextField



- (void)awakeFromNib {
    

    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder {
    
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = self.textColor;
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    
    self.attributedPlaceholder = attribute;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attr];
    
    self.attributedPlaceholder = attribute;
    return [super resignFirstResponder];
}


@end
