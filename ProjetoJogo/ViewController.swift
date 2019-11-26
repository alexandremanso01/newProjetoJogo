//
//  ViewController.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 13/10/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
//
import MBProgressHUD
import CoreData

//comentario 1
class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var testeString = ""
    let arrayTitle = ["Lista de Pessoas", "Lista de Jogos", "Locar Jogos", "Devolver Jogo", "Devolver Jogo Por Pessoa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(testeString)
        self.tableview.tableFooterView = UIView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recuperarJogos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func recuperarJogos(){
        if !jogosJaSalvos(){
            
            mostrarLoadding()
            JogoService.shared.delegate = self
            JogoService.shared.getJogos()
            
        }
        
    }
    
    private func jogosJaSalvos() -> Bool{
        
        var conten = false
        
        CoreDataService.shered.recuperar(with: .jogos, predicate: nil) { (error, array) in
            if error == nil && array != nil && array!.count > 0{
                conten = true
            }
        }
        
        return conten
    }
    func mostrarLoadding(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

}

extension ViewController: jogoServiceDelegate{
    func didGetJogos(jogos: [Jogo]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let gerente = appDelegate.persistentContainer.viewContext
        
        for jogo in jogos {
            let jogoObj = NSEntityDescription.insertNewObject(forEntityName: "Jogos", into: gerente)
            jogoObj.setValue(jogo.nome!, forKey: "nome")
            jogoObj.setValue(jogo.genero!, forKey: "genero")
            ////jogoObj.setValue(jogo.data!, forKey: "data")
            jogoObj.setValue(jogo.playStation!, forKey: "play")
            jogoObj.setValue(jogo.xBox!, forKey: "xbox")
            jogoObj.setValue(jogo.disponivel!, forKey: "disponivel")
        }
        do{
          try gerente.save()
        }catch let erro as NSError{
            print("Erro ao salvar erro:\(erro.description)")
        }
        
        MBProgressHUD.hide(for: self.view, animated: true)
        

    }
    
   
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTitle.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = self.arrayTitle[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "segueParaPessoas", sender: nil)
        } else if indexPath.row == 1 {
            self.performSegue(withIdentifier: "segueParaJogos", sender: nil)
        }else if indexPath.row == 2 {
            self.performSegue(withIdentifier: "segueLocou", sender: nil)
        }else if indexPath.row == 3 {
            self.performSegue(withIdentifier: "segueDevolucao", sender: nil)
        }
        else  {
           self.performSegue(withIdentifier: "segueDevolucaoPessoa", sender: nil)
    //  FIRDataBeseService.shared.post(parameters: ["nome": "Alexandre", "idade": 29], to: .pessoas)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}

