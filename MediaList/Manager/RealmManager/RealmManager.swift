//
//  RealmManager.swift
//  MediaList
//
//  Created by KaiD on 06/02/2023.
//

import Foundation
import RealmSwift

class RealmManager {
    /*
     * Singleton instance variable
     */
    public static let shared = RealmManager()
    private let realm = try! Realm()
    
    private init() {
        
    }
    
    func addObject<T:Object>(object: T) -> Error? {
        do {
            try realm.write {
                realm.add(object)
            }
            return nil
        } catch {
            return error
        }
    }
    
    func deleteObject<T:Object>(object: T) -> Error? {
        do {
            try realm.write {
                realm.delete(object)
            }
            return nil
        } catch {
            return error
        }
    }
    
    func getObjects<T:Object>() -> [T] {
        let realmResults = realm.objects(T.self)
        return Array(realmResults)
    }
    
    func getObjects<T:Object>(id: Int) -> [T] {
        let realmResults = realm.objects(T.self).filter("id == \(id)")
        return Array(realmResults)
    }
}
