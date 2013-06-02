/*
 * IKWindowController.j
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

@import <AppKit/AppKit.j>
@import "InspectKitClass.j"
@import "IKAspectAccessor.j"
@import "IKAspectsController.j"

@implementation IKWindowController : CPWindowController
{
    IKAspectAccessor _accessor @accessors(property=accessor, readonly);

    @outlet CPView propertiesView;
    IKAspectsController propertiesController;

    @outlet CPView detailsView;
}

- (id)initWithSubject:(id)subject
{
    var path = [[InspectKit bundle] pathForResource:@"InspectorWindow.cib"];
    if (self = [super initWithWindowCibPath:path owner:self])
    {
        _accessor = [[IKAspectAccessor alloc] initWithSubject:subject];
        [propertiesController setAccessor: _accessor];
    }
    return self;
}

- (void)awakeFromCib
{
    propertiesController = [[IKAspectsController alloc] initWithCibName:@"AspectsView" bundle:[InspectKit bundle]];
    [propertiesController setAccessor: _accessor];
    [[propertiesController view] setFrame:[propertiesView bounds]];
    [propertiesView addSubview:[propertiesController view]];
}

@end
