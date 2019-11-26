//
//  ListaDePessosTableViewController.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 10/11/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

//var listaDePesso = [Pessoa]()

class ListaDePessosTableViewController: UITableViewController {
    
    var arreyPessoas: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recuperarPessoas()

      //  self.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func recuperarPessoas () {
       
        CoreDataService.shered.recuperar(with: .pessoas, predicate: nil) { (erro, array) in
            if erro == nil && array != nil{
                self.arreyPessoas = array!
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
        return arreyPessoas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellPessoa", for: indexPath) as! PessoaTableViewCell
        let pessoa = arreyPessoas[indexPath.row]
        let foto: UIImage = UIImage(data: pessoa.value(forKey: "foto") as! Data)!
        cell.imageViewPessoa.image = foto
        cell.labelNomePessoa.text = pessoa.value(forKey: "nome") as? String
        

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pessoa = arreyPessoas[indexPath.row]
        self.performSegue(withIdentifier: "segueParaPessoas", sender: pessoa)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueParaPessoas" {
                if let viewController = segue.destination as? DetalesDaPessoaViewController {
                    viewController.pessoa = sender as? NSManagedObject
                    
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
