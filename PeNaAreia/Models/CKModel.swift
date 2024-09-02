//
//  CKModel.swift
//  PeNaAreia
//
//  Created by Miriam Mendes on 02/09/24.
//

import Foundation
import CloudKit
//Aggregate model

class CKModel: ObservableObject{
    
    private var database = CKContainer.default().publicCloudDatabase
    @Published private var tentsDictionary: [CKRecord.ID: Tents] = [:]
    @Published private var productsDictionary: [CKRecord.ID: Products] = [:]
    
    
    
}
