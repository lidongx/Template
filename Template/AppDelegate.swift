//
//  AppDelegate.swift
//  Template
//
//  Created by lidong on 2023/9/27.
//

import UIKit
import FpgSdk
import OneSignal
import IQKeyboardManagerSwift
import IAPManager
import RevenueCat
import MPEvent
import Firebase
import Mixpanel

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //需求:延迟1秒
        Thread.sleep(forTimeInterval: 1)
        Template.check()
        
        FirebaseApp.configure()
        FpgSdk.shared.setup()
        
        setupIAPManager { [weak self] userid in
            self?.setupMixpanel(userId: userid)
        }
        setupOneSingal(launchOptions)
        
        setupKeyBoard()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate{
    //键盘设置
    private func setupKeyBoard(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    /// 注册mixpanel
    private func setupMixpanel(userId: String) {
        MPEvent.shared.config(token: mixpanelToken)
        MPEvent.shared.loggingEnabled = true
        Mixpanel.mainInstance().registerSuperProperties(["$RCAnonymousID": userId])
        MPEvent.shared.supperProperties.setOnce(["first_seen": Date()])
        MPEvent.shared.supperProperties.set([
            "last_seen": Date(),
            "subscriber_status": IAPManager.shared.isActive,
        ])
    }
    
    private func setupOneSingal(_ launchOptions:[UIApplication.LaunchOptionsKey: Any]?){
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(oneSignalAppId)
        
        //往服务器上推动userid 和 fcmtoken
        //NetWorkManager.shared.postPlayerId()
    }
    
    func setupIAPManager(_ callback:(String)->Void){
        IAPManager.shared.config { accessConfigDict in
            accessConfigDict[IAPManager.AccessKeys.revenueCatPublicKey] = revenueCatAIPKey
            accessConfigDict[IAPManager.AccessKeys.revenueCatIdentify] = revenueCatIdentify
        }
        let userId = Purchases.shared.appUserID
        //UserDefault保存userid
        //Defaults[\.uid] = userId
        print("******RC \(Purchases.shared.appUserID)")
        callback(userId)
    }
    
}
