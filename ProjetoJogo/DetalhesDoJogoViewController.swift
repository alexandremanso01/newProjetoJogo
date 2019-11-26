//
//  DetalhesDoJogoViewController.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 27/10/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class DetalhesDoJogoViewController: UIViewController {
    
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldGenero: UITextField!
    @IBOutlet weak var textFieldDataDeLancamento: UITextField!
    @IBOutlet weak var textFieldPlataforma: UITextField!
    
    
    var jogo: NSManagedObject?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setarValorJogo()
      
    }
    
    func setarValorJogo() {
        
        if jogo != nil {
            
            self.textFieldNome.text = jogo!.value(forKey: "nome") as? String
            self.textFieldGenero.text = jogo!.value(forKey: "genero") as? String
            self.textFieldDataDeLancamento.text = jogo!.value(forKey: "data") as? String
            
         let resultPlataformaXbox = jogo!.value(forKey: "xbox") as! Bool
         let resultPlataformaPlay = jogo!.value(forKey: "play") as! Bool
    
            if resultPlataformaPlay && resultPlataformaXbox {
              
                self.textFieldPlataforma.text = "PlayStation, Xbox"
            
            }else if resultPlataformaXbox {
               
                self.textFieldPlataforma.text = "Xbox"
            
            }else {
            
                self.textFieldPlataforma.text = "PlayStation"
            
            }
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
