//
//  FIRDataBaseService.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 05/02/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import Foundation
import Firebase

enum FIRDataBaseREference: String{
    case jogos = "jogos"
    case pessoas = "pessoas"
}

class FIRDataBeseService {
    
    private init(){}
    static let shared = FIRDataBeseService()
    
    func post(parameters:[String: Any], to dataBaseReference: FIRDataBaseREference){
//        let reference = self.reference(.jogos)
        reference(dataBaseReference).childByAutoId().setValue(parameters)
    }
   /* private static var _instance:FIRDataBeseService?
    static var shared: FIRDataBeseService {
        
        if _instance == nil{
            _instance = FIRDataBeseService()
        }
        return _instance!
    }*/
    
    func reference(_ dataBaseReference: FIRDataBaseREference) -> DatabaseReference{
        return Database.database().reference().child(dataBaseReference.rawValue)
    }
    
    func get(_ dataBaseReference: FIRDataBaseREference, handle: @escaping(DataSnapshot) -> Void){
        reference(dataBaseReference).observeSingleEvent(of: .value) { (snapShot) in
            handle(snapShot)
        }
    }
}
