/*
 * IKAspect.j
 * InspectKit
 *
 * Created by Udo Schneider on May 25, 2013.
 *
 * The MIT License
 *
 * Copyright (c) 2013 Udo Schneider
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */
@import <Foundation/CPObject.j>
@import <Foundation/CPString.j>

@class IKObjectAspect
@class IKIndexedAspect

@implementation IKAspect : CPObject
{
    CPString    _key    @accessors(readonly, property=key)
}

+ (IKObjectAspect)object:(CPString)key
{
	return [[IKObjectAspect alloc] initWithKey:key];
}

+ (IKObjectAspect)root
{
	return [self object:@"self"];
}

+ (IKObjectAspect)object:(CPString)key index:(int)index
{
	return [[IKIndexedAspect alloc] initWithKey:key index:index];
}

- (id)initWithKey:(CPString)key
{
    if (self = [super init])
    {
        _key = key;
    }
    return self;
}

- (BOOL)isSelfAspect
{
    return [_key isEqualToString:@"self"];
}

- (CPImage)smallImageFor:(id)object
{
	return [[self readFrom:object] ikSmallImage];
}

- (CPString)shortDisplayKey
{
    return _key;
}

- (CPString)longDisplayKey
{
    return "." + [self shortDisplayKey];
}

@end
