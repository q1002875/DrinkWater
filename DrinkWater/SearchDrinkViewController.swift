//
//  SearchDrinkViewController.swift
//  DrinkWater
//
//  Created by 徐志豪 on 2018/12/8.
//  Copyright © 2018 orange. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct name:Decodable {
    let 地址 :String
    let 飲水點名稱:String
    let 飲水機所在地:String
    
}
class SearchDrinkViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var address : [String] = []
    var drinkname : [String] = []
    var drinkpoint : [String] = []
    
    @IBOutlet weak var mainMapView: MKMapView!
    //使用位置管理器獲取用戶位置
    let locationManager = CLLocationManager()
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       
        
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        let capital = view.annotation as! Capital
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let url = URL(string: "http://opendata.hccg.gov.tw/dataset/64cb7d6d-692e-4312-a4a5-931b902680d5/resource/9fcbba71-4e28-47c3-8d29-6e85c24e3415/download/20171206102431392.json"){
            
            let session = URLSession.shared
            let request = URLRequest(url:url)
            let task = session.dataTask(with: request) { (data, response, error) in
                do{
                    let address = try JSONDecoder().decode([name].self, from: data!)
                    
                    for countr in address{
                        
                        self.address.append(countr.地址)
                        self.drinkname.append(countr.飲水點名稱)
                        self.drinkpoint.append(countr.飲水機所在地)
                    }
                
                    for index in 0...self.address.count-1{
                        let geoCoder = CLGeocoder()
                        geoCoder.geocodeAddressString(self.address[index], completionHandler: {
                            placemarks, error in
                            if error != nil {
                                print("\(String(describing: error))")
                                return
                            }
                            if let placemarks = placemarks {
                                // 取得第一個座標
                                let placemark = placemarks[0]
                                // 加上地圖標註
                                let annotation = MKPointAnnotation()
                                annotation.title = self.drinkpoint[index]
                                annotation.subtitle = self.drinkname[index]
                                if let location = placemark.location {
                                    // 顯示標註
                                    annotation.coordinate = location.coordinate
                                    
                                    self.mainMapView.showAnnotations([annotation], animated: true)
                                    self.mainMapView.selectAnnotation(annotation, animated: true)
                                    
                                }
                            }
                        })
                        
                    }
                }catch{
                    print("\(error)")
                    
                }
            }
            task.resume()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainMapView.showsUserLocation = true
        mainMapView.delegate = self
        
        locationManager.delegate = self
        
        //最好的精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //取得用戶授權
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        //開始放大地圖畫面
        let latitude :CLLocationDegrees = 23.702290
        let longitude:CLLocationDegrees = 120.537034
        
        let latDleta :CLLocationDegrees = 0.0005
        let lotDleta :CLLocationDegrees = 0.0005
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDleta, longitudeDelta: lotDleta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        mainMapView.setRegion(region, animated: true)
        
        
   
    }
   
    
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //持續更新user位置
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            let userLocation :CLLocation = locations[0]
//            
//            let latitude : CLLocationDegrees = userLocation.coordinate.latitude
//            let longitude : CLLocationDegrees = userLocation.coordinate.longitude
//            
//            let span :MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            
//            let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            
//            let region :MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
//            mainMapView.setRegion(region, animated: true)
//            
//        }
    }
    
    
    
    
    
    
    
}
