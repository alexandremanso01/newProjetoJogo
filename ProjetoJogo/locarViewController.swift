//
//  locarViewController.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 26/01/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class locarViewController: UIViewController {

    @IBOutlet weak var fotoView: UIImageView!
    @IBOutlet weak var textFieldJogo: UITextField!
    @IBOutlet weak var textFieldPessoa: UITextField!
    var pessoa: NSManagedObject?
    var jogo: NSManagedObject?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.fotoView.layer.cornerRadius = fotoView.frame.size.width / 2
            self.fotoView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func locar(_ sender: Any) {
      
        if foiSelecionado(object: jogo){
            self.mostrarAlerta(alert: "Selecione um jogo")
            return
        }else if foiSelecionado(object: pessoa){
            self.mostrarAlerta(alert: "Selecione uma Pessoa")
            return
        }
        
        locarJogo()
        
    }
    
    func locarJogo(){
        self.pessoa?.setValue(true, forKey: "locou")
        self.pessoa?.setValue(self.jogo, forKey: "jogo")
        self.jogo?.setValue(false, forKey: "disponivel")
        self.jogo?.setValue(self.pessoa, forKey: "pessoa")
        
        
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let gerente = appDelegate.persistentContainer.viewContext
        
        do{
           try gerente.save()
            self.navigationController?.popViewController(animated: true)
        }catch{
          mostrarAlerta(alert: "Não Foi Possivel locar o Jogo")
        }
        
    }
    
    func foiSelecionado(object: NSManagedObject?) -> Bool {
        
        return object == nil
        
    }
    
    func mostrarAlerta(alert: String){
        
        let alert = UIAlertController(title: "", message: alert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "segueJogo"{
          
            if let vc = segue.destination as? LocarJogoTableViewController {
          
                vc.delegate = self
   
            }
        }else{
         
            if segue.identifier == "seguePessoa"{
        
                if let bb = segue.destination as? SelecionarPessoaTableViewController{
             
                    bb.delegate = self
    
                }
            }
        }
    }
 
   
}

extension locarViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textFieldJogo{
            performSegue(withIdentifier: "segueJogo", sender: nil)
        }else{
            performSegue(withIdentifier: "seguePessoa", sender: nil)
        }
        return false
    }
}

extension locarViewController : LocarJogoTableViewControllerDelegate{
    
    func clicou(jogo: NSManagedObject) {
        
        self.jogo = jogo
        self.textFieldJogo.text = jogo.value(forKey: "nome") as? String

    }
}

extension locarViewController: SelecionarPessoaTableViewControllerDelegate {
    
    func clicouPessoa(pessoa: NSManagedObject){
        self.pessoa = pessoa
        self.textFieldPessoa.text = pessoa.value(forKey: "nome") as? String
        let foto = UIImage(data: pessoa.value(forKey: "foto") as! Data)!
        self.fotoView.image = foto
    }
}



