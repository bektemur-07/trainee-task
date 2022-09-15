//
//  main.swift
//  Trainee task
//
//  Created by Bektemur on 15/09/22.
//

import Foundation

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
    let imei: String
    let model: String
}

enum ErrorType: Error {
    case notUniqueValue
    case nonexistentValue
}

class MobileCollection: MobileStorage {
    var mobileSet: Set<Mobile> = []

    func getAll() -> Set<Mobile> {
        return mobileSet
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        for item in mobileSet {
            if item.imei == imei {
                return item
            }
        }

        return nil
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        let found = mobileSet.filter{ $0.imei == mobile.imei }.count > 0
        if found {
            throw ErrorType.notUniqueValue
        } else {
            mobileSet.insert(mobile)
            return mobile
        }
    }
    
    func delete(_ product: Mobile) throws {
        if !exists(product) {
            throw ErrorType.nonexistentValue
        } else {
            mobileSet.remove(product)
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        return mobileSet.contains(product)
    }
}



