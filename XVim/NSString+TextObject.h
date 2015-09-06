//
//  NSString+TextObject.h
//  NSString-TextObject
//
//  Created by Muronaka Hiroaki on 2015/09/05.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HM_TextObject)

-(NSRange)rangeOfIncludesSurrundingCharacter:(unichar)character fromIndex:(NSUInteger)index;
-(NSRange)rangeOfNotIncludesSurrundingCharacter:(unichar)character fromIndex:(NSUInteger)index;
-(NSRange)rangeOfCamelcaseSurrundingCharacterWithFromIndex:(NSUInteger)index;

@end
