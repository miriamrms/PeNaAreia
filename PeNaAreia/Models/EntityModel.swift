//
//  EntityModel.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 02/09/24.
//
import Foundation
import CloudKit


//TENTSMODEL

struct Tents{
    
    var id: CKRecord.ID?
    
    let name: String
    let image: String
    let linkMap: String
    let coordinates: CLLocation
    var seaBath: Bool
    var shower: Bool
    var toilet: Bool
    var averagePrice: String
    var capacity: String
}

enum TentsRecordKeys: String{
    case type = "Tents"
    case name
    case image
    case linkMap
    case coordnates
    case seaBath
    case shower
    case toilet
    case averagePrice
    case capacity
}

extension Tents{
    init?(record: CKRecord){
        guard let name = record[TentsRecordKeys.name.rawValue] as? String,
              let image = record[TentsRecordKeys.image.rawValue] as? String,
              let linkMap = record[TentsRecordKeys.linkMap.rawValue] as? String,
              let coordinates = record[TentsRecordKeys.coordnates.rawValue] as? CLLocation,
              let seaBath = record[TentsRecordKeys.seaBath.rawValue] as? Bool,
              let shower = record[TentsRecordKeys.shower.rawValue] as? Bool,
              let toilet = record[TentsRecordKeys.toilet.rawValue] as? Bool,
              let averagePrice = record[TentsRecordKeys.averagePrice.rawValue] as? String,
              let capacity = record[TentsRecordKeys.capacity.rawValue] as? String
        else{
            return nil
        }
        //initializer
        self.init(id: record.recordID ,name: name, image: image, linkMap: linkMap, coordinates: coordinates, seaBath: seaBath, shower: shower, toilet: toilet, averagePrice: averagePrice, capacity: capacity)
    }
}

extension Tents{
    var record: CKRecord{
        let record = CKRecord(recordType: TentsRecordKeys.type.rawValue)
        record[TentsRecordKeys.name.rawValue] = name
        record[TentsRecordKeys.image.rawValue] = image
        record[TentsRecordKeys.linkMap.rawValue] = linkMap
        record[TentsRecordKeys.coordnates.rawValue] = coordinates
        record[TentsRecordKeys.seaBath.rawValue] = seaBath
        record[TentsRecordKeys.shower.rawValue] = shower
        record[TentsRecordKeys.toilet.rawValue] = toilet
        record[TentsRecordKeys.averagePrice.rawValue] = averagePrice
        record[TentsRecordKeys.capacity.rawValue] = capacity
        return record
    }
}


//PRODUCTSMODEL

struct Products{
    
    var id: CKRecord.ID?
    
    let name: String
    var description: String
    let price: Double
    let category: String
    let categoryImage: String
    var serving: String
    var tentReference: CKRecord.Reference?
}

enum ProductsRecordKeys: String{
    case type = "Products"
    case name
    case description
    case price
    case category
    case categoryImage
    case serving
    case tentReference
}

extension Products{
    init?(record: CKRecord){
        guard let name = record[ProductsRecordKeys.name.rawValue] as? String,
              let description = record[ProductsRecordKeys.description.rawValue] as? String,
              let price = record[ProductsRecordKeys.price.rawValue] as? Double,
              let category = record[ProductsRecordKeys.category.rawValue] as? String,
              let categoryImage = record[ProductsRecordKeys.categoryImage.rawValue] as? String,
              let serving = record[ProductsRecordKeys.serving.rawValue] as? String,
              let tentReference = record[ProductsRecordKeys.tentReference.rawValue] as? CKRecord.Reference
        else{
            return nil
        }
        //initializer
        self.init(id: record.recordID, name: name, description: description, price: price, category: category, categoryImage: categoryImage, serving: serving, tentReference: tentReference)
    }
}

extension Products{
    var record: CKRecord{
        let record = CKRecord(recordType: ProductsRecordKeys.type.rawValue)
        record[ProductsRecordKeys.name.rawValue] = name
        record[ProductsRecordKeys.description.rawValue] = description
        record[ProductsRecordKeys.price.rawValue] = price
        record[ProductsRecordKeys.category.rawValue] = category
        record[ProductsRecordKeys.categoryImage.rawValue] = categoryImage
        record[ProductsRecordKeys.serving.rawValue] = serving
        if let tentReference = tentReference {
            record[ProductsRecordKeys.tentReference.rawValue] = tentReference
        }
        return record
    }
}
