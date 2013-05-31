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
    var windowController = [[IKWindowController alloc] initWithObject:self];
    [windowController showWindow:self];
}

+ (CPArray)instanceVariableNames
{
    return self.ivar_list.map(function (ivar){return ivar.name});
}

- (CPArray)instanceVariableNames
{
    // CPLog(@"%@ - (CPArray)instanceVariableNames = %@", self, [[self class] instanceVariableNames]);
    return [[self class] instanceVariableNames];
}

+ (CPArray)ikDescriptionsOfInstances
{
    return [
        // [[IKDescriptor alloc] initWithKeyPath:@"description"]
    ];
}

- (CPArray)ikDescriptions
{
    var c = [self class];
    return [c ikDescriptionsOfInstances];
}

- (CPString)ikDescription
{
    return [self description];
}

- (CPImage)ikImage
{
    return CPImageInBundle(@"CPObject.png", 16, 16, [InspectKit bundle]);
}

@end


