/*
 * IKPropertiesViewController.j
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
@import "IKAccessor.j"

@implementation IKPropertiesViewController : CPViewController // <CPOutlineViewDataSource>
{
    IKAccessor _accessor;
    @outlet CPOutlineView _outlineView;
}

- (void)setAccessor:(IKAccessor)accessor
{
    // CPLog.trace(@"%@ - (void)setAccessor:(IKAccessor)%@", self, accessor);

    _accessor = accessor;
    [_outlineView reloadData];
}

- (IKAccessor)accessor
{
    return _accessor;
}

- (id)outlineView:(CPOutlineView)outlineView child:(CPInteger)index ofItem:(id)item
{
    // CPLog.trace(@"%@ - (id)outlineView:(CPOutlineView)%@ child:(CPInteger)%@ ofItem:(id)%@", self, outlineView, index, item);

    if(!_accessor)
        return null;

    if(!item)
        return _accessor;

    return [[item subjectChildren] objectAtIndex:index];
}

- (BOOL)outlineView:(CPOutlineView)outlineView isItemExpandable:(id)item
{
    // CPLog.trace(@"%@ - (BOOL)outlineView:(CPOutlineView)%@ isItemExpandable:(id)%@", self, outlineView, item);

    if(!_accessor)
        return NO;

    if(!item)
        return YES;

    return [[item subjectChildren] count] > 0;
}
- (int)outlineView:(CPOutlineView)outlineView numberOfChildrenOfItem:(id)item
{
    // CPLog.trace(@"%@ - (int)outlineView:(CPOutlineView)%@ numberOfChildrenOfItem:(id)%@", self, outlineView, item);

    if (!_accessor)
        return 0;

    if (!item)
        return 1;

    return [[item subjectChildren] count];
}

- (id)_outlineView:(CPOutlineView)outlineView objectValueForTableColumn:(CPTableColumn)tableColumn byItem:(id)item
{
    // CPLog.trace(@"%@ - (id)outlineView:(CPOutlineView)%@ objectValueForTableColumn:(CPTableColumn)%@ byItem:(id)%@", self, outlineView, tableColumn, item);

    if (!_accessor)
        return @"";

    if (!item)
        return @"Root";

    var prefix = [item subjectKey],
        text = (prefix == "self" ? "" : prefix + " = ") + [item subjectDescription];
    return text;
}

- (id)outlineView:(id)outlineView viewForTableColumn:(id)tableColumn item:(id)item
{
    var view = [outlineView makeViewWithIdentifier:@"propertyCell" owner:self],
        text = [item subjectKeyPrefix] + [item subjectDescription];
    [[view textField] setStringValue:text];
    [[view imageView] setImage:[item subjectImage]];
    return view;
}

@end
