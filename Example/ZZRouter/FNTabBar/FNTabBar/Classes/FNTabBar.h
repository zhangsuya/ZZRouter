//
//  FNTabBar.h
//  FNTableViewController
//
//  Created by 张三松 on 16/7/27.
//  Copyright © 2017年 FeiNiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomeItemBlock)(NSUInteger index);
@interface FNTabBar : UITabBar

/**
 *  接口为tabBarItem添加浮层操作
 * 默认tabBarItem的个数为5个，如果tabBarItem的个数不为5个，则需要外部为itemCount属性赋值;
 * 所有浮层默认大小为(60,58),如果想改变浮层大小请为相关属性赋值;
 * 除中心浮层外其余浮层点击事件为选中相应的item,且不支持自定义点击事件;
 * 中心浮层的点击事件默认为自定义事件（addCustomeCenterButtonBlock:）,如果点击中心浮层需要选中相应的item的话，将属性centerButtonActionDefault置为YES即可;
 */


/**tabBarItem的个数,默认为5个*/
@property (nonatomic, assign)NSUInteger itemCount;

/**点击中心图层是否选中相应的item，默认为NO*/
@property (nonatomic, assign)BOOL centerButtonActionDefault;

/**设定中心浮层的大小，默认为(60,58)*/
@property (nonatomic, assign)CGSize centerEnlargeImageSize;

/**设定除中心浮层外其余浮层的大小，默认为(60,58)*/
@property (nonatomic, assign)CGSize enlargeImageSize;

/**
 *  替换系统的图片
 *
 *  @param URLStringArray         要添加的浮层的默认图片链接数组
 *  @param selectedURLStringArray 要添加的浮层选中后的图片链接数组
 */
- (void)fn_addSystemEnlagerImageWithImageURLStringArray:(NSArray *)URLStringArray selectedImageURLStringArray:(NSArray *)selectedURLStringArray titleArray:(NSArray *)titleArray;


/**
 *  为中间item添加浮层
 *
 *  @param imageString         默认图片字符串链接
 *  @param selectedImageString 选中后图片字符串链接
 */
- (void)fn_addCenterEnlargeImageWithImageUrl:(NSString *)imageString selectedImageUrl:(NSString *)selectedImageString;

/**
 *  为中间item添加浮层
 *
 *  @param image         默认图片
 *  @param selectedImage 选中后图片
 */
- (void)fn_addCenterEnlargeImageWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;


/**
 *  全部item都添加浮层
 *
 *  @param URLStringArray         要添加的浮层的默认图片链接数组
 *  @param selectedURLStringArray 要添加的浮层选中后的图片链接数组
 */
- (void)fn_addEnlagerImageWithImageURLStringArray:(NSArray *)URLStringArray selectedImageURLStringArray:(NSArray *)selectedURLStringArray;

/**
 *  全部item都添加浮层
 *
 *  @param imageArray         要添加的浮层的默认图片数组
 *  @param selectedImageArray 要添加的浮层选中后的图片数组
 */
- (void)fn_addEnlagerImageWithImageArray:(NSArray *)imageArray selectedImageArray:(NSArray *)selectedImageArray;


/**中心浮层响应事件回调*/
- (void)addCenterButtonBlock:(CustomeItemBlock )block;

- (void)addCustomeButtonBlock:(CustomeItemBlock )block;

/**移除所有浮层*/
- (void)fn_removeAllEnlargeImage;



/**
 *  接口为tabBarItem提供添加角标操作
 * 如需为一个tabBarItem添加多个角标或者需要改变角标的显示样式及位置，请使用该类中的方法；
 * 系统的所有属性可以正常使用；
 * FN_ShowNumber: atItemIndext:方法与系统的badgeValue属性作用相同
 * 默认点击角标会选中角标所在的tabBarItem
 */

//=========================默认角标样式=============================
/*显示圆点**/
- (void)fn_showSpotAtItemIndex:(NSUInteger )index;

/*显示警告 image**/
- (void)fn_showWarningWithImage:(UIImage *)image AtItemIndex:(NSUInteger )index;
/*显示警告  url**/
- (void)fn_showWarningWithUrl:(NSString *)urlString AtItemIndex:(NSUInteger )index;


/*显示数字**/
- (void)fn_showNumber:(NSString *)numberString atItemIndext:(NSUInteger )index;


//=========================添加自定义角标=============================
/**自定义
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
- (void)fn_showImage:(UIImage *)image withFrame:(CGRect )frame backgroudColor:(UIColor *)backgroundColor text:(NSString *)title textFont:(CGFloat )font titleColor:(UIColor *)textColor cornerRadius:(CGFloat )cornerRadius atItemIndex:(NSUInteger )index;


//=========================移除角标=============================
/*移除圆点**/
- (void)fn_removeSpotAtItemIndex:(NSUInteger )index;

/*移除警告图**/
- (void)fn_removeWarningAtItemIndex:(NSUInteger )index;

/*移除数字角标**/
- (void)fn_removeBadgeNumberAtItemIndex:(NSUInteger )index;

/*移除自定义*/
- (void)fn_removeCustomeAtItemIndex:(NSUInteger )index;



@end
