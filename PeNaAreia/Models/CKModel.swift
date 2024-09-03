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
    @Published private var tentsDictionary: [CKRecord.ID: Tents] = [:]
    @Published private var productsDictionary: [CKRecord.ID: Products] = [:]
    
    var tents: [Tents]{
        tentsDictionary.values.compactMap{$0}
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
            tentsDictionary[record.recordID] = Tents(record: record)
        }
    }
    
}
