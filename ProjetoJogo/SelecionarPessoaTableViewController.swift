//
//  SelecionarPessoaTableViewController.swift
//  ProjetoJogo
//
//  Created by Alexandre Manso on 27/01/2018.
//  Copyright © 2018 Mctech Aluno. All rights reserved.
//

import UIKit
import CoreData

protocol SelecionarPessoaTableViewControllerDelegate {
    func clicouPessoa(pessoa: NSManagedObject)
}

class SelecionarPessoaTableViewController: UITableViewController {
    
    var arrayPessoa: [NSManagedObject] = []
    var delegate: SelecionarPessoaTableViewControllerDelegate?
    let celId = "cellPessoaLoc"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "PessoaTableViewCell", bundle: nil), forCellReuseIdentifier: celId)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.recuperarPessoa()
    }
    
    func recuperarPessoa(){
    
        CoreDataService.shered.recuperar(with: .pessoas, predicate: nil) { (error, array) in
            if error == nil && array != nil{
                self.arrayPessoa = array!
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
        return arrayPessoa.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: celId, for: indexPath) as! PessoaTableViewCell
        let jogo = self.arrayPessoa[indexPath.row]
        cell.labelNomePessoa.text = jogo.value(forKey: "nome") as? String
// cell.backgroundColor = UIColor.blue
        let foto = UIImage(data: jogo.value(forKey: "foto") as! Data)!
        cell.imageViewPessoa.image = foto
        cell.viewFundo.backgroundColor = UIColor.green
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.clicouPessoa(pessoa: self.arrayPessoa[indexPath.row])
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89.0
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
