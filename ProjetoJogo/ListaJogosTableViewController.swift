//
//  ListaJogosTableViewController.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 13/10/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

//var arrayDeJogos = [Jogo]()

class ListaJogosTableViewController: UITableViewController {
    
    var arrayJogos: [NSManagedObject] = []

    override func viewDidLoad() {
       
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

    }
    
    //Metodo que será chamado toda vez que a view aparecer na tela.
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
         self.recuperarJogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(animated)
       
   
    }
    
    func recuperarJogo () {
        
        CoreDataService.shered.recuperar(with: .jogos, predicate: nil) { (error, array) in
            if error == nil && array != nil{
                self.arrayJogos = array!
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayJogos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellJogo", for: indexPath)
        let jogo = arrayJogos[indexPath.row]
        cell.textLabel?.text = jogo.value(forKey: "nome") as? String
        
        if let disponivel = jogo.value(forKey: "disponivel") as? Bool{
            
            if disponivel {
                cell.backgroundColor = UIColor.blue.withAlphaComponent(0.04)
                
            }else {
                cell.backgroundColor = UIColor.red.withAlphaComponent(0.04)
            }
            
        }
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let jogo = arrayJogos[indexPath.row]
        //chamar segue
        self.performSegue(withIdentifier: "segueDetalhes", sender: jogo)
   
    }
    
    //Preparando segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "segueDetalhes" {
            if let viewC = segue.destination as? DetalhesDoJogoViewController {
                viewC.jogo = sender as? NSManagedObject
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
