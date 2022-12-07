//
//  Order.swift
//  GetYourCupCake
//
//  Created by berat can beduk on 7.12.2022.
//

import Foundation

class Order: ObservableObject , Codable {
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published  var myObject : myOrder = myOrder()
    
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    init() { }

    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        myObject.type = try container.decode(Int.self, forKey: .type)
        myObject.quantity = try container.decode(Int.self, forKey: .quantity)

        myObject.extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        myObject.addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        myObject.name = try container.decode(String.self, forKey: .name)
        myObject.streetAddress = try container.decode(String.self, forKey: .streetAddress)
        myObject.city = try container.decode(String.self, forKey: .city)
        myObject.zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(myObject.type, forKey: .type)
        try container.encode(myObject.quantity, forKey: .quantity)

        try container.encode(myObject.extraFrosting, forKey: .extraFrosting)
        try container.encode(myObject.addSprinkles, forKey: .addSprinkles)

        try container.encode(myObject.name, forKey: .name)
        try container.encode(myObject.streetAddress, forKey: .streetAddress)
        try container.encode(myObject.city, forKey: .city)
        try container.encode(myObject.zip, forKey: .zip)
    }
}



struct myOrder : Identifiable {
    
    var id = UUID()
     var type = 0
     var quantity = 3

     var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
     var extraFrosting = false
     var addSprinkles = false
     var name = ""
     var streetAddress = ""
     var city = ""
     var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
