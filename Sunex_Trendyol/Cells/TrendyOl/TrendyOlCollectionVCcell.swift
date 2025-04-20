//
//  TrendyOlCollectionVCcell.swift
//  Sunex_Trendyol
//
//  Created by User on 18.04.25.
//

import UIKit

class TrendyOlCollectionVCcell: UICollectionViewCell {

      @IBOutlet weak var imageview: UIImageView!
      @IBOutlet weak var titleLabel: UILabel!
      @IBOutlet weak var subtitleLabel: UILabel!
      @IBOutlet weak var dateLabel: UILabel!
      
      override func awakeFromNib() {
          super.awakeFromNib()
      }
      
      struct Item {
          var image:String
          var title:String
          var subtitle:String
          var date:String
      }
      
      func configure(with item:Item){
          imageview.image = UIImage(named: item.image)
          titleLabel.text = item.title
          subtitleLabel.text = item.subtitle
          dateLabel.text = item.date
      }
}
