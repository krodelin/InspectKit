/*
 * IKIndexedAspect.j
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
@import "IKObjectAspect.j"

@implementation IKIndexedAspect : IKObjectAspect
{
    int _index @accessors(property=index, readonly);
}

- (IKIndexedAspect)initWithKey:key index:(int)index
{
    if (self = [super initWithKey:key])
    {
        _index = index;
    }
    return self;
}

- (id)readFrom:(id)object
{
    var value = [super readFrom:object] ;
    return [value objectAtIndex:_index];
}

- (void)write:(id)value into:(id)object
{
    debugger;
}

- (CPString)shortDisplayKey
{
    return _index;
}

- (CPString)longDisplayKey
{
    return "[" + _index + "]";
}

@end
