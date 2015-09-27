//
//  DVTTextCompletionListWindowController+XVim.m
//  XVim
//
//  Created by Muronaka Hiroaki on 2015/09/27.
//
//

#import "IDEKit.h"
#import "DVTTextCompletionListWindowController+XVim.h"
#import "XVim.h"

@implementation DVTTextCompletionListWindowController (XVim)

- (BOOL)tryExpandingCompletion
{
    IDEIndexCompletionItem *item = [self _selectedCompletionItem];
    
    [[XVim instance] expandCompletionItem:item];
    
    return NO;
}

@end
