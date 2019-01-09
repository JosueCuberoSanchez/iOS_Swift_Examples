//
//  JSONDecodable.swift
//  StarWarsApp
//
//  Created by Josue on 1/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.compactMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

func decode<T:JSONDecodable>(data: NSData) -> [T]? {
    guard let JSONObject = try? JSONSerialization.jsonObject(with: data as Data, options: []),
        let dictionaries = JSONObject as? NSData,
        let objects: [T] = decode(data: dictionaries) else {
            return nil
    }
    
    return objects
}
