//
//  ViewController.swift
//  Sunex_Trendyol
//
//  Created by User on 18.04.25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionview:UICollectionView!
    private var viewModel = SunexAzViewModel()
    private var notifications: [SunexAzModel.Notification] = []
    private var navigation: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bildirişlər"
        self.navigationItem.hidesBackButton = true
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(SunexAzCollectionViewCell.nib, forCellWithReuseIdentifier: SunexAzCollectionViewCell.identifier)
        viewModel.subscribe(self)
        viewModel.fetchNews()
    }
    
    @IBAction func trendyolButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: TrendyolViewController.identifier) as? TrendyolViewController  else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: SunexAzViewModelDelegate {
    func render(_ state: SunexAzViewModel.State) {
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
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifications.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SunexAzCollectionViewCell.identifier, for: indexPath) as? SunexAzCollectionViewCell else {
            return UICollectionViewCell()
        }
        let notification = notifications[indexPath.item]
        let item = SunexAzCollectionViewCell.Item(
            image: "Frame 7820",
            title: notification.title,
            subtitle: notification.message,
            date: notification.createdAt
        )
        cell.configure(with: item, isRead: notification.isRead)
        return cell
    }
}
