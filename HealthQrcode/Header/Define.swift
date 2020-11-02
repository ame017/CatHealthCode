//
//  Define.swift
//  HealthQrcode
//
//  Created by AME on 2020/7/29.
//  Copyright © 2020 ame017. All rights reserved.
//

import Foundation

/*----------------颜色----------------*/
//let COLOR_BLUE = UIColor.init(named: "blue_normal")
//let COLOR_BLUE_80 = UIColor.init(named: "blue_80")
//let COLOR_BLUE_50 = UIColor.init(named: "blue_50")
//let COLOR_VIEW_BLUE = UIColor.init(named: "view_blue")
//let COLOR_DARK_BLUE = UIColor.init(named: "view_dark_blue")
//let COLOR_MIDDLE_BLUE = UIColor.init(named: "view_blue_middle")

/*----------------颜色----------------*/

/*----------------工具宏----------------*/

//APP版本
let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
//build
let APP_BUILD = Bundle.main.infoDictionary!["CFBundleVersion"]
//设备版本
let SYSTEM_VERSION = Float(UIDevice.current.systemVersion)
//设备语言
let CURRENT_LANGUAGE = NSLocale.preferredLanguages[0]


//获取沙盒Document路径
let kDocumentPath = NSHomeDirectory() + "/Documents/"
//获取沙盒temp路径
let kTempPath = NSTemporaryDirectory()
//获取沙盒Cache路径
let kCachePath = NSHomeDirectory() + "/Library/Caches/"

//用10进制表示颜色，例如（255,255,255）白色
func AMEColorAlpha(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat)-> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}
func AMEColor(r:CGFloat, g:CGFloat, b:CGFloat)-> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

//转字符串
/*----------------工具宏----------------*/


/*----------------界面宏----------------*/
//WIDTH和HEIGHT
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height



func UI_IS_IPAD()->Bool{
    return UIDevice.current.userInterfaceIdiom == .pad
}
func UI_IS_IPHONE()->Bool{
    return UIDevice.current.userInterfaceIdiom == .phone
}
func SCREENSIZE_IS_35 ()->Bool{
    return UI_IS_IPHONE() && (SCREEN_HEIGHT < 568.0)
}
func SCREENSIZE_IS_40 ()->Bool{
    return UI_IS_IPHONE() && (SCREEN_HEIGHT == 568.0)
}
func SCREENSIZE_IS_47 ()->Bool{
    return UI_IS_IPHONE() && (SCREEN_HEIGHT == 667.0)
}
func SCREENSIZE_IS_55 ()->Bool{
    return UI_IS_IPHONE() && (SCREEN_HEIGHT == 736.0)
}
func SCREENSIZE_IS_XR ()->Bool{
    return __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode!.size) && !UI_IS_IPAD()
}
func SCREENSIZE_IS_X ()->Bool{
    return __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode!.size) && !UI_IS_IPAD()
}
func SCREENSIZE_IS_XS_MAX ()->Bool{
    return __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode!.size) && !UI_IS_IPAD()
}
func IS_IPhoneX_All () ->Bool{
    return SCREEN_HEIGHT == 812.0 || SCREEN_HEIGHT == 896.0
}

func kStatusBarHeight() -> Float {
    var statusBarHeight : Float = 0.0
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        statusBarHeight = Float(statusBarManager!.statusBarFrame.size.height)
    }else{
        Float(UIApplication.shared.statusBarFrame.size.height)
    }
    return statusBarHeight
}
func kNavigationBarHeight () -> Float{
    var navh: Float = 44.0
    
    if #available(iOS 12.0, *) {
        navh += Float((UIApplication.shared.delegate?.window?!.safeAreaInsets.top)!)
    }else if SCREENSIZE_IS_X(){
        navh += Float((UIApplication.shared.delegate?.window?!.safeAreaInsets.top)!)
    }else{
        navh += Float(UIApplication.shared.statusBarFrame.size.height)
    }
    return navh
}

let kTabbarSafeBottomMargin = IS_IPhoneX_All() ? 34.0 : 0
let kTabbarHeight = kTabbarSafeBottomMargin + 49.0
let kStatusBarAndNavigationBarHeight = kStatusBarHeight() + kNavigationBarHeight()

@available(iOS 11.0, *)
func kViewSafeAreInsets(view : UIView) ->UIEdgeInsets{
    var insets = UIEdgeInsets()
    insets = view.safeAreaInsets
    return insets
}

//比例计算
let X_P = (SCREEN_WIDTH/375.0)
let Y_P = (SCREEN_HEIGHT/667.0)

/*----------------界面宏----------------*/
