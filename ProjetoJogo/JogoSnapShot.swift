//
//  JogoSnapShot.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 06/02/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import Foundation
import Firebase
class JogoSnapShot{
    
    let jogos:[Jogo]
    
    init?(snapShot:DataSnapshot){
        
        guard let snapdict = snapShot.value as? [String: [String: Any]] else{return nil}
        var arrayJogos = [Jogo]()
        for snap in snapdict{
            
          let jogo = Jogo(valueDict: snap.value)
            arrayJogos.append(jogo)
        }
        
        self.jogos = arrayJogos
        
    }
    
}
