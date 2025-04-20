//
//  TrendyolViewController.swift
//  Sunex_Trendyol
//
//  Created by User on 18.04.25.
//

import UIKit

class TrendyolViewController: UIViewController {
    
    @IBOutlet weak var collectionview:UICollectionView!
    @IBOutlet weak var bannerView: UIView!
    private var notifications: [TrendyOlModel.Notification] = []
    private var navigation: [Any] = []
    private var viewModel = TrendyolViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bildirişlər"
        self.navigationItem.hidesBackButton = true
        bannerView.layer.cornerRadius = 14
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(TrendyOlCollectionVCcell.nib, forCellWithReuseIdentifier: TrendyOlCollectionVCcell.identifier)
        viewModel.subscribe(self)
        viewModel.fetchNews()
    }
    
    @IBAction func sunexazButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: ViewController.identifier) as? ViewController  else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension TrendyolViewController: TrendyolViewModelDelegate {
    
    func render(_ state: TrendyolViewModel.State) {
        switch state {
        case .loading:
            print("Loading...")
        case .reset:
            self.navigation.removeAll()
        case .loaded(let newNotifications):
            self.notifications.append(contentsOf: newNotifications)
            DispatchQueue.main.async {
                self.collectionview.reloadData()
            }
        case .error(let error):
            print("Error: \(error.localizedDescription)")
        }
    }
}
extension TrendyolViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendyOlCollectionVCcell.identifier, for: indexPath) as? TrendyOlCollectionVCcell else {
            return UICollectionViewCell()
        }
        let notification = notifications[indexPath.item]
        let item = TrendyOlCollectionVCcell.Item(
            image: "Frame 7820",
            title: notification.title,
            subtitle: notification.message,
            date: notification.createdAt
        )
        cell.configure(with: item, isRead: notification.isRead)
        return cell
    }
}
