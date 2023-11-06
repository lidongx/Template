//
//  ConfigationCheck.swift
//  Template
//
//  Created by lidong on 2023/9/27.
//

import Foundation

class Template{
    ///当更改成功了将false设置为true
    static func check(){
        let items:[ConfigationCheck] = [
            RevenueCatAIPKeyConfigation(isChecked: false),
            RevenueCatIdentifyConfigation(isChecked: false),
            MixpanelTokenConfigation(),
            OneSignalAppIdConfigation(),
            GoogleInfoPlistConfigation(isChecked: false),
            InfoPlistGADApplicationIdentifierConfigation(isChecked: false),
            InfoPlistURLSchemeConfigation(isChecked: false),
            AppConfigPlistConfigation(isChecked: false),
            OneSignalNotificationServiceExtensionConfigation(isChecked: false),
            AssociatedDomainsConfigation(isChecked: false)
        ]
        for item in items{
            item.valid()
        }
    }
}

protocol ConfigationCheck{
    var isChecked:Bool { get set }
    func valid()
}


///设置mixpanelToken
struct MixpanelTokenConfigation :ConfigationCheck {
    var isChecked: Bool = !mixpanelToken.isEmpty
    func valid() {
        if !isChecked{
            debugLog("⚠️QACheck中mixpanelToken没有被设置")
        }
    }
}

///设置oneSignalAppId
struct OneSignalAppIdConfigation : ConfigationCheck{
    var isChecked: Bool = !oneSignalAppId.isEmpty
    func valid() {
        if !isChecked{
            debugLog("⚠️QACheck中oneSignalAppId没有被设置")
        }
    }
}

///替换GoogleService-Info.plist文件
struct GoogleInfoPlistConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        let path = Bundle.main.path(forResource: "GoogleService-Info.plist", ofType: nil)
        if let path = path ,FileManager.default.fileExists(atPath: path){
        }else{
            debugLog("⚠️GoogleService-Info.plist 项目中不存在")
            return
        }
        
        if !isChecked{
            debugLog("⚠️GoogleService-Info.plist 需要替换 以及文件下面的正式的测试的文件，如果已经更改将isChecked设置为true")
        }
    }
}

///Info.plist需要修改GADApplicationIdentifier
struct InfoPlistGADApplicationIdentifierConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        if !isChecked{
            debugLog("⚠️Info.plist中GADApplicationIdentifier需要更改")
        }
    }
}

//URL Scheme 需要设置
struct InfoPlistURLSchemeConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        if !isChecked{
            debugLog("⚠️Info.plist中URLScheme需要增加新的")
        }
    }
}

///AppConfig.Plist需要修改所有的id和ProjectCode
struct AppConfigPlistConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        let path = Bundle.main.path(forResource: "AppConfig.plist", ofType: nil)
        if let path = path ,FileManager.default.fileExists(atPath: path){
        }else{
            debugLog("⚠️AppConfig.plist 项目中不存在")
            return
        }
        if !isChecked{
            debugLog("⚠️AppConfig.Plist中广告id和ProjectCode需要更改")
        }
    }
}

struct OneSignalNotificationServiceExtensionConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        if !isChecked{
            debugLog("⚠️OneSignalNotificationServiceExtension.entitlements中App Groups的id需要被替换")
        }
    }
}


//RevenueCat API Key
struct RevenueCatAIPKeyConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        if !isChecked{
            debugLog("⚠️QACheck中需要设置revenueCatAIPKey")
        }
    }
}

//RevenueCat API Key
struct RevenueCatIdentifyConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        if !isChecked{
            debugLog("⚠️QACheck中需要设置revenueCatIdentify")
        }
    }
}

//AssociatedDomains 需要设置
struct AssociatedDomainsConfigation : ConfigationCheck{
    var isChecked: Bool
    func valid() {
        if !isChecked{
            debugLog("⚠️AssociatedDomains deeplink 需要更新")
        }
    }
}

