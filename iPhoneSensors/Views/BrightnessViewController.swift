//
//  BrightnessViewController.swift
//  iPhoneSensors
//
//  Created by Atsushi Otsubo on 2020/12/10.
//

import UIKit

class BrightnessViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var brightnessInfomations: [KeyValue] = [KeyValue(key: "", value: "値の取得中...")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureBrightness()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIScreen.brightnessDidChangeNotification,
                                                  object: nil)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(KeyValueCell.nib(), forCellWithReuseIdentifier: KeyValueCell.reuseIdentifier)
    }
    
    private func configureBrightness() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(brightnessChanged(_:)),
                                               name: UIScreen.brightnessDidChangeNotification,
                                               object: nil)
    }
    
}

extension BrightnessViewController {
    @objc func brightnessChanged(_ notification: Notification) {
        brightnessInfomations.removeAll()
        if let screenObject = notification.object {
            // print((screenObject as AnyObject).brightness)
            let brightness = (screenObject as AnyObject).brightness
            brightnessInfomations.append(KeyValue(key: "輝度 (0.0〜1.0)", value: brightness?.toString ?? "N/A"))
        }
        collectionView.reloadData()
    }
}

extension BrightnessViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brightnessInfomations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyValueCell.reuseIdentifier, for: indexPath) as! KeyValueCell
        let infomation = brightnessInfomations[indexPath.row]
        cell.setup(key: infomation.key, value: infomation.value, unit: infomation.unit)
        return cell
    }
}

extension BrightnessViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: KeyValueCell.cellHeight)
    }
}


