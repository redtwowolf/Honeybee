//
//  HoneybeeCategory.swift
//  Honeybee
//
//  Created by Dongbing Hou on 06/03/2017.
//  Copyright © 2017 Dongbing Hou. All rights reserved.
//

import Foundation

/*
 {
 "category": "衣",
 "color": "FF7256",
 "editable": 0,
 "items": [
 {
 "name": "裙子",
 "icon": "qunzi"
 }
 ]
 },
 */

struct HoneybeeKind {
    var name: String
    var color: HoneyBeeColor
    var isEditable: Bool = true
    var items: [HoneybeeItem]?
    
    init(category: String, color: HoneyBeeColor, items: [HoneybeeItem]?) {
        self.name = category
        self.color = color
        self.items = items
    }
    init?(dict: [String: Any]) {
        guard let category = dict["category"] as? String,
            let color = dict["color"] as? [String: Any],
            let items = dict["items"] as? [[String: Any]]
            else { return nil }
        self.name = category
        self.color = HoneyBeeColor(dict: color)!
        var results = [HoneybeeItem]()
        for item in items {
            let model = HoneybeeItem(dict: item)
            results.append(model!)
        }
        self.items = results
    }
}

struct HoneybeeItem {
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    init?(dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let icon = dict["icon"] as? String
            else { return nil }
        self.name = name
        self.icon = icon
    }
}

struct HoneyBeeIcon {
    var name: String
    init(name: String) {
        self.name = name
    }
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
    }
}



//import ObjectMapper
//class HoneyBeeColor: RLMModel {
struct HoneyBeeColor {
    var name: String = ""
    var isUsed: Bool = false
    var link: String? = ""
    
    init?(dict: [String: Any]) {
        guard let name = dict["name"] as? String,
            let isUsed = dict["isUsed"] as? Bool
            else { return nil }
        self.name = name
        self.isUsed = isUsed
    }
    
//    dynamic var name: String = ""
//    dynamic var isUsed: Bool = false
//    dynamic var link: String? = ""
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        self.name <- map["name"]
//        self.isUsed <- map["isUsed"]
//    }
}

class HBKindManager: NSObject {
    static let manager = HBKindManager()
    private override init() {}
    func allKinds() -> [HoneybeeKind] {
        let path = Bundle.main.path(forResource: "category_color", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String: Any]]
        var result = [HoneybeeKind]()
        for item in json {
            let model = HoneybeeKind(dict: item)
            result.append(model!)
        }
        return result
    }
    
    func allIcons() -> [HoneyBeeIcon] {
        var result = [HoneyBeeIcon]()
        if let json = json(at: "icons") as? [[String: Any]] {
            for item in json {
                let model = HoneyBeeIcon(dict: item)
                result.append(model)
            }
        }
        return result
    }
    
    func json(at path: String) -> Any {
        let path = Bundle.main.path(forResource: path, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let json = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        return json
    }
    
    func allColors() -> [HoneyBeeColor] {
        var result = [HoneyBeeColor]()
        if let json = json(at: "colors") as? [[String: Any]] {
            for item in json {
//                let model = Mapper<HoneyBeeColor>().map(JSON: item)
                let model = HoneyBeeColor(dict: item)!
                result.append(model)
            }
        }
        return result
    }
}
