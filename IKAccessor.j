/*
 * IKAccessor.j
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

@import "IKObjectDescriptor.j"

@implementation IKAccessor : CPObject
{
    id _subject     @accessors(readonly, property=object);
    IKDescriptor _descriptor   @accessors(readonly, property=descriptor);
}

- (id)initWithSubject:(id)subject descriptor:(IKDescriptor)descriptor
{
    if (self = [super init])
    {
        _subject = subject;
        _descriptor = descriptor;
    }
    return self;
}

- (id)initWithSubject:(id)subject
{
    return [self initWithSubject:subject descriptor:[[IKObjectDescriptor alloc] initWithKeyPath:@"self"]];
}

- (CPString)description
{
    return "<" + [self className] + " 0x" + [CPString stringWithHash:[self UID]] + " (" +  [_subject description] + " / " + [_descriptor description] + ")>";
}

- (CPString)subjectKeyPath
{
    return [_descriptor keyPath];
}

- (CPString)subjectKey
{
    return [_descriptor key];
}

- (id)subjectValue
{
    return [_descriptor valueForSubject:_subject];
}

- (CPString)subjectDescription
{
    return [[self subjectValue] ikDescription];
}

- (CPArray)subjectChildren
{
    return [_descriptor childrenForSubject:_subject];
}

@end
