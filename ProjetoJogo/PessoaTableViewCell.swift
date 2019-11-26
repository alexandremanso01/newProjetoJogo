//
//  PessoaTableViewCell.swift
//  ProjetoJogo
//
//  Created by Home on 15/12/2017.
//  Copyright © 2017 Mctech Aluno. All rights reserved.
//

import UIKit

class PessoaTableViewCell: UITableViewCell {

  
    @IBOutlet weak var viewFundo: UIView!
    @IBOutlet weak var imageViewPessoa: UIImageView!
    @IBOutlet weak var labelNomePessoa: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageViewPessoa?.layer.cornerRadius = self.imageViewPessoa.frame.height / 2
        self.imageViewPessoa.layer.masksToBounds = true
        
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
