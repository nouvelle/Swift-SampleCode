//
//  MapViewController.swift
//  SampleBook
//
//  Created by eriko on 2022/03/27.
//

import UIKit
import MapKit
import CoreLocation

// CLLocationManagerDelegate: 許可ステータスに変更があった時に呼び出されるメソッドが定義されている
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    // 位置情報管理
    private let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        
        // ユーザの許可のステータスを確認: authorizedWhenInUse(アプリ使用中のみ許可ではない場合)
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            // 許可リクエストのアラートを上げる
            manager.requestWhenInUseAuthorization()
        }
    }
    
    // 許可ステータスが更新されたときに呼び出される
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 許可ステータスが authorizedWhenInUse になったら、現在地の取得を行う
        if status == .authorizedWhenInUse {
            manager.requestLocation()
//            manager.startUpdatingLocation()
        }
    }

    // requestLocation() によって現在地が取得されたら、現在地情報を取得できる
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations: ", locations)
        let current = locations[0]
        // 引数：locations の coordinateプロパティ、緯度・経度方向の表示範囲
        let region = MKCoordinateRegion(center: current.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        // ピンを生成
        let pin = MKPointAnnotation()
        pin.title = "現在地"
        pin.subtitle = "your location"
        pin.coordinate = current.coordinate
        mapView.addAnnotation(pin)
    }
    
    // 位置情報が正常に取得できなかったときに呼び出される
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }

}
