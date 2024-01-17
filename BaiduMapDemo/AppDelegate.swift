import UIKit
import BaiduMapAPI_Base

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mapManager = BMKMapManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 初始化百度地图SDK
        BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORD_TYPE.COORDTYPE_BD09LL)
        mapManager.start("ba7bShEIGMRfuVfkTxeLci6OKfnWbVoV", generalDelegate: nil)
        return true
    }
}
