//
//  CKModel.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 03/09/24.
//

import Foundation
import CloudKit

class CKModel: ObservableObject{
    
    var database = CKContainer.default().publicCloudDatabase
    @Published var tentsDictionary: [CKRecord.ID: Tents] = [:]
    @Published var productsDictionary: [CKRecord.ID: Products] = [:]
    
    var tents: [Tents]{
        tentsDictionary.values.compactMap{$0}
    }
    var products: [Products]{
        productsDictionary.values.compactMap{$0}
    }
    
    func addTent(tent: Tents) async throws{
        _ = try await database.save(tent.record)
        
    }
    
    func populateTents() async throws{
        let query = CKQuery(recordType: TentsRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let result = try await database.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        records.forEach{ record in
            DispatchQueue.main.async { [self] in
                tentsDictionary[record.recordID] = Tents(record: record)
            }
        }
    }
    
    func addProduct(product: Products) async throws{
        _ = try await database.save(product.record)
        
    }
    
    func populateProducts() async throws{
        let query = CKQuery(recordType: ProductsRecordKeys.type.rawValue, predicate: NSPredicate(value: true))
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let result = try await database.records(matching: query)
        let records = result.matchResults.compactMap{ try? $0.1.get() }
        
        records.forEach{ record in
            productsDictionary[record.recordID] = Products(record: record)
        }
    }
    
    func populateTentProducts(forTent tent: Tents) async throws {
        guard let tentRecordID = tent.id else {
            throw NSError(domain: "CKModelError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Tent record ID not found."])
        }
        
        let reference = CKRecord.Reference(recordID: tentRecordID, action: .none)
        let predicate = NSPredicate(format: "tentReference == %@", reference)
        let query = CKQuery(recordType: ProductsRecordKeys.type.rawValue, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        let result = try await database.records(matching: query)
        let records = result.matchResults.compactMap { try? $0.1.get() }
        
        // Filtra apenas os registros não nulos
        let nonOptionalRecords = records.compactMap { record -> (CKRecord.ID, Products)? in
            guard let product = Products(record: record) else { return nil }
            return (record.recordID, product)
        }
        
        // Atualiza o dicionário
        DispatchQueue.main.async { [self] in
            productsDictionary = Dictionary(uniqueKeysWithValues: nonOptionalRecords)
        }
    }
    
    func fetchTent(forProduct product: Products) async throws -> Tents? {
            // Verifica se o produto contém uma referência à barraca
            guard let tentReference = product.record["tentReference"] as? CKRecord.Reference else {
                throw NSError(domain: "CKModelError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Product does not have a valid tent reference."])
            }
            
            // Cria uma consulta para buscar a barraca usando a referência
            let tentRecordID = tentReference.recordID
            let recordIDPredicate = NSPredicate(format: "recordID == %@", tentRecordID)
            let query = CKQuery(recordType: TentsRecordKeys.type.rawValue, predicate: recordIDPredicate)
            
            let result = try await database.records(matching: query)
            let records = result.matchResults.compactMap { try? $0.1.get() }
            
            // Assumindo que a barraca é encontrada, retorna o primeiro registro encontrado
            guard let tentRecord = records.first else {
                throw NSError(domain: "CKModelError", code: 2, userInfo: [NSLocalizedDescriptionKey: "No tent found for the given product reference."])
            }
            
            return Tents(record: tentRecord)
        }

    
}
