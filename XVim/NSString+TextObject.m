//
//  NSString+TextObject.m
//  NSString-TextObject
//
//  Created by Muronaka Hiroaki on 2015/09/05.
//  Copyright (c) 2015年 Muronaka Hiroaki. All rights reserved.
//

#import "NSString+TextObject.h"

@implementation NSString (HM_TextObject)

-(NSRange)rangeOfIncludesSurrundingCharacter:(unichar)character fromIndex:(NSUInteger)index {
    
    NSUInteger beginIndex = [self hm_searchReverselyWithCharacter:character ignoreCharacters:@"" fromIndex:index];
    if( beginIndex == NSNotFound ) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    NSUInteger endIndex = NSNotFound;
    if( beginIndex == index ) {
        endIndex = [self hm_searchCharacter:character ignoreCharacters:@"" fromIndex:index + 1];
        if( endIndex == NSNotFound ) {
            endIndex = beginIndex;
            beginIndex = [self hm_searchReverselyWithCharacter:character ignoreCharacters:@"" fromIndex:index - 1];
        }
    } else {
        endIndex = [self hm_searchCharacter:character ignoreCharacters:@"" fromIndex:index];
    }
    
    if( endIndex == NSNotFound ) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    if( endIndex == beginIndex ) {
        return NSMakeRange(NSNotFound, 0);
    }
    
    return NSMakeRange(beginIndex, endIndex - beginIndex + 1);
}

-(NSRange)rangeOfNotIncludesSurrundingCharacter:(unichar)character fromIndex:(NSUInteger)index {
    
    NSRange range = [self rangeOfIncludesSurrundingCharacter:character fromIndex:index];
    if( range.location == NSNotFound ) {
        return range;
    }
    return NSMakeRange(range.location + 1, range.length - 2);
}

-(unichar)safetyCharacterAtIndex:(NSUInteger)index {
    if( index >= self.length ) {
        return 0;
    } else {
        return [self characterAtIndex:index];
    }
}

-(NSUInteger)hm_searchCharacter:(unichar)character ignoreCharacters:(NSString*)ignoreChars fromIndex:(NSUInteger)fromIndex {
    
    NSMutableCharacterSet* charSet = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    if( ignoreChars ) {
        [charSet addCharactersInString:ignoreChars];
    }
    NSCharacterSet* ignoreCharacterSet = charSet;
    
    NSUInteger currentIndex = fromIndex;
    NSUInteger result = NSNotFound;
    while( currentIndex < self.length ) {
        unichar currentCh = [self characterAtIndex:currentIndex];
        if( currentCh == character ) {
            result = currentIndex;
            break;
        } else if( [ignoreCharacterSet characterIsMember:currentCh] ) {
            break;
        }
        ++currentIndex;
    }
    return result;
    
}

-(NSUInteger)hm_searchReverselyWithCharacter:(unichar)character ignoreCharacters:(NSString*)ignoreChars fromIndex:(NSUInteger)fromIndex {
    
    NSMutableCharacterSet* charSet = [NSMutableCharacterSet whitespaceAndNewlineCharacterSet];
    if( ignoreChars ) {
        [charSet addCharactersInString:ignoreChars];
    }
    NSCharacterSet* ignoreCharacterSet = charSet;
    
    NSUInteger currentIndex = MIN(self.length - 1, fromIndex);
    NSUInteger result = NSNotFound;
    while( currentIndex != (NSUInteger)-1 ) {
        unichar currentCh = [self characterAtIndex:currentIndex];
        if( currentCh == character ) {
            result = currentIndex;
            break;
        } else if( [ignoreCharacterSet characterIsMember:currentCh] ) {
            break;
        }
        --currentIndex;
    }
    return result;
    
}

-(NSUInteger)hm_skipReverselyWithCharacterSet:(NSCharacterSet*)characterSet fromIndex:(NSUInteger)fromIndex {
    
    NSUInteger currentIndex = MIN(self.length - 1, fromIndex);
    NSUInteger result = NSNotFound;
    while( currentIndex != (NSUInteger)-1 ) {
        unichar currentCh = [self characterAtIndex:currentIndex];
        if( ![characterSet characterIsMember:currentCh] ) {
            result = (currentIndex == fromIndex ? NSNotFound : currentIndex + 1);
            break;
        }
        --currentIndex;
    }
    
    if( currentIndex == (NSUInteger)-1 ) {
        result = 0;
    }
    
    return result;
    
}

-(NSUInteger)hm_skipCharacterSet:(NSCharacterSet*)characterSet fromIndex:(NSUInteger)fromIndex {
    
    NSUInteger currentIndex = fromIndex;
    NSUInteger result = NSNotFound;
    while( currentIndex < self.length ) {
        unichar currentCh = [self characterAtIndex:currentIndex];
        if( ![characterSet characterIsMember:currentCh] ) {
            result = (currentIndex == fromIndex ? NSNotFound : currentIndex -1);
            break;
        }
        ++currentIndex;
    }
    
    if( currentIndex == self.length ) {
        result = self.length - 1;
    }
    return result;
    
}

-(NSRange)rangeOfCamelcaseSurrundingCharacterWithFromIndex:(NSUInteger)index count:(NSUInteger)count {
    
    NSRange range = NSMakeRange(NSNotFound, 0);
    NSUInteger currentIndex = index;
    
    while( count > 0 ) {
        if( range.location != NSNotFound ) {
            currentIndex = range.location + range.length;
        }
        NSRange tempRange = [self rangeOfCamelcaseSurrundingCharacterWithFromIndex:currentIndex];
        if( tempRange.location == NSNotFound ) {
            break;
        } else {
            if( range.location == NSNotFound ) {
                range.location = tempRange.location;
            }
            range.length += tempRange.length;
        }
        --count;
    }
    return range;
}


-(NSRange)rangeOfCamelcaseSurrundingCharacterWithFromIndex:(NSUInteger)index {
    
    if( index >= self.length )  {
        return NSMakeRange(NSNotFound, 0);
    }
    
    unichar currentCh = [self characterAtIndex:index];
    
    NSCharacterSet* upperCharSet = [NSCharacterSet uppercaseLetterCharacterSet];
    NSCharacterSet* lowerCharSet = [NSCharacterSet lowercaseLetterCharacterSet];
    
    NSUInteger beginPos = NSNotFound;
    NSUInteger endPos = NSNotFound;
    
    if( [upperCharSet characterIsMember:currentCh] ) {
        unichar nextCh = [self safetyCharacterAtIndex:index + 1];
        // Pdf -> get Pdf
        if( [lowerCharSet characterIsMember:nextCh] ) {
            beginPos = index;
            endPos = [self hm_skipCharacterSet:lowerCharSet fromIndex:index + 1];
            // PDFView -> current pos is in 'PDF'. get PDF
        } else if( [upperCharSet characterIsMember:nextCh] ) {
            beginPos = [self hm_skipReverselyWithCharacterSet:upperCharSet fromIndex:index];
            endPos = [self hm_skipCharacterSet:upperCharSet fromIndex:index + 1];
            nextCh = [self safetyCharacterAtIndex:endPos + 1];
            if( [lowerCharSet characterIsMember:nextCh] ) {
                --endPos;
            }
            // MyPDF -> current pos is in 'F' get PDF
        } else {
            endPos = index;
            beginPos = [self hm_skipReverselyWithCharacterSet:upperCharSet fromIndex:endPos - 1];
        }
    } else if([lowerCharSet characterIsMember:currentCh]) {
        unichar nextCh = [self safetyCharacterAtIndex:index + 1];
        
        if( [lowerCharSet characterIsMember:nextCh] ) {
            beginPos = [self hm_skipReverselyWithCharacterSet:lowerCharSet fromIndex:index];
            endPos = [self hm_skipCharacterSet:lowerCharSet fromIndex:index + 1];
        } else {
            endPos = index;
            beginPos = [self hm_skipReverselyWithCharacterSet:lowerCharSet fromIndex:index -1];
            if( beginPos == NSNotFound ) {
                beginPos = endPos;
            }
        }
        
        unichar prevCh = [self safetyCharacterAtIndex:beginPos - 1];
        if( [upperCharSet characterIsMember:prevCh] ) {
            --beginPos;
        }
    }
    
    if( beginPos == NSNotFound || endPos == NSNotFound ) {
        return NSMakeRange(NSNotFound, 0);
    }
    return NSMakeRange(beginPos, endPos - beginPos + 1);
}

@end
