//
//  Constant.swift
//  Notm104
//
//  Created by 王理朝 on 2023/5/5.
//

import Foundation
import UIKit

public let revenueCatAIPKey = "appl_TcdGkDCfuHTMAqxgyEpuvaKqstD"
public let revenueCatIdentify = "plus"

let baseUrl: String = {
    #if AppStoreEnv
    ""//"http://3.141.137.13"
    #else
    
    #if DEBUG
    ""
    #else
    ""
    #endif
    
    #endif
}()

let mixpanelToken: String = {
    #if AppStoreEnv
    ""
    #else
        #if DEBUG
            ""
        #else
            ""
        #endif
    #endif
}()

let oneSignalAppId: String = {
    #if AppStoreEnv
        ""
    #else
        #if DEBUG
            ""
        #else
            ""
        #endif
    #endif
}()

func debugLog(_ items: Any...) {
    let targetName = Bundle.main.infoDictionary?["TargetName"] ?? "Template"
    #if DEBUG
    print("\(targetName): ", items)
    #endif
}


