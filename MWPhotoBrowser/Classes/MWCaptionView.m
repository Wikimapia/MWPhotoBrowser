//
//  MWCaptionView.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 30/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MWCommon.h"
#import "MWCaptionView.h"
#import "MWPhoto.h"

static const CGFloat labelPadding = 10;
static const CGFloat editButtonWidth = 44.0;

// Private
@interface MWCaptionView () {
    id <MWPhoto> _photo;
    UILabel *_label;
    UIButton *_editButton;
}

@property (weak, readwrite, nonatomic) id<MWPhotoEditDelegate> delegate;

@end

@implementation MWCaptionView

- (id)initWithPhoto:(id<MWPhoto>)photo delegate:(id<MWPhotoEditDelegate>)delegate {
    self = [super initWithFrame:CGRectMake(0, 0, 320, 44)]; // Random initial frame
    if (self) {
        self.userInteractionEnabled = YES;
        _photo = photo;
        self.delegate = delegate;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
            // Use iOS 7 blurry goodness
            self.barStyle = UIBarStyleBlackTranslucent;
            self.tintColor = nil;
            self.barTintColor = nil;
            self.barStyle = UIBarStyleBlackTranslucent;
            [self setBackgroundImage:nil forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        } else {
            // Transparent black with no gloss
            CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
            UIGraphicsBeginImageContext(rect.size);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, [[UIColor colorWithWhite:0 alpha:0.6] CGColor]);
            CGContextFillRect(context, rect);
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            [self setBackgroundImage:image forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        }
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        
        if ([_photo editingStyle] != MWPhotoEditingStyleNone) {
            [self setupEditButtonWithStyle:[_photo editingStyle]];
        }
        
        [self setupCaption];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize s = self.bounds.size;
    
    CGFloat maxWidth = s.width - labelPadding * 2;
    if (_editButton) {
        maxWidth -= editButtonWidth;
    }

    _label.frame = CGRectMake(labelPadding, 0, maxWidth, s.height);
    _editButton.frame = CGRectMake(s.width - editButtonWidth, 0, editButtonWidth, s.height);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat maxHeight = 9999;
    CGFloat maxWidth = size.width - labelPadding * 2;
    if (_editButton) {
        maxWidth -= editButtonWidth;
    }
    if (_label.numberOfLines > 0) maxHeight = _label.font.leading*_label.numberOfLines;

    CGSize textSize;
    if ([NSString instancesRespondToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textSize = [_label.text boundingRectWithSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:_label.font}
                                             context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        textSize = [_label.text sizeWithFont:_label.font
                           constrainedToSize:CGSizeMake(size.width - labelPadding*2, maxHeight)
                               lineBreakMode:_label.lineBreakMode];
#pragma clang diagnostic pop
    }

    return CGSizeMake(size.width, textSize.height + labelPadding * 2);
}

- (void)setupCaption {
    _label = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(labelPadding, 0,
                                                       self.bounds.size.width-labelPadding*2,
                                                       self.bounds.size.height))];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _label.opaque = NO;
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.numberOfLines = 0;
    _label.textColor = [UIColor whiteColor];
    if (SYSTEM_VERSION_LESS_THAN(@"7")) {
        // Shadow on 6 and below
        _label.shadowColor = [UIColor blackColor];
        _label.shadowOffset = CGSizeMake(1, 1);
    }
    _label.font = [UIFont systemFontOfSize:17];
    if ([_photo respondsToSelector:@selector(caption)]) {
        _label.text = [_photo caption] ? [_photo caption] : @" ";
    }
    [self addSubview:_label];
}

- (void)setupEditButtonWithStyle:(MWPhotoEditingStyle)editingStyle {
    UIImage *image = nil;
    switch (editingStyle) {
        case MWPhotoEditingStyleDelete:
            image = [UIImage imageNamed:@"MWPhotoBrowser.bundle/images/UIBarButtonItemTrash.png"];
            break;
        case MWPhotoEditingStyleUndo:
            image = [UIImage imageNamed:@"MWPhotoBrowser.bundle/images/UIBarButtonItemUndo.png"];
            break;
        default:
            break;
    }
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editButton setImage:image forState:UIControlStateNormal];
    [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_editButton];
}

- (void)editButtonAction {
    if ([self.delegate respondsToSelector:@selector(editButtonPressedForPhoto:)]) {
        [self.delegate editButtonPressedForPhoto:_photo];
    }
}

@end
