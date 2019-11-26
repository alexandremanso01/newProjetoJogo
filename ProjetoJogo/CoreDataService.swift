//
//  CoreDataService.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 06/02/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum CoreDataReference: String{
    case jogos = "Jogos"
    case pessoas = "Pessoas"
    
}

class CoreDataService{
    
    private init(){}
    static let shered = CoreDataService()
    
    var gerenciadorDeObjetos: NSManagedObjectContext{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let gerente = appDelegate.persistentContainer.viewContext
        return gerente
        
    }
    
    func recuperar(with coreDataReference: CoreDataReference, predicate: NSPredicate?, handle: @escaping(NSError?, [NSManagedObject]?)  -> Void ){
        
        let requisicao = NSFetchRequest<NSFetchRequestResult> (entityName: coreDataReference.rawValue)
        if predicate != nil {
            requisicao.predicate = predicate
        }
        
        do{
            let anotacoesRecuperadas = try gerenciadorDeObjetos.fetch(requisicao)
            print("Sucesso ao salvar \(coreDataReference.rawValue)")
            handle(nil, anotacoesRecuperadas as? [NSManagedObject])
            
        }catch let error as NSError{
            print("Erro ao salvar \(coreDataReference.rawValue)")
            handle(error, nil)
        }
        
    }
}
