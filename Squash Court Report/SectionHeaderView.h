//
//  SectionHeaderView.h
//  Squash Court Report
//
//  Created by Maxwell Shaw on 10/15/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TriangleView.h"

@class SectionHeaderView;

@protocol SectionHeaderDelegate <NSObject>

- (void)sectionHeadedWasClicked:(SectionHeaderView *) sectionHeader;

@end

@interface SectionHeaderView : UIView {
    id delegate;
    BOOL collapsed;
}

@property (strong, nonatomic) UILabel *label;
@property (nonatomic) int sectionNumber;
@property (nonatomic, strong) id delegate;
@property (strong, nonatomic) TriangleView *collapseIndicator;

-(void)toggleCollapsed;
@end
