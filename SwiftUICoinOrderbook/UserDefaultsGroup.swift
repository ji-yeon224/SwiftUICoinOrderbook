//
//  UserDefaultsGroup.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/30/23.
//

import Foundation

extension UserDefaults {
    
    static var groupShared: UserDefaults {
        let appGroupID = "group.sesac.wallet"
        
        return UserDefaults(suiteName: appGroupID)!
    }
    
}
