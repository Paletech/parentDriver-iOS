import KeychainSwift
import Repository
import Foundation
import ObjectMapper

enum KeychainError: Error {
    case objectNotFound
    case cantDeleteObject
    case cantSaveObject
}

enum KeychainKeys: String {
    case token
}

public protocol Store {

    func getData(_ key: String) -> Data?

    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool

    func get(_ key: String) -> String?

    @discardableResult
    func set(_ value: String, forKey key: String) -> Bool

    func get(_ key: String) -> Bool
    func getBool(_ key: String) -> Bool?

    @discardableResult
    func set(_ value: Bool, forKey key: String) -> Bool
    
    @discardableResult
    func delete(_ key: String) -> Bool
}

extension KeychainSwift: Store {
    
    public func getData(_ key: String) -> Data? {
        return self.getData(key, asReference: false)
    }
    
    @discardableResult
    public func set(_ value: String, forKey key: String) -> Bool {
        return self.set(value, forKey: key, withAccess: nil)
    }
    
    @discardableResult
    public func set(_ value: Data, forKey key: String) -> Bool {
        return self.set(value, forKey: key, withAccess: nil)
    }
    
    public func get(_ key: String) -> Bool {
        if let value = getBool(key) {
            return value
        }
        return false
    }
    
    @discardableResult
    public func set(_ value: Bool, forKey key: String) -> Bool {
        return set(value, forKey: key, withAccess: nil)
    }
}

class KeycheinStore<Item: BaseMappable> {
    
    public let store: Store
    
    public init(_ store: Store) {
        self.store = store
    }
    
    public func isExists(at URL: String) -> Bool {
        if store.get(URL) {
            return true
        } else {
            return false
        }
    }
    
    public func get(from URL: String) throws -> Item {
        let mapper = Mapper<Item>(context: nil, shouldIncludeNilValues: false)
        guard let object = store.get(URL),
            let parsedObject = mapper.map(JSONString: object) else {
                throw KeychainError.objectNotFound
        }
        return parsedObject
    }
    
    public func remove(from URL: String) throws {
        if store.delete(URL) == false {
            throw KeychainError.cantDeleteObject
        }
    }
    
    public func save(_ item: Item, at URL: String) throws {
        guard let JSONString = item.toJSONString(),
            store.set(JSONString, forKey: URL) else {
                throw KeychainError.cantSaveObject
        }
    }
}
