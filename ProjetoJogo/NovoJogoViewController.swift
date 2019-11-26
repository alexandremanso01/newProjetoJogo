//
//  NovoJogoViewController.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 13/10/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

class NovoJogoViewController: UIViewController {
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var playSwitch: UISwitch!
    @IBOutlet weak var xBoxSwitch: UISwitch!
    
    var dataPicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configDatePicker()
        self.configToobar()
        // Do any additional setup after loading the view.
    }
    
    
    func configDatePicker(){
        self.dataTextField.inputView = self.dataPicker
        self.dataPicker.datePickerMode = .date
        self.dataPicker.addTarget(self, action: #selector(valorDatePiclerAlterado), for: .valueChanged)
        
    }
    
    func valorDatePiclerAlterado(){
        let formaDaData = DateFormatter()
        formaDaData.dateFormat = "dd/MM/yyyy"
        
        self.dataTextField.text = formaDaData.string(from: self.dataPicker.date)
    }
    
    func configToobar(){
        let toobar = UIToolbar()
        toobar.sizeToFit()
        
        let okbotao = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(selecionarData))
        let cancelarbotao = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(cancelarData))
        let spaceBotao = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toobar.setItems([cancelarbotao, spaceBotao, okbotao], animated: false)
        
        self.dataTextField.inputAccessoryView = toobar
        
    }
    
    func selecionarData(){
        
        let formaDaData = DateFormatter()
        formaDaData.dateFormat = "dd/MM/yyyy"
        
        self.dataTextField.text = formaDaData.string(from: self.dataPicker.date)
        self.dataTextField.resignFirstResponder()
    }
    
    func cancelarData(){
        self.dataTextField.text = ""
        self.dataTextField.resignFirstResponder()
    }
    
    @IBAction func salvar(_ sender: Any) {
        
        if self.validarCampos() != nil {
            let mensagem = self.validarCampos()
            //Criando alerta
            let alert = UIAlertController(title: "Error", message: mensagem, preferredStyle: .alert)
            //Criando botao de ok
            let okbotao = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //Adicionando botao de ok no alerta
            alert.addAction(okbotao)
            //Mostando o alerta na tela
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        /*let nome = self.nomeTextField.text!
        let genero = self.generoTextField.text!
        let data = self.dataTextField.text!
        let play = self.playSwitch.isOn
        let xBox = self.xBoxSwitch.isOn
        
        let novoJogo = Jogo(nomeDoJogo: nome, genDoJogo: genero, dataDoJogo: data, play: play, xbox: xBox)
        
        arrayDeJogos.append(novoJogo)*/
        self.salvarJogoNoCoreData()
        //Metodo para voltar uma tela
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func validarCampos() -> String? {
        var mensagem: String?
        if self.nomeTextField.text == ""{
            mensagem = "Insira um nome"
        } else if self.generoTextField.text == ""{
            mensagem = "Insira o genêro"

        } else if self.dataTextField.text == "" {
            mensagem = "Insira a data de lançamento"
        } else if !self.playSwitch.isOn == true && !self.xBoxSwitch.isOn == true {
            mensagem = "Escolha um console"
        }
        
        return mensagem
    }
    
    func salvarJogoNoCoreData () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let gerente = appDelegate.persistentContainer.viewContext
        
        let jogo = NSEntityDescription.insertNewObject(forEntityName: "Jogos", into: gerente)
        
        jogo.setValue(self.nomeTextField.text, forKey: "nome")
        jogo.setValue(self.generoTextField.text, forKey: "genero")
        jogo.setValue(self.dataTextField.text, forKey: "data")
        jogo.setValue(self.xBoxSwitch.isOn, forKey: "xbox")
        jogo.setValue(self.playSwitch.isOn, forKey: "play")
        jogo.setValue(true, forKey: "disponivel")
        do{
            try gerente.save()
            JogoService.shared.post(jogo: Jogo(with: jogo))
        }catch{
            print("Erro ao Salvar Jogo!!!")
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
