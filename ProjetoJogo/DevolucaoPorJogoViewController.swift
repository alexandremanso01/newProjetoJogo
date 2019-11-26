//
//  DevolucaoPorJogoViewController.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 02/02/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class DevolucaoPorJogoViewController: UIViewController {


    var pessoa: NSManagedObject?
    var jogo: NSManagedObject?
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var idadeLabel: UILabel!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var enderecoTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageViewPessoa: UIImageView!
    
    
    var idadePessoa: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setarValor()
        // Do any additional setup after loading the view.
    }
    
    func setarValor() {
        
        self.imageViewPessoa.layer.cornerRadius = self.imageViewPessoa.frame.width / 2
        self.imageViewPessoa.layer.masksToBounds = true
        
        if self.pessoa != nil {
            
            self.nomeTextField.text = pessoa!.value(forKey:"nome") as? String
            self.nomeTextField.isEnabled = false
            self.generoTextField.text = pessoa!.value(forKey: "genero") as? String
            self.generoTextField.isEnabled = false
            self.idadePessoa = pessoa!.value(forKey: "idade") as! Int
            self.idadeLabel.text = "\(self.idadePessoa) anos"
            self.idadeLabel.isEnabled = false
            self.enderecoTextField.text = pessoa!.value(forKey: "endereco") as? String
            self.enderecoTextField.isEnabled = false
            //Convertendo de Data para UIImage
            let imagem = UIImage(data: pessoa?.value(forKey: "foto") as! Data)
            self.imageViewPessoa.image = imagem
            self.telefoneTextField.text = pessoa!.value(forKey: "telefone") as? String
            self.telefoneTextField.isEnabled = false
            
        }
        
    }
   
    
   
    
    @IBAction func actionDevolver(_ sender: UIButton) {
        
        self.jogo?.setValue(true, forKey: "disponivel")
        self.jogo?.setValue(nil, forKey: "pessoa")
        self.pessoa?.setValue(false, forKey: "locou")
        self.pessoa?.setValue(nil, forKey: "jogo")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let gerente = appDelegate?.persistentContainer.viewContext
        
        do {
          try gerente?.save()
             self.navigationController?.popViewController(animated: true)
        }catch{
           alerta(mensagem: "Erro ao Salvar dados")
        }
        
      
    }
    
    func alerta(mensagem: String) {
        let alert = UIAlertController(title: "", message: mensagem, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
}
