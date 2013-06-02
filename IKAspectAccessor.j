/*
 * IKAspectAccessor.j
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

@import "IKAspect.j"

@implementation IKAspectAccessor : CPObject
{
    id _subject @accessors(property=subject, readonly);
    IKAspect _aspect @accessors(property=aspect, readonly);
}

- (IKAspectAccessor)initWithSubject:(id)subject aspect:(IKAspect)aspect
{
    if (self = [super init])
    {
        _subject = subject;
        _aspect = aspect
    }
    return self;
}

- (IKAspectAccessor)initWithSubject:(id)subject
{
    return [self initWithSubject:subject aspect:[IKAspect root]];
}

- (CPArray)subAccessors
{
    var value = [self value],
        aspects = [value ikPublishedAspects],
        children = [[CPMutableArray alloc] init];
    [aspects enumerateObjectsUsingBlock:(function (eachAspect){
        var accessor = [[IKAspectAccessor alloc] initWithSubject:value aspect:eachAspect];
        [children addObject: accessor];
    })];
    return children;
}

- (CPString)valueKey
{
    return [_aspect key];
}

- (id)value
{
    return [_aspect readFrom:_subject];
}

- (CPString)valueDisplayString
{
    return [[self value] ikDisplayString];
}

- (CPImage)valueImage
{
    return [_aspect smallImageFor:_subject];
}

- (BOOL)valueIsRoot
{
    return [_aspect isRoot];
}

@end
