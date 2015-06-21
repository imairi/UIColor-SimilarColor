//
//  UIColor+SimilarColor.m
//  ColorVamp
//
//  Created by Imairi, Yosuke on 4/2/15.
//
//

#import "UIColor+SimilarColor.h"

@interface UIColor()
@property (nonatomic, assign) CGFloat rate;
@end

@implementation UIColor(SimilarColor)


#pragma mark - Public Methods
- (NSArray*)similarColors{
    CGFloat hue, saturation ,brightness, alpha;
    [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    hue = hue * 360;
    saturation = saturation * 360;
    brightness = brightness * 360;
    
    CGFloat rate = 1.0;
    CGFloat baseHue = hue;
    CGFloat baseSaturation = saturation;
    CGFloat baseBrightness = brightness;
    
    if (saturation > 20 && brightness > 153) {
        baseSaturation = 40 + baseSaturation * 0.55;
        baseBrightness = 153 + baseBrightness * 0.4;
        if ((0 < hue && hue < 20) || (260 < hue && hue < 360)) {
            rate = 0.85;
        }
    }
    
    UIColor *color1 = [self generateColor1WithHue:baseHue saturation:baseSaturation brightness:baseBrightness rate:rate];
    UIColor *color2 = [self generateColor2WithHue:baseHue saturation:saturation brightness:brightness];
    UIColor *color3 = [self generateColor3WithHue:baseHue saturation:baseSaturation brightness:baseBrightness];
    UIColor *color4 = [self generateColor4WithHue:baseHue saturation:baseSaturation brightness:baseBrightness];
    UIColor *color5 = [self generateColor5WithHue:baseHue saturation:baseSaturation brightness:baseBrightness];
    UIColor *color6 = [self generateColor6WithHue:baseHue saturation:baseSaturation brightness:baseBrightness];
    UIColor *color7 = [self generateColor7WithHue:baseHue saturation:baseSaturation brightness:baseBrightness];
    
    return @[color1, color2, color3, color4, color5, color6, color7];
}

- (NSArray*)similarColorsByHex{
    NSArray *similarColors = [self similarColors];
    
    NSMutableArray *hexColors = [NSMutableArray array];
    [similarColors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIColor *color = obj;
        CGFloat red, green, blue, alpha;
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        [hexColors addObject:[NSString stringWithFormat:@"#%.2X%.2X%.2X", (int)(red*255), (int)(green*255), (int)(blue*255)]];
    }];
    
    return hexColors.copy;
}


# pragma mark - Private Methods
- (UIColor*)generateColor1WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value rate:(CGFloat)rate {
    CGFloat differentColor = 1.0;
    CGFloat changeHue45  = fmodf(360 + hue +  differentColor/ 4, 360);
    return [UIColor colorWithHue:changeHue45/360.0
                      saturation:(saturation * rate)/100.0
                      brightness:(value * rate)/100.0
                           alpha:1.0];
}

- (UIColor*)generateColor2WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value {
    CGFloat differentColor = 1.0;
    CGFloat changeHue90  = fmodf(360 + hue + differentColor / 2, 360);
    return [UIColor colorWithHue:changeHue90/360.0
                      saturation:(saturation * 0.85)/100.0
                      brightness:(value * 0.50 * 0.50)/100.0
                           alpha:1.0];
}

- (UIColor*)generateColor3WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value {
    CGFloat differentColor = 1.0;
    CGFloat changeHue45  = fmodf(360 + hue + differentColor / 4, 360);
    CGFloat changeHue90  = fmodf(360 + hue + differentColor / 2, 360);
    if ((saturation < 30 && value > 220)) {
        CGFloat originalHue, originalSaturation ,originalBrightness, originalAlpha;
        [self getHue:&originalHue saturation:&originalSaturation brightness:&originalBrightness alpha:&originalAlpha];
        return [UIColor colorWithHue:changeHue45/360.0
                          saturation:(40 + originalSaturation * 0.5)/100.0
                          brightness:(102 + value * 0.5)/100.0
                               alpha:1.0];
    } else {
        if ((saturation > 80 && value > 153) || (saturation < 20 && value < 51)) {
            return [UIColor colorWithHue:changeHue90/360.0
                              saturation:(40 + saturation * 0.4)/100.0
                              brightness:(30 + abs((int)value -255))/100.0
                                   alpha:1.0];
        } else {
            return [UIColor colorWithHue:changeHue90/360.0
                              saturation:(saturation * 0.5)/100.0
                              brightness:(153 + value * 0.4)/100.0
                                   alpha:1.0];
        }
    }
}

- (UIColor*)generateColor4WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value {
    return [UIColor colorWithHue:hue/360.0
                      saturation:(40 + saturation * 0.1)/100.0
                      brightness:(value * 1)/100.0
                           alpha:1.0];
}

- (UIColor*)generateColor5WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value {
    CGFloat differentColor = 1.0;
    CGFloat changeHue    = fmodf(360 + hue + differentColor, 360);
    return [UIColor colorWithHue:changeHue/360.0
                      saturation:(saturation * 0.3)/100.0
                      brightness:(102 + value * 0.6)/100.0
                           alpha:1.0];
}

- (UIColor*)generateColor6WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value {
    CGFloat differentColor = 1.0;
    CGFloat changeHue    = fmodf(360 + hue + differentColor, 360);
    return [UIColor colorWithHue:changeHue/360.0
                      saturation:(saturation * 0.1)/100.0
                      brightness:(204 + value * 0.2)/100.0
                           alpha:1.0];
}

- (UIColor*)generateColor7WithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)value {
    CGFloat differentColor = 1.0;
    CGFloat changeHue    = fmodf(360 + hue + differentColor, 360);
    return [UIColor colorWithHue:changeHue/360.0
                      saturation:(40 + saturation * 0.4)/100.0
                      brightness:(153 + value * 0.4)/100.0
                           alpha:1.0];
}


@end
