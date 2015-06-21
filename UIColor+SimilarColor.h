//
//  UIColor+SimilarColor.h
//  ColorVamp
//
//  Created by Imairi, Yosuke on 4/2/15.
//
//

#import <UIKit/UIKit.h>

@interface UIColor(SimilarColor)
- (NSArray*)similarColors;
- (NSArray*)similarColorsByHex;
@end
