//
//  DetalesDaPessoaViewController.swift
//  ProjetoJogo
//
//  Created by Home on 15/12/2017.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class DetalesDaPessoaViewController: UIViewController {

    var pessoa: NSManagedObject?
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var idadeLabel: UILabel!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var enderecoTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageViewPessoa: UIImageView!
    @IBOutlet weak var addFoto: UIButton!
    @IBOutlet weak var botaoSalvar: UIButton!
    @IBOutlet weak var sliderIdade: UISlider!
    
    
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
    
    @IBAction func editar(_ sender: UIBarButtonItem) {
        
        self.nomeTextField.isEnabled = true
        self.generoTextField.isEnabled = true
        self.enderecoTextField.isEnabled = true
        self.telefoneTextField.isEnabled = true
        self.addFoto.isHidden = false
        self.botaoSalvar.isHidden = false
        self.sliderIdade.isHidden = false
        self.sliderIdade.setValue(Float(self.idadePessoa), animated: true)
        
    }
    
    @IBAction func actionIdade (_ sender: UISlider){
        let idade = Int(sender.value)
        var str = "Anos"
        if idade <= 1 {
            str = "Ano"
        }
        self.idadeLabel.text = "Idade: \(idade) \(str)"
        self.idadePessoa = idade
    }
    
    @IBAction func actionSalvar(_ sender: UIButton) {
        self.pessoa?.setValue(self.nomeTextField.text, forKey: "nome")
         self.pessoa?.setValue(self.generoTextField.text, forKey: "genero")
         self.pessoa?.setValue(self.idadePessoa, forKey: "idade")
         self.pessoa?.setValue(self.telefoneTextField.text, forKey: "telefone")
         self.pessoa?.setValue(self.enderecoTextField.text, forKey: "endereco")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let gerenciadorDeObjetos = appDelegate.persistentContainer.viewContext
        
        do {
            try gerenciadorDeObjetos.save()
        }catch{
            print("Erro ao editar!!!")
        }
        
        self.navigationController?.popViewController(animated: true)
        
        
        
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
