//
//  ViewController.swift
//  Sunex_Trendyol
//
//  Created by User on 18.04.25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionview:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bildirişlər"
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(TrendyOlCollectionVCcell.nib, forCellWithReuseIdentifier: TrendyOlCollectionVCcell.identifier)

    }

    @IBAction func trendyolButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: TrendyolViewController.identifier) as? TrendyolViewController  else {
            return
        }
          vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendyOlCollectionVCcell.identifier, for: indexPath) as? TrendyOlCollectionVCcell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    // "isRead": false - eger true gelirse solgun olmalidi o collectionview
}
