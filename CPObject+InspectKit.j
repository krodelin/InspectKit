/*
 * CPObject+InspectKit.j
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
@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>
@import "InspectKitClass.j"
@import "IKWindowController.j"

@implementation CPObject (InspectKit)

- (void)inspect
{
    var windowController = [[IKWindowController alloc] initWithSubject:self];
    [windowController showWindow:self];
}

+ (CPArray)ikPublishedAspectsOfInstances
{
    return @[ ];
}

- (CPArray)ikPublishedAspects
{
    var c = [self class];
    return [c ikPublishedAspectsOfInstances];
}

- (CPString)ikDisplayString
{
    return "<" + [self className] + ">";
}

- (CPString)ikSmallImage
{
    return [[self class] ikSmallImage];
}

+ (CPImage)ikSmallImage
{
    return CPImageInBundle(@"CPObject.png", 16, 16, [InspectKit bundle]);
}

+ (Class)ikDefaultAspectClass
{
	return IKObjectAspect;
}

- (Class)ikDefaultAspectClass
{
	return [[self class] ikDefaultAspectClass];
}

@end


