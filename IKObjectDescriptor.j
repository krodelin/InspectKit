/*
 * IKObjectDescriptor.j
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

@class IKAccessor

@implementation IKObjectDescriptor : CPObject
{
    CPString    _keyPath    @accessors(readonly, property=keyPath)
}

- (id)initWithKeyPath:(CPString)keyPath
{
    if (self = [super init])
    {
        _keyPath = keyPath;
    }
    return self;
}

- (CPString)keyPrefix
{
    if(!(_keyPath == @"self"))
        return _keyPath + @": ";
    else
        return @"";
}

- (id)valueForSubject:(id)subject
{
    return [subject valueForKeyPath:_keyPath];
}

- (CPImage)imageForSubject:(id)subject
{
    return [[self valueForSubject:subject] ikImage];
}

- (CPArray)childrenForSubject:(id)subject
{
    var subjectValue = [self valueForSubject:subject],
        aspects = [subjectValue ikDescriptions];
    if(!aspects)
        return [];

    return aspects.map(function (eachDescriptor){
        return [[IKAccessor alloc] initWithSubject:subjectValue descriptor:eachDescriptor];
    });

}

@end
