//
//  DVTCodeLibraryDetailController+XVim.m
//  XVim
//
//  Created by Muronaka Hiroaki on 2015/08/31.
//
//
#import "Logger.h"

#import "DVTCodeLibraryDetailController+XVim.h"
#import "NSObject+XVimAdditions.h"

@implementation DVTCodeLibraryDetailController (XVim)

+ (void)xvim_initialize{
    [self xvim_swizzleInstanceMethod:@selector(textView:completions:forPartialWordRange:indexOfSelectedItem:) with:@selector(xvim_textView:completions:forPartialWordRange:indexOfSelectedItem:)];
}

+ (void)xvim_finalize{
    [self xvim_swizzleInstanceMethod:@selector(textView:completions:forPartialWordRange:indexOfSelectedItem:) with:@selector(xvim_textView:completions:forPartialWordRange:indexOfSelectedItem:)];
}

-(NSArray*)xvim_textView:(NSTextView *)textView completions:(NSArray *)words forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index {
    
    TRACE_LOG(@"@@@ index=%d words=%@", index, words);
    
    return [self xvim_textView:textView completions:words forPartialWordRange:charRange indexOfSelectedItem:index];
}

@end
