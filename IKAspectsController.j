/*
 * IKAspectsController.j
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

@implementation IKAspectsController : CPViewController // <CPOutlineViewDataSource>
{
    IKAspectAccessor _accessor;
    @outlet CPOutlineView _outlineView;
}

- (void)setAccessor:(IKAspectAccessor)accessor
{
    // CPLog.trace(@"%@ - (void)setAccessor:(IKAspectAccessor)%@", self, accessor);

    _accessor = accessor;
}

- (IKAspectAccessor)accessor
{
    return _accessor;
}

- (id)outlineView:(CPOutlineView)outlineView child:(CPInteger)index ofItem:(id)item
{
    // CPLog.trace(@"%@ - (id)outlineView:(CPOutlineView)%@ child:(CPInteger)%@ ofItem:(id)%@", self, outlineView, index, item);

    if(!item)
        return _accessor;

    return [[item subAccessors] objectAtIndex:index];
}

- (BOOL)outlineView:(CPOutlineView)outlineView isItemExpandable:(id)item
{
    // CPLog.trace(@"%@ - (BOOL)outlineView:(CPOutlineView)%@ isItemExpandable:(id)%@", self, outlineView, item);

    return [self outlineView:outlineView numberOfChildrenOfItem:item] > 0;
}
- (int)outlineView:(CPOutlineView)outlineView numberOfChildrenOfItem:(id)item
{
    // CPLog.trace(@"%@ - (int)outlineView:(CPOutlineView)%@ numberOfChildrenOfItem:(id)%@", self, outlineView, item);

    if(!_accessor)
        return 0;

    if(!item)
        return 1;

    return [[item subAccessors] count];
}

- (id)_outlineView:(CPOutlineView)outlineView objectValueForTableColumn:(CPTableColumn)tableColumn byItem:(id)item
{
    // CPLog.trace(@"%@ - (id)outlineView:(CPOutlineView)%@ objectValueForTableColumn:(CPTableColumn)%@ byItem:(id)%@", self, outlineView, tableColumn, item);

    var value = [item valueDisplayString];
    if ([item valueIsRoot])
    {
        return [CPString stringWithFormat:"%@", value];
    }
    else
    {
        var key = [item valueKey];
        return [CPString stringWithFormat:"%@ = %@", key, value];
    }
}

- (id)outlineView:(id)outlineView viewForTableColumn:(id)tableColumn item:(id)item
{
    var tableCellView = [outlineView makeViewWithIdentifier:@"propertyCell" owner:self],
        value = [item valueDisplayString],
        text;
    if ([item valueIsRoot])
    {
        text = [CPString stringWithFormat:"%@", value];
    }
    else
    {
        var key = [item valueKey];
        text = [CPString stringWithFormat:"%@ = %@", key, value];
    }
    [[tableCellView textField] setStringValue:text];
    [[tableCellView imageView] setImage:[item valueImage]];
    return tableCellView;
}

@end
