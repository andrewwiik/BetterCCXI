#import "BCMControlCenterPositionProvider.h"

@implementation BCMControlCenterPositionProvider

-(void)regenerateRectsWithOrderedIdentifiers:(NSArray<NSString *> *)orderedIdentifiers orderedSizes:(NSArray<NSValue *> *)orderedSizes {
	NSArray<NSString *> *_orderedIdentifiers = orderedIdentifiers;
	NSArray<NSValue *> *_orderedSizes = orderedSizes;
}

- (NSMutableDictionary *)orderedStuff {
	if (self.layoutStyle.isLandscape) {
		_numberOfColumns += 10;
	}

	_cachedTest = [NSMutableArray new];

	_framesByIdentifiers = [NSMutableDictionary new];
	NSMutableArray *identifiersToProcess = [_orderedIdentifiers mutableCopy];
	NSMutableArray *finalGrid = [NSMutableArray new];
	NSUInteger currentEnumCount = 0;

	for (int r = 0; r < _numberOfRows; r++) {
	    finalGrid[r] = [NSMutableArray new];
	    for (int c = 0; c < _numberOfColumns; c++) {
	        finalGrid[r][c] = [NSNull null];
	    }
	}


	while ([identifiersToProcess count] > 0) {
		NSMutableDictionary *processedDict = [self testOtherOrderWithIdentifiers:[identifiersToProcess mutableCopy]];
		identifiersToProcess = [[processedDict objectForKey:@"uncalculatedIdentifiers"] mutableCopy];
		NSMutableArray *calculatedGrid = [processedDict objectForKey:@"calculatedGrid"];
		for (int r = 0; r < [calculatedGrid count]; r++) {
			NSMutableArray *row = calculatedGrid[r];
			for (int c = 0; c < [row count]; c++) {
				finalGrid[r][c + 2*currentEnumCount] = calculatedGrid[r][c];
			}
		}
		[_cachedTest addObject:calculatedGrid];
		currentEnumCount++;
	}
	_enumCount = currentEnumCount;

	self.otherCachedTest = finalGrid; 

	NSMutableArray *orderedSizes = [NSMutableArray new];

	NSUInteger maxCol = 0;
	NSUInteger maxRow = 0;
	for (int r = 0; r < [finalGrid count]; r++) {
		NSMutableArray *row = finalGrid[r];
	    for (int c = 0; c < [row count]; c++) {
	     
	        if (!isNSNull(finalGrid[r][c])) {
	            if (c > maxCol) maxCol = c;
	            if (r > maxRow) maxRow = r;
	  
	        } else {
	        }
	    }
	}

	_numberOfColumns = maxCol + 1;
	_numberOfRows = maxRow + 1;

	for (int r = 0; r < _numberOfRows; r++) {
	    for (int c = 0; c < _numberOfColumns; c++) {
	        if (!isNSNull(finalGrid[r][c])) {
	            [orderedSizes addObject:finalGrid[r][c]];
	        } else {
	        	[orderedSizes addObject:@"empty"];
	        }
	    }
	}


	//NSMutableArray *ordered = [NSMutableArray new];
	for (NSString *identifier in _orderedIdentifiers) { 
		if ([orderedSizes containsObject:identifier]) {
			NSInteger index = [orderedSizes indexOfObject:identifier];
			MZEModuleCoordinate coord = MZEModuleCoordinateMake((index / (int)_numberOfColumns) + 1, (index % (int)_numberOfColumns) + 1);
			int moduleWidth = [[_orderedSizes objectAtIndex:[_orderedIdentifiers indexOfObject:identifier]] CGSizeValue].width;
	    	int moduleHeight = [[_orderedSizes objectAtIndex:[_orderedIdentifiers indexOfObject:identifier]] CGSizeValue].height;
			CGRect position = CGRectMake(coord.col,coord.row,moduleWidth,moduleHeight);

			CGFloat x = (position.origin.x -1)*_layoutStyle.moduleSize + (position.origin.x -1)*_layoutStyle.spacing;
			CGFloat y = (position.origin.y -1)*_layoutStyle.moduleSize + (position.origin.y -1)*_layoutStyle.spacing;
			CGFloat width = position.size.width*_layoutStyle.moduleSize+(position.size.width - 1)*_layoutStyle.spacing;
			CGFloat height = position.size.height*_layoutStyle.moduleSize+(position.size.height - 1)*_layoutStyle.spacing;

			[_framesByIdentifiers setObject:[NSValue valueWithCGRect:CGRectMake(x,y,width,height)] forKey:identifier];

		}
	}
	return _framesByIdentifiers;
}
@end