//
//  BooksTableViewCell.swift
//  KavakTest
//
//  Created by Mauricio Zarate on 16/05/22.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    static let identifier = "BooksTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setUpConstraints()

     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    let bookImg:UIImageView = {
             let img = UIImageView()
             img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
             img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
             img.layer.cornerRadius = 35
             img.clipsToBounds = true
            return img
         }()
    
    
    let nameLabel:UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.textColor =  .orange
           
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
    }()
    
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()
  
    
    func setUpConstraints() {
        
        self.contentView.addSubview(bookImg)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(containerView)
        
        bookImg.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        bookImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        bookImg.widthAnchor.constraint(equalToConstant: 70).isActive = true
        bookImg.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: bookImg.trailingAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
      
    }

}
