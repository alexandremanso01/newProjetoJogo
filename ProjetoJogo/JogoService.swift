//
//  JogoService.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 06/02/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import Foundation

protocol jogoServiceDelegate{
    func didGetJogos(jogos:[Jogo])
}

class JogoService{
    
    private init(){}
    static let shared = JogoService()
    var delegate: jogoServiceDelegate?
    
    func post(jogo: Jogo){
        FIRDataBeseService.shared.post(parameters: jogo.parameters(), to: .jogos)
    }
    
    func getJogos(){
        FIRDataBeseService.shared.get(.jogos) { (snapShot) in
            guard let jogosSnapShot = JogoSnapShot(snapShot: snapShot) else {return}
            self.delegate?.didGetJogos(jogos: jogosSnapShot.jogos)
        }
    }
}
