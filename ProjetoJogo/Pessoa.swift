//
//  Pessoa.swift
//  ProjetoJogo
//
//  Created by Home on 15/12/2017.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit

class Pessoa: NSObject {
    
    var foto: UIImage?
    var nome: String?
    var genero: String?
    var idade: Int?
    var telefone: String?
    var endereco: String?
    
    
    init(nomeDaPessoa:String, generoDaPessoa:String, idadeDaPessoa:Int, telefoneDaPessoa:String, enderecoDaPessoa:String, fotoDaPessoa:UIImage) {
        self.nome = nomeDaPessoa
        self.genero = generoDaPessoa
        self.idade = idadeDaPessoa
        self.telefone = telefoneDaPessoa
        self.endereco = enderecoDaPessoa
        self.foto = fotoDaPessoa
        
    }
    

}
