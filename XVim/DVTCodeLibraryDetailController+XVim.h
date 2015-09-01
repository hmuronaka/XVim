//
//  DVTCodeLibraryDetailController+XVim.h
//  XVim
//
//  Created by Muronaka Hiroaki on 2015/08/31.
//
//

#import <Cocoa/Cocoa.h>
#import "DVTKit.h"

@interface DVTCodeLibraryDetailController (XVim)

+ (void)xvim_initialize;
+ (void)xvim_finalize;

#pragma mark XVim Hook Methods
-(NSArray*)xvim_textView:(NSTextView *)textView completions:(NSArray *)words forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index;

@end
