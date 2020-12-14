//
//  PicsumTableViewCell.swift
//  LoremPicsumTable
//
//  Created by Field Employee on 12/9/20.
//

import UIKit

class PicsumTableViewCell: UITableViewCell {

    @IBOutlet weak var picsumImageView: UIImageView!
    @IBOutlet weak var picsumImageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with loremPicsum: LoremPicsum) {
        self.picsumImageLabel.text = "ID: " + loremPicsum.id
        NetworkManager.shared.getImageData(from: loremPicsum.url){
            (data, error) in guard let data = data else { return }
            DispatchQueue.main.async {
                self.picsumImageView.image = UIImage(data: data)
            }
        }
    }
}
