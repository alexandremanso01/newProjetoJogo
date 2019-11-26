//
//  DevolucaoPorPessoaViewController.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 04/02/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class DevolucaoPorPessoaViewController: UIViewController {

    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldGenero: UITextField!
    @IBOutlet weak var textFieldDataDeLancamento: UITextField!
    @IBOutlet weak var textFieldPlataforma: UITextField!
    
    
    var jogo: NSManagedObject?
    var pessoa: NSManagedObject?
    
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
    
    
    @IBAction func devolverJogo(_ sender: Any) {
        
        self.jogo?.setValue(true, forKey: "disponivel")
        self.jogo?.setValue(nil, forKey: "pessoa")
        self.pessoa?.setValue(false, forKey: "locou")
        self.pessoa?.setValue(nil, forKey: "jogo")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let gerente = appDelegate?.persistentContainer.viewContext
        
        do{
           try gerente?.save()
            self.navigationController?.popViewController(animated: true)
        }catch{
            alerta(mensage: "Erro ao Salvar Devolução de jogo")
        }
    }
    
        func alerta(mensage: String){
            let alert = UIAlertController(title: "", message: mensage, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
