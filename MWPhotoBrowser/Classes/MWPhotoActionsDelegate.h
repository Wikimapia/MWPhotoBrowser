//
//  MWPhotoActionsDelegate.h
//  MWPhotoBrowser
//
//  Created by Andrew Podkovyrin on 18.02.14.
//
//

#import <Foundation/Foundation.h>

@protocol MWPhotoEditDelegate <NSObject>

@optional
- (void)editButtonPressedForPhoto:(id<MWPhoto>)photo;

@end
