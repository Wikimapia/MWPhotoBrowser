//
//  MWPhotoActionsDelegate.h
//  MWPhotoBrowser
//
//  Created by Andrew Podkovyrin on 18.02.14.
//
//

#import <Foundation/Foundation.h>

@protocol MWPhotoActionsDelegate <NSObject>

@optional
- (void)deleteButtonPressedForPhoto:(id<MWPhoto>)photo;

@end
