////
////  SearchDrinkViewController.swift
////  DrinkWater
////
////  Created by 徐志豪 on 2018/12/8.
////  Copyright © 2018 orange. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//
//struct name:Decodable {
//    let 地址 :String
//    let 飲水點名稱:String
//    let 飲水機所在地:String
//    
//}
//class SearchDrinkViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
//    
//    var address : [String] = []
//    var drinkname : [String] = []
//    var drinkpoint : [String] = []
//    var ann: MKPointAnnotation!
//    @IBAction func locationpoint(_ sender: Any) {
//        moveAndZoomMap()
//    }
//    
//    
//    
//    @IBOutlet weak var mainMapView: MKMapView!
//    //使用位置管理器獲取用戶位置
//    let locationManager = CLLocationManager()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        DownloadJsonAndShowAnnotations()
//        
//        mainMapView.showsUserLocation = true
//        mainMapView.delegate = self
//        
//        locationManager.delegate = self
//        
//        //最好的精確度
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        //取得用戶授權
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        //          locationManager.allowsBackgroundLocationUpdates = true
//        //        let user = mainMapView.userLocation.coordinate
//        //開始放大地圖畫面
//        let latitude :CLLocationDegrees = 24.981419
//        let longitude:CLLocationDegrees = 121.226977
//        //        let latitude :CLLocationDegrees = user.latitude
//        //        let longitude:CLLocationDegrees = user.longitude
//        let latDleta :CLLocationDegrees = 1
//        let lotDleta :CLLocationDegrees = 1
//        
//        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDleta, longitudeDelta: lotDleta)
//        
//        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        
//        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
//        
//        mainMapView.setRegion(region, animated: true)
//        moveAndZoomMap()
//        
//        
//    }
//    func moveAndZoomMap(){
//        guard let location = self.locationManager.location else{
//            print("Location is not ready")
//            return
//        }
//        //Move and zoom the map
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)//螢幕顯示地圖的範圍大小
//        let region = MKCoordinateRegion(center: location.coordinate, span: span)
//        self.mainMapView.setRegion(region, animated: true)
//    }
//    //按鈕設置
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        if annotation is MKUserLocation
//        {
//            return nil
//        }
//        
//        let reuseId = "annotionView"
//        var resultView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? EGImageAnnotionView
//        if resultView == nil {
//            //            resultView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            let annotionImage = UIImage(named: "pointRed.png")
//            resultView = EGImageAnnotionView(annotation: annotation, reuseIdentifier: reuseId,image:annotionImage)
//        }
//        else {
//            resultView!.annotation = annotation
//        }
//        
//        // Setup it
//        resultView!.canShowCallout = true
//        let button:UIButton = UIButton(type: .detailDisclosure)
//        
//        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
//        
//        resultView!.rightCalloutAccessoryView = button as UIView
//        //換地圖照片
//        let leftImage = UIImage(named: "pointRed.png")
//        
//        resultView!.leftCalloutAccessoryView = UIImageView(image: leftImage)
//        
//        return resultView
//    }
//    @objc func buttonTapped(sender:UIButton!)
//    {
//        
//        let alert = UIAlertController(title: nil, message: "導航前往這個地點?", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default){(action) in
//            
//            let target = self.currentpoint
//            self.navigate(target)
//            
//        }
//        
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        present(alert,animated: true)
//        
//    }
//    //導航
//    func navigate( _ target:String){
//        
//        let geocoder1 = CLGeocoder()
//        //address - >lat/lon住址查經緯
//        geocoder1.geocodeAddressString(target){(placemarks ,error) in
//            if let error = error {
//                print("geocodeaddressString:fail\(error)")
//                return
//            }
//            guard let placemark = placemarks?.first,
//                let coordinate = placemark.location?.coordinate else{
//                    assertionFailure("placemark id empty or nil")
//                    return
//            }
//            print("My Home\(coordinate.latitude),\(coordinate.longitude)")
//            
//            //location
//            let user = self.mainMapView.userLocation.coordinate
//            let sourcecoordinate = CLLocationCoordinate2DMake(user.latitude,user.longitude)
//            let sourdePlacemark = MKPlacemark(coordinate: sourcecoordinate)
//            let sourceMapItem = MKMapItem(placemark: sourdePlacemark)
//            
//            //prepare taarget map item導航
//            let targetPlacemark = MKPlacemark(placemark: placemark)
//            let targetMapItem = MKMapItem(placemark: targetPlacemark)
//            //設為步行driving
//            let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
//            //            targetMapItem.openInMaps(launchOptions: options)
//            
//            //兩點的路徑距離
//            MKMapItem.openMaps(with: [sourceMapItem,targetMapItem], launchOptions: options)
//        }
//    }
//    
//    
//    var currentpoint :String = ""
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if let annotation = view.annotation?.subtitle {
//            currentpoint = annotation ?? ""
//        }
//    }
//    
//    func DownloadJsonAndShowAnnotations(){
//        if let url = URL(string: "http://opendata.hccg.gov.tw/dataset/64cb7d6d-692e-4312-a4a5-931b902680d5/resource/9fcbba71-4e28-47c3-8d29-6e85c24e3415/download/20171206102431392.json"){
//            let session = URLSession.shared
//            let request = URLRequest(url:url)
//            let task = session.dataTask(with: request) { (data, response, error) in
//                do{
//                    let address = try JSONDecoder().decode([name].self, from: data!)
//                    
//                    for countr in address{
//                        
//                        self.address.append(countr.地址)
//                        self.drinkname.append(countr.飲水點名稱)
//                        self.drinkpoint.append(countr.飲水機所在地)
//                    }
//                    
//                    for index in 0...self.address.count-1{
//                        let geoCoder = CLGeocoder()
//                        geoCoder.geocodeAddressString(self.address[index], completionHandler: {
//                            placemarks, error in
//                            if error != nil {
//                                print("\(String(describing: error))")
//                                return
//                            }
//                            if let placemarks = placemarks {
//                                // 取得第一個座標
//                                let placemark = placemarks[0]
//                                // 加上地圖標註
//                                let annotation = MKPointAnnotation()
//                                annotation.subtitle = self.address[index]
//                                annotation.title = self.drinkname[index]
//                                
//                                if let location = placemark.location {
//                                    // 顯示標註
//                                    annotation.coordinate = location.coordinate
//                                    //存到一個地方再一次show
//                                    self.mainMapView.addAnnotation(annotation)
//                                    //                                    self.mainMapView.selectAnnotation(annotation, animated: true)
//                                }
//                            }
//                        })
//                        
//                    }
//                }catch{
//                    print("\(error)")
//                    
//                }
//            }
//            task.resume()
//        }
//        
//    }
//    
//    
//    
//}
