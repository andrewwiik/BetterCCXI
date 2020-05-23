typedef struct CCUILayoutSize {
    NSUInteger width;
    NSUInteger height;
} CCUILayoutSize;

typedef struct CCUILayoutPoint {
    NSUInteger x;
    NSUInteger y;
} CCUILayoutPoint; 

typedef struct CCUILayoutRect {
    CCUILayoutPoint origin;
    CCUILayoutSize size;
} CCUILayoutRect;


@interface NSValue (CCUILayout)
+ (NSValue *)ccui_valueWithLayoutRect:(CCUILayoutRect)rect;
+ (NSValue *)ccui_valueWithLayoutSize:(CCUILayoutSize)size;
+ (NSValue *)ccui_valueWithLayoutPoint:(CCUILayoutPoint)point;
@property(readonly) CCUILayoutRect ccui_rectValue;
@property(readonly) CCUILayoutSize ccui_sizeValue;
@property(readonly) CCUILayoutPoint ccui_pointValue;
- (CCUILayoutPoint)ccui_pointValue;
- (CCUILayoutRect)ccui_rectValue;
- (CCUILayoutSize)ccui_sizeValue;
@end