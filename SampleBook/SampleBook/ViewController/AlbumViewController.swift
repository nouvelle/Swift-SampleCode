//
//  AlbumViewController.swift
//  SampleBook
//
//  Created by eriko on 2022/03/27.
//

import UIKit
import Photos

// UICollectionViewDelegateFlowLayout: UICollectionViewDelegate を継承したプロトコル
class AlbumViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 写真データを保存するための配列
    var photos: [PHAsset] = []
    // 画像データを取得するための PHImageManager インスタンスをプロパティとして保持
    let manager = PHImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // タップした時の操作など捜査に関する処理・セルのサイズやマージンなどのレイアウトに関する処理を委譲する
        collectionView.delegate = self
        // 要素数やセルの元となるクラスなどといったデータの元となる処理を委譲する
        collectionView.dataSource = self
        // ユーザに写真のアクセス許可を求めるリクエスト
        PHPhotoLibrary.requestAuthorization { status in
            // 許可のステータスが変わったら実行される：許可されたら loadPhotos を実行する
            if status == .authorized {
                self.loadPhotos()
            }
        }
    }
    
    // 写真データの読み込み処理を行う
    func loadPhotos() {
        // fetchAssets: メディアの情報を取得する（戻り値: PHFetchResult...写真データの集まり）
        let result = PHAsset.fetchAssets(with: .image, options: nil)
        // 0からindex までのインデックスが含まれた IndexSet インスタンスを生成(result.count: 写真データの数)
        let indexSet = IndexSet(integersIn: 0...result.count - 1)
        // IndexSet インスタンスを設定して、PHAsset の配列を取り出す
        photos = result.objects(at: indexSet)
        // 非同期処理で処理を実行
        DispatchQueue.main.sync {
            // UICollectionView の再読み込み（見た目に反映）
            collectionView.reloadData()
        }
    }
    
    // numberOfItemsInSection: セルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // cellForItemAt: 対象のインデックスに対応する UICollectionViewCell インスタンスを返す
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        let asset = photos[indexPath.item]
        let width = collectionView.bounds.size.width / 3
        manager.requestImage(for: asset, targetSize: CGSize(width: width, height: width), contentMode: .aspectFill, options: nil, resultHandler: { result, info in
            if let image = result {
                let imageView = cell.viewWithTag(1) as! UIImageView
                imageView.image = image
            }
        })
        return cell
    }
    
    // 対象のインデックスに対応するセルの大きさを返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横３列のタイルを表示したいので、collectionViewの幅を３で割った値をセルのサイズとして返す
        let width = collectionView.bounds.size.width / 3
        // CGSize: セルのサイズ（width, height)を持つ
        return CGSize(width: width, height: width)
    }
    
    // 横のマージンの値を返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    // 縦のマージンの値を返す
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

}
