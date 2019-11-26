//
//  Jogo.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 20/10/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class Jogo: NSObject {
    
    var nome: String?
    var genero: String?
    var data: String?
    var playStation: Bool?
    var xBox: Bool?
    var disponivel: Bool?
    
    init(nomeDoJogo: String, genDoJogo: String, dataDoJogo: String, play: Bool, xbox: Bool) {
        self.nome = nomeDoJogo
        self.genero = genDoJogo
        self.data = dataDoJogo
        self.playStation = play
        self.xBox = xbox
    }
    
    init(with jogo: NSManagedObject){
        
        self.nome = jogo.value(forKey: "nome") as? String
        self.genero = jogo.value(forKey: "genero") as? String
        self.data = jogo.value(forKey: "data") as? String
        self.playStation = jogo.value(forKey: "play") as? Bool
        self.xBox = jogo.value(forKey: "xbox") as? Bool
        self.disponivel = jogo.value(forKey: "disponivel") as? Bool
        
    }
    
    init(valueDict: [String: Any]) {
        self.nome = valueDict["nome"] as? String
        self.genero = valueDict["genero"] as? String
        self.data = valueDict["data"] as? String
        self.disponivel = valueDict["disponivel"] as? Bool
        self.playStation = valueDict["play"] as? Bool
        self.xBox = valueDict["xbox"] as? Bool
        
    }
    func parameters() -> [String: Any] {
        
        return["nome": self.nome!,
               "genero": self.genero!,
               "play": self.playStation!,
               "xbox": self.xBox!,
               "disponivel": self.disponivel!]
    }
    
}
