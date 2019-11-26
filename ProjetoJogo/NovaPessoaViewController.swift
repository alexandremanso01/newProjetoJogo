//
//  NovaPessoaViewController.swift
//  ProjetoJogo
//
//  Created by Mctech Aluno on 10/11/17.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit
import Photos
import CoreData

class NovaPessoaViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var generoTextField: UITextField!
    @IBOutlet weak var idadeLabel: UILabel!
    @IBOutlet weak var telefoneTextField: UITextField!
    @IBOutlet weak var enderecoTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imageViewPessoa: UIImageView!
    var pickerView = UIPickerView()
    
    let arrayGenero = ["Masculino", "Feminino", "Outro"]
    var idadePessoa: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Techado vai aparecer
        NotificationCenter.default.addObserver(self, selector: #selector(kayBoardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        //Teclado vai desaparecer
        NotificationCenter.default.addObserver(self, selector: #selector(kayBoardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(finalizarModoEdicao))
        self.contentView.addGestureRecognizer(gesture)
        
        self.imageViewPessoa.layer.cornerRadius = self.imageViewPessoa.frame.size.width / 2
        self.imageViewPessoa.layer.masksToBounds = true
        
        self.configurarPickerView()
        self.criarToobar()
    }
    
    func kayBoardWillShow(notification: NSNotification){
        
        var userInfo = notification.userInfo
        let keyBoardFrame: CGRect = (userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        print(keyBoardFrame)
        
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        //contentInset.bottom = keyBoardFrame.size.height
        contentInset.bottom = 260

        self.scrollView.contentInset = contentInset
        
        
    }
    
    func finalizarModoEdicao(){
        self.view.endEditing(true)
    }
    
    func kayBoardWillHide(){
        let contentInsert: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.scrollView.contentInset = contentInsert
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func configurarPickerView(){
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.generoTextField.inputView = self.pickerView
        self.generoTextField.delegate = self
    }
    
    func criarToobar(){
        let toobar = UIToolbar()
        toobar.barStyle = .default
        toobar.sizeToFit()
        
        let okBotao = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(selecionarGenero))
        let cancelarBotao = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(cancelarSelecaoDeGenero))
        let espacoBotao = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toobar.setItems([cancelarBotao, espacoBotao, okBotao], animated: false)
        self.generoTextField.inputAccessoryView = toobar
    }
    
    func selecionarGenero(){
        self.generoTextField.resignFirstResponder()
    }
    
    func cancelarSelecaoDeGenero(){
        self.generoTextField.text = ""
        self.generoTextField.resignFirstResponder()
    }
    
    @IBAction func actionAddFoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        _ = PHPhotoLibrary.authorizationStatus()
        
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func actionIdade(_ sender: UISlider) {
        
        let idade = Int(sender.value)
        var str = "anos"
        if idade <= 1 {
            str = "ano"
        }
        self.idadeLabel.text = "Idade: \(idade) \(str)"
        self.idadePessoa = idade
        
    }
    
    @IBAction func actionSalvar(_ sender: Any) {
        
        if let errorMessage = self.validarCampos() {
            let alerta = UIAlertController(title: "Erro", message: errorMessage, preferredStyle: .alert)
            let okBotao = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alerta.addAction(okBotao)
            self.present(alerta, animated: true, completion: nil)
            return
        }
        
        /*let pessoa = Pessoa(nomeDaPessoa: self.nomeTextField.text!, generoDaPessoa: self.generoTextField.text!, idadeDaPessoa: self.idadePessoa, telefoneDaPessoa: self.telefoneTextField.text!, enderecoDaPessoa: self.enderecoTextField.text!, fotoDaPessoa: self.imageViewPessoa.image!)
        listaDePesso.append(pessoa)*/
        self.savePessoaNoBanco()
        self.navigationController?.popViewController(animated: true)
        
    }
     
    func savePessoaNoBanco () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let gerente = appDelegate.persistentContainer.viewContext
        
        let pessoa = NSEntityDescription.insertNewObject(forEntityName: "Pessoas", into: gerente)
        pessoa.setValue(self.nomeTextField.text, forKey: "nome")
        pessoa.setValue(self.generoTextField.text, forKey: "genero")
        pessoa.setValue(self.idadePessoa, forKey: "idade")
        pessoa.setValue(self.enderecoTextField.text, forKey: "endereco")
        pessoa.setValue(self.telefoneTextField.text, forKey: "telefone")
        pessoa.setValue(false, forKey: "locou")
        
        let foto = UIImagePNGRepresentation(self.imageViewPessoa.image!)
        pessoa.setValue(foto, forKey: "foto")
        do {
            try gerente.save()
        } catch {
            print("Erro ao salvar pessoa")
        }
    }

    
    func concatenar(original: String?, novaMensagem: String) -> String {
        var resultado = original
        if resultado == nil {
            resultado = novaMensagem
        } else {
            resultado = "\(resultado!)\n\(novaMensagem)"
        }
        
        return resultado!
    }
    
    func validarCampos() -> String? {
        
        var resultado: String?
        if self.nomeTextField.text == ""{
            resultado = self.concatenar(original: resultado, novaMensagem: "Digite um nome")
        }
        if self.generoTextField.text == ""{
            resultado = self.concatenar(original: resultado, novaMensagem: "Selecione um genero")
        }
        if self.telefoneTextField.text == ""{
            resultado = self.concatenar(original: resultado, novaMensagem: "Digite um telefone")
        }
        if self.enderecoTextField.text == ""{
        resultado = self.concatenar(original: resultado, novaMensagem: "Digite um endereço")
        }
        if self.imageViewPessoa.image == nil {
            resultado = self.concatenar(original: resultado, novaMensagem: "Selecione uma imagem")
        }
        if idadePessoa < 18 {
            resultado = self.concatenar(original: resultado, novaMensagem: "É preciso ter mais de 18 anos para realizar o cadastro")
        }
        
        return resultado
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageViewPessoa.image = image
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.arrayGenero.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrayGenero[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.generoTextField.text = self.arrayGenero[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.generoTextField.text = self.arrayGenero[self.pickerView.selectedRow(inComponent: 0)]
    }
    
    

}
