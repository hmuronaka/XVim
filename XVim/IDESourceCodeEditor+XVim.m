//
//  XVimSourceCodeEditor.m
//  XVim
//
//  Created by Tomas Lundell on 31/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IDESourceCodeEditor+XVim.h"
#import "IDEKit.h"
#import "XVimWindow.h"
#import "Logger.h"
#import "XVimStatusLine.h"
#import "XVim.h"
#import "NSObject+XVimAdditions.h"

@implementation IDESourceCodeEditor(XVim)
+ (void)xvim_initialize{
    [self xvim_swizzleInstanceMethod:@selector(textView:willChangeSelectionFromCharacterRanges:toCharacterRanges:) with:@selector(xvim_textView:willChangeSelectionFromCharacterRanges:toCharacterRanges:)];
    
    [self xvim_swizzleInstanceMethod:@selector(textView:completions:forPartialWordRange:indexOfSelectedItem:) with:@selector(xvim_textView:completions:forPartialWordRange:indexOfSelectedItem:)];
}

- (NSArray*) xvim_textView:(NSTextView *)textView willChangeSelectionFromCharacterRanges:(NSArray *)oldSelectedCharRanges toCharacterRanges:(NSArray *)newSelectedCharRanges
{
    return newSelectedCharRanges;
}

-(NSArray*)xvim_textView:(NSTextView *)textView completions:(NSArray *)words forPartialWordRange:(NSRange)charRange indexOfSelectedItem:(NSInteger *)index {
    
    TRACE_LOG(@"@@@ index=%d words=%@", index, words);
    return [self xvim_textView:textView completions:words forPartialWordRange:charRange indexOfSelectedItem:index];
}
@end