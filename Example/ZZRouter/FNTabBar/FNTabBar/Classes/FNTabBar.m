//
//  FNTabBar.m
//  FNTableViewController
//
//  Created by 张三松 on 16/7/27.
//  Copyright © 2017年ZZRouter All rights reserved.
//

#import "FNTabBar.h"
#import "UIButton+WebCache.h"
#import "UIColor+FNColor.h"
#import "BFKit.h"

typedef enum : NSUInteger {
    UITabBarItemBadgeStyleNumber = 0,
    UITabBarItemBadgeStyleSpot,
    UITabBarItemBadgeStyleWarning,
    UITabBarItemBadgeStyleCustome
} UITabBarItemBadgeStyle;

#define kScreenWidth [UIScreen mainScreen].bounds.size.width;
#define kScreenHeight [UIScreen mainScreen].bounds.size.height;
#define kWidthChange(A) (A * [UIScreen mainScreen].bounds.size.width / 375)

@interface FNTabBar ()

@property (nonatomic, copy)CustomeItemBlock centerBlock;
@property (nonatomic, copy)CustomeItemBlock customeBlock;


@property (nonatomic, assign)CGFloat itemButtonWidth;

//中心浮层
@property (nonatomic, strong)UIButton *centerButton;
@property (nonatomic, strong)UIImage *centerImage;
@property (nonatomic, strong)UIImage *selectedCenterImage;
@property (nonatomic, strong)NSString *centerUrlString;
@property (nonatomic, strong)NSString *selectedCenterUrlString;

//浮层图片数组
@property (nonatomic, strong)NSArray *imageArray;
@property (nonatomic, strong)NSArray *selectedImageArray;

@property (nonatomic, strong)UIButton *selectedCustomeButton;//记录上一次选中的浮层
@property (nonatomic, assign)BOOL selectedCenterButton;//记录选中的中间浮层

@property (nonatomic, assign)BOOL change;//判断自定义item当前状态，避免多次点击赋值操作反复执行
@property (nonatomic, assign)BOOL hidden;//判断tabBar顶部横线是否隐藏
@property (nonatomic, assign, getter=isHitValid)BOOL hitValid;

@end

static NSUInteger const numberBadgeStartTagNumber = 10110;
static NSUInteger const spotBadgeStartTagNumber = 10210;
static NSUInteger const warningBadgeStartTagNumber = 10310;
static NSUInteger const customebadgeStartTagNumber = 10410;
static NSUInteger const customeEnlargeButtonStartTag = 10510;

@implementation FNTabBar

//item布局: 2 item 4 item 4 item 2
- (instancetype)init {
    if (self = [super init]) {
        self.clipsToBounds = NO;
        self.shadowImage = [[UIImage imageWithColor:[UIColor fn_colorWithColorKey:FNColor_Line]] imageByScalingToSize:CGSizeMake(SCREEN_WIDTH, 0.5)];
        self.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] &&  view.tag >= customeEnlargeButtonStartTag && view.tag <= customeEnlargeButtonStartTag + 5) {
            [self bringSubviewToFront:view];
        }
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] &&  view.tag >= numberBadgeStartTagNumber && view.tag <= customebadgeStartTagNumber + 5) {
            [self bringSubviewToFront:view];
        }
    }
}

- (void)fn_addSystemEnlagerImageWithImageURLStringArray:(NSArray *)URLStringArray selectedImageURLStringArray:(NSArray *)selectedURLStringArray titleArray:(NSArray *)titleArray {
    
    if (URLStringArray.count != self.items.count) {
        
        return;
    }
    for (NSInteger i = 0; i < self.items.count; i ++) {
        
        UITabBarItem *item = self.items[i];
        NSString *normalURLString = URLStringArray[i];
        NSString *selectedURLString = selectedURLStringArray[i];
        NSString *title = titleArray[i];
        item.title = title;
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:normalURLString] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            if (!image) {
                
                return;
            }
            UIImage *scaleImage = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:image.imageOrientation];
            item.image = [scaleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }];
        
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:selectedURLString] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            
            if (!image) {
                
                return;
            }
            UIImage *scaleImage = [UIImage imageWithCGImage:image.CGImage scale:[UIScreen mainScreen].scale orientation:image.imageOrientation];
            item.selectedImage = [scaleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }];
    }
}

//添加中间浮层 url
- (void)fn_addCenterEnlargeImageWithImageUrl:(NSString *)imageString selectedImageUrl:(NSString *)selectedImageString {
    [self getItemWidth];
    [self fn_removeAllEnlargeImage];//移除已经存在的浮层
    self.centerUrlString = imageString;
    self.selectedCenterUrlString = selectedImageString;
    self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerButton.tag = customeEnlargeButtonStartTag + floor(self.itemCount / 2.0);
    [self fn_addEnlagerItemButton:self.centerButton withImageUrlString:imageString selectedImageUrlString:selectedImageString atIndex:floor(self.itemCount / 2.0)];
    [self.centerButton addTarget:self action:@selector(didClickCenterButton:) forControlEvents:UIControlEventTouchUpInside];
}

//添加全部浮层 url
- (void)fn_addEnlagerImageWithImageURLStringArray:(NSArray *)URLStringArray selectedImageURLStringArray:(NSArray *)selectedURLStringArray {
    [self getItemWidth];
    [self fn_removeAllEnlargeImage];//移除已经存在的浮层
    
    self.imageArray = [NSArray arrayWithArray:URLStringArray];
    self.selectedImageArray = [NSArray arrayWithArray:selectedURLStringArray];
    for (int i = 0; i < URLStringArray.count; i++) {
        UIButton *customeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customeButton.tag = customeEnlargeButtonStartTag + i;
        SEL buttonAction;
        if (i == floor(self.itemCount / 2.0)) {
            self.centerButton = customeButton;
            self.centerUrlString = URLStringArray[i];
            self.selectedCenterUrlString = selectedURLStringArray[i];
            buttonAction =  @selector(didClickCenterButton:);
        }else{
            buttonAction = @selector(didClickCustomeButton:);
        }
        [customeButton addTarget:self action:buttonAction forControlEvents:UIControlEventTouchUpInside];
        [self fn_addEnlagerItemButton:customeButton withImageUrlString:URLStringArray[i] selectedImageUrlString:selectedURLStringArray[i] atIndex:i];
    }
}

//添加浮层 url
- (void)fn_addEnlagerItemButton:(UIButton *)itemButton withImageUrlString:(NSString *)imageUrlString selectedImageUrlString:(NSString *)selectedImageUrlString atIndex:(NSUInteger)index {
    [self hiddenTabBarTopHorizontalLine];
    __weak typeof(self)weakself = self;
    [itemButton sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrlString] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakself setUpItemButton:itemButton atIndex:index];
    }];
}

//添加中间浮层 image
- (void)fn_addCenterEnlargeImageWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    [self getItemWidth];
    [self fn_removeAllEnlargeImage];//移除已经存在的浮层
    self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerButton.tag = customeEnlargeButtonStartTag + floor(self.itemCount / 2.0);
    self.centerImage = image;
    self.selectedCenterImage = selectedImage;
    [self fn_addEnlagerItemButton:self.centerButton withImage:image selectedImage:selectedImage atIndex:floor(self.itemCount / 2.0)];
    [self.centerButton addTarget:self action:@selector(didClickCenterButton:) forControlEvents:UIControlEventTouchUpInside];
}

//全部按钮添加浮层 image
- (void)fn_addEnlagerImageWithImageArray:(NSArray *)imageArray selectedImageArray:(NSArray *)selectedImageArray {
    [self fn_removeAllEnlargeImage];//移除已经存在的浮层
    self.imageArray = [NSArray arrayWithArray:imageArray];
    self.selectedImageArray = [NSArray arrayWithArray:selectedImageArray];
    [self getItemWidth];
    for (int i = 0; i < imageArray.count; i++) {
        UIButton *customeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        customeButton.tag = customeEnlargeButtonStartTag + i;
        SEL buttonAction;
        if (i == floor(self.itemCount / 2.0)) {
            self.centerButton = customeButton;
            self.centerImage = imageArray[i];
            self.selectedCenterImage = selectedImageArray[i];
            buttonAction =  @selector(didClickCenterButton:);
        }else{
            buttonAction = @selector(didClickCustomeButton:);
        }
        [customeButton addTarget:self action:buttonAction forControlEvents:UIControlEventTouchUpInside];
        [self fn_addEnlagerItemButton:customeButton withImage:imageArray[i] selectedImage:selectedImageArray[i] atIndex:i];
    }
}

//添加浮层 image
- (void)fn_addEnlagerItemButton:(UIButton *)itemButton withImage:(UIImage *)image selectedImage:(UIImage *)selectedImage atIndex:(NSUInteger)index {
    [self hiddenTabBarTopHorizontalLine];
    [itemButton setBackgroundImage:image forState:UIControlStateNormal];
    [self setUpItemButton:itemButton atIndex:index];
}

//浮层坐标和大小
- (void)setUpItemButton:(UIButton *)itemButton atIndex:(NSUInteger )index {
    //暂不显示
    [self fn_removeBadgeNumberAtItemIndex:index];
    [self fn_removeSpotAtItemIndex:index];
    [self fn_removeWarningAtItemIndex:index];
    [self fn_removeCustomeAtItemIndex:index];
    
    CGSize size = CGSizeMake(kWidthChange(60), 58);
    if (index == floor(self.itemCount / 2.0)) {
        if (self.centerEnlargeImageSize.width) {
            size = self.centerEnlargeImageSize;
        }
    }else{
        if (self.enlargeImageSize.width) {
            size = self.enlargeImageSize;
        }
        
    }
    itemButton.frame = CGRectMake(0, 0,size.width, size.height);
    CGFloat X = 2 + index * (self.itemButtonWidth + 4) + self.itemButtonWidth * 0.5;
    CGFloat Y = self.frame.size.height - size.height * 0.5 - 15;
    if (index == floor(self.itemCount / 2)) {
        Y = size.height > self.frame.size.height ? Y + 15 : self.frame.size.height * 0.5;
    }
    itemButton.center = CGPointMake(X, Y);
    [self addSubview:itemButton];
    [self bringBadgeToFont];
}

//获取单个item的宽度
- (void)getItemWidth {
    //在此处重置了itemButtonWidth属性的值，同样适用于角标操作
    if (!self.itemCount) {//默认为5
        self.itemCount = 5;
    }
    self.itemButtonWidth = self.frame.size.width / self.itemCount - 4;
}

//移除浮层
- (void)fn_removeAllEnlargeImage {
    self.centerImage = nil;
    self.selectedCenterImage = nil;
    self.centerUrlString = nil;
    self.selectedCenterUrlString = nil;
    self.imageArray = nil;
    self.selectedImageArray = nil;
    self.selectedCustomeButton = nil;
    self.centerEnlargeImageSize = CGSizeZero;
    self.enlargeImageSize = CGSizeZero;
    
    for (int i = 0; i < self.itemCount; i++) {
        NSUInteger tag = i + customeEnlargeButtonStartTag;
        UIView *subView = [self viewWithTag:tag];
        if (subView) {
            [subView removeFromSuperview];
            subView = nil;
        }
    }
}


//自定义浮层响应事件 --> 选中相应的item
- (void)didClickCustomeButton:(UIButton *)sender {
    NSUInteger index = sender.tag - customeEnlargeButtonStartTag;
    if (self.customeBlock ) {//要跳转之前调用相应的代理方法，根据方法返回值确定是否跳转
        self.customeBlock(index);
    }
    if (![self changeViewController]) return;
    
    self.selectedCenterButton = NO;
    NSUInteger selectedIndex = self.selectedCustomeButton.tag - customeEnlargeButtonStartTag;
    if ([[self.imageArray firstObject]isKindOfClass:[UIImage class]]) {//image
        if (self.selectedCustomeButton) {
            [self.selectedCustomeButton setBackgroundImage:self.imageArray[selectedIndex] forState:UIControlStateNormal];
        }
        [sender setBackgroundImage:self.selectedImageArray[index] forState:UIControlStateNormal];
    }else if([[self.imageArray firstObject]isKindOfClass:[NSString class]]) {//url
        if (self.selectedCustomeButton) {
            [self.selectedCustomeButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.imageArray[selectedIndex]] forState:UIControlStateNormal];
        }
        [sender sd_setBackgroundImageWithURL:[NSURL URLWithString:self.selectedImageArray[index]] forState:UIControlStateNormal];
    }
    
    [self selectTabBarItemWithSubView:sender];
    self.selectedCustomeButton = sender;
}

//选中相应的item
- (void)selectTabBarItemWithSubView:(UIButton *)sender {
    Class tabBarController = NSClassFromString(@"FNBaseTabBarController");
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[tabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *)nextResponder;
            tabBarController.selectedIndex = sender.tag % 10;
            return;
        }
    }
}

//中心浮层响应事件
- (void)didClickCenterButton:(UIButton *)sender {
    NSUInteger index = sender.tag - customeEnlargeButtonStartTag;
    if (self.selectedCenterImage && ![self.selectedCustomeButton isEqual:sender]) {
        [sender setBackgroundImage:self.selectedCenterImage forState:UIControlStateNormal];
    }else if (self.selectedCenterUrlString && ![self.selectedCustomeButton isEqual:sender]) {
        [sender sd_setBackgroundImageWithURL:[NSURL URLWithString:self.selectedCenterUrlString] forState:UIControlStateNormal];
    }
    if (self.centerButtonActionDefault) {//选中相应的item
        [self didClickCustomeButton:sender];
    }else{//自定义事件
        if (self.centerBlock) {
            self.centerBlock(index);
        }
    }
    self.change = YES;
    self.selectedCenterButton = YES;
}

//隐藏tabBar顶部的横线
- (void)hiddenTabBarTopHorizontalLine{
    if (!self.hidden) {
        for (UIView * item in self.subviews) {
            if([item isKindOfClass:[UIImageView class]] && item.bounds.size.height <= 1) {
                item.hidden = YES;
                self.hidden = YES;
            }
        }
    }
}


//点击事件处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    
    self.hitValid ^= 1;
    if (!self.isHitValid) {
        
        return hitView;
    }
    //点击tabBar区域，非中心item,交由相应浮层处理
    for (int i = 0; i < self.itemCount; i++) {
        NSUInteger tag = customeEnlargeButtonStartTag + i;
        if ([self viewWithTag:tag]) {
            UIButton *button = [self viewWithTag:tag];
            CGRect rect = CGRectMake(0 + (self.itemButtonWidth + 4) * i, 0, self.itemButtonWidth + 4, self.frame.size.height);
            if (CGRectContainsPoint(rect, point) || CGRectContainsPoint(button.frame, point)) {
                if (![button isEqual:self.centerButton]) {
                    self.selectedCenterButton = NO;
                    [self changeCenterButtonBackgroundImage];
                }
                return button;
            }
        }
    }
    //执行到此步，说明没有点击浮层;
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsPoint(rect, point)) {//点击范围在tabBar内
        self.selectedCenterButton = NO;
        [self changeCenterButtonBackgroundImage];
    }
    
    //没有对应浮层,点击tabBar区域，交由UITabBarButton处理（用于角标响应事件和普通点击处理）
    if (![self viewWithTag:10510]) {
        NSUInteger i = 0;
        Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:tabBarButtonClass]) {
                i++;
                CGRect rect = subView.frame;
                if (CGRectContainsPoint(rect, point)) {
                    if (self.customeBlock) {
                        self.customeBlock(i - 1);
                    }
                    if (![self changeViewController]) return nil;
                    return subView;
                }
            }
        }
    }
    
    return hitView;
}

//配置中间图层的背景图片
- (void)changeCenterButtonBackgroundImage {
    if (self.change && !self.selectedCenterButton) {
        if (self.selectedCenterUrlString) {
            [self.centerButton sd_setBackgroundImageWithURL:[NSURL URLWithString:self.centerUrlString] forState:UIControlStateNormal];
        }
        if (self.centerImage) {
            [self.centerButton setBackgroundImage:self.centerImage forState:UIControlStateNormal];
        }
        self.change = NO;
    }
}

//将角标移到最前面
- (void)bringBadgeToFont {
    for (int i = 0; i < self.itemCount; i++) {
        NSUInteger badgeTag = [self fn_getTagWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleNumber atIndex:i];
        NSUInteger spotTag = [self fn_getTagWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleSpot atIndex:i];
        NSUInteger warningTag = [self fn_getTagWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleWarning atIndex:i];
        NSUInteger customeTag = [self fn_getTagWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleCustome atIndex:i];
        if ([self viewWithTag:badgeTag]) {
            [self bringSubviewToFront:[self viewWithTag:badgeTag]];
        }
        if ([self viewWithTag:spotTag]) {
            [self bringSubviewToFront:[self viewWithTag:spotTag]];
        }
        if ([self viewWithTag:warningTag]) {
            [self bringSubviewToFront:[self viewWithTag:warningTag]];
        }
        if ([self viewWithTag:customeTag]) {
            [self bringSubviewToFront:[self viewWithTag:customeTag]];
        }
    }
}


- (void)addCenterButtonBlock:(CustomeItemBlock)block {
    self.centerBlock = block;
}

- (void)addCustomeButtonBlock:(CustomeItemBlock)block {
    self.customeBlock = block;
}


//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝角标＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//显示圆点，默认样式
- (void)fn_showSpotAtItemIndex:(NSUInteger )index {
    
    [self fn_removeSpotAtItemIndex:index];
    UIButton *spotButton = [self fn_addSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleSpot atIndex:index];
    [spotButton setBackgroundColor:[UIColor redColor]];
}

//显示警告图，默认样式 image
- (void)fn_showWarningWithImage:(UIImage *)image AtItemIndex:(NSUInteger )index {
    [self fn_removeWarningAtItemIndex:index];
    UIButton *warningButton = [self fn_addSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleWarning atIndex:index];
    [warningButton setBackgroundImage:image forState:UIControlStateNormal];
}

//显示警告图，默认样式 url
- (void)fn_showWarningWithUrl:(NSString *)urlString AtItemIndex:(NSUInteger)index {
    [self fn_removeWarningAtItemIndex:index];
    UIButton *warningButton = [self fn_addSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleWarning atIndex:index];
    [warningButton sd_setBackgroundImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal];
}

//显示数字,默认样式
- (void)fn_showNumber:(NSString *)numberString atItemIndext:(NSUInteger )index {
    [self fn_removeBadgeNumberAtItemIndex:index];
    
    if (!numberString.length||[numberString isEqualToString:@"0"]) {
        return;
    }
    if ([numberString intValue] > 99) {
        numberString = @"99+";
    }
    
    UIButton *badgeButton = [self fn_addSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleNumber atIndex:index];
    [badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    badgeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    CGRect rect = badgeButton.frame;
    
    if (numberString.length == 1) {
        
    }
    if (numberString.length == 2) {
        rect.size.width = rect.size.width * 1.35;
        badgeButton.frame = rect;
    }
    if (numberString.length == 3) {
        rect.size.width = rect.size.width * 1.7;
        badgeButton.frame = rect;
    }
    [badgeButton setTitle:numberString forState:UIControlStateNormal];
    [badgeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [badgeButton setBackgroundColor:[UIColor colorWithHex:0xd7063b]];
}


/**
 *
 *  @param image           背景图片
 *  @param frame           大小
 *  @param backgroundColor 背景色
 *  @param title           文字
 *  @param font            文字大小
 *  @param textColor       文字颜色
 *  @param cornerRadius    剪切半径
 *  @param index           相应tabBarItem所在下标
 */
- (void)fn_showImage:(UIImage *)image withFrame:(CGRect )frame backgroudColor:(UIColor *)backgroundColor text:(NSString *)title textFont:(CGFloat )font titleColor:(UIColor *)textColor cornerRadius:(CGFloat )cornerRadius atItemIndex:(NSUInteger )index {
    if (!self.itemButtonWidth) {
        [self getItemButtonWidth];
    }
    [self fn_removeCustomeAtItemIndex:index];
    CGRect rect = frame;
    rect.origin.x = index * self.itemButtonWidth + kWidthChange(frame.origin.x);
    frame = rect;
    UIButton *customeBadgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customeBadgeButton.tag = customebadgeStartTagNumber + index;
    [customeBadgeButton setFrame:frame];
    if (backgroundColor) {
        [customeBadgeButton setBackgroundColor:backgroundColor];
    }
    if (image) {
        [customeBadgeButton setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (title.length) {
        [customeBadgeButton setTitle:title forState:UIControlStateNormal];
        customeBadgeButton.titleLabel.font = [UIFont systemFontOfSize:font];
        [customeBadgeButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (cornerRadius) {
        customeBadgeButton.layer.cornerRadius = cornerRadius;
        customeBadgeButton.layer.masksToBounds = YES;
    }
    [self addSubview:customeBadgeButton];
}

//移除圆点
- (void)fn_removeSpotAtItemIndex:(NSUInteger )index {
    [self fn_removeSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleSpot atIndex:index];
}

//移除Warning
- (void)fn_removeWarningAtItemIndex:(NSUInteger )index {
    [self fn_removeSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleWarning atIndex:index];
}

//移除badgeNumber
- (void)fn_removeBadgeNumberAtItemIndex:(NSUInteger )index {
    [self fn_removeSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleNumber atIndex:index];
}

//移除自定义
- (void)fn_removeCustomeAtItemIndex:(NSUInteger )index {
    [self fn_removeSubViewWithUITabBarItemBadgeStyle:UITabBarItemBadgeStyleCustome atIndex:index];
}


//添加角标控件
- (UIButton *)fn_addSubViewWithUITabBarItemBadgeStyle:(UITabBarItemBadgeStyle )style atIndex:(NSUInteger )index {
    NSUInteger tag = [self fn_getTagWithUITabBarItemBadgeStyle:style atIndex:index];
    if (!self.itemButtonWidth) {
        [self getItemButtonWidth];
    }
    CGRect rect = CGRectZero;
    CGFloat X = 2 + (index * self.itemButtonWidth + 4) + self.itemButtonWidth / 2;
    if ([self viewWithTag:customeEnlargeButtonStartTag]) {
        X += 3;
    }
    if (style == UITabBarItemBadgeStyleNumber) {
        rect = CGRectMake(X + kWidthChange(10), 3, 17, 17);
    }
    if (style == UITabBarItemBadgeStyleSpot) {
        rect = CGRectMake(X + kWidthChange(15), 5,  8, 8);
    }
    if (style == UITabBarItemBadgeStyleWarning) {
        rect = CGRectMake(X + kWidthChange(17), 21, 20, 20);
    }
    if (![self viewWithTag:tag]) {
        UIButton *badgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        badgeButton.tag = tag;
        [badgeButton setFrame:rect];
        if (style != UITabBarItemBadgeStyleWarning) {
            [self fn_maskToRollWithView:badgeButton frame:rect];
        }
        [self addSubview:badgeButton];
         return badgeButton;
    }
    return nil;
}

//删除角标控件
- (void)fn_removeSubViewWithUITabBarItemBadgeStyle:(UITabBarItemBadgeStyle )style atIndex:(NSUInteger )index {
    NSUInteger tag = [self fn_getTagWithUITabBarItemBadgeStyle:style atIndex:index];
    if ([self viewWithTag:tag]) {
        [[self viewWithTag:tag]removeFromSuperview];
    }
}

//获取角标控件的tag值
- (NSUInteger )fn_getTagWithUITabBarItemBadgeStyle:(UITabBarItemBadgeStyle )style atIndex:(NSUInteger )index {
    NSUInteger tag = 0;
    if (style == UITabBarItemBadgeStyleNumber) {
        tag = numberBadgeStartTagNumber + index;
    }
    if (style == UITabBarItemBadgeStyleSpot) {
        tag = spotBadgeStartTagNumber + index;
    }
    if (style == UITabBarItemBadgeStyleWarning) {
        tag = warningBadgeStartTagNumber + index;
    }
    if (style == UITabBarItemBadgeStyleCustome) {
        tag = customebadgeStartTagNumber + index;
    }
    return tag;
}


//截成圆形
- (void)fn_maskToRollWithView:(UIView *)view frame:(CGRect )frame {
    view.layer.cornerRadius = frame.size.width / 2;
    view.layer.masksToBounds = YES;
}


//获取每个item的宽度
- (void)getItemButtonWidth {
    self.itemCount = 0;
    Class itemButtonClass = NSClassFromString(@"UITabBarButton");
    for (UIView *item in self.subviews) {
        if([item isKindOfClass:itemButtonClass]) {
            self.itemCount++;
        }
    }
    if (!self.itemCount) {
        self.itemButtonWidth = [UIScreen mainScreen].bounds.size.width / 5 - 4;
    }else{
        self.itemButtonWidth = [UIScreen mainScreen].bounds.size.width / self.itemCount - 4;
    }
}

//是否跳转到相应的viewController
- (BOOL )changeViewController {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [[user objectForKey:@"tabBar_change_delegate"] boolValue];
}



@end
