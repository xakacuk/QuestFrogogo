//
//  UserTableViewCell.swift
//  QuestrFrogogo
//
//  Created by Евгений Бейнар on 18.10.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit
import AlamofireImage

final class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.af_cancelImageRequest()
    }
    
    func configureCell(user: User) {
        let phImage = UIImage(named: "placeholder")
        fioLabel.text = "\(user.first_name) \(user.last_name)"
        emailLabel.text = "\(user.email)"
        
        guard let avatar = user.avatar_url else { return }
        guard let url = URL(string: avatar) else { return }
        avatarImageView.af_setImage(withURL: url, placeholderImage: phImage)
    }
    
}
