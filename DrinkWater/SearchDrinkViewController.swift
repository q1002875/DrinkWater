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
class SearchDrinkViewController: UIViewController {

    @IBOutlet weak var mainMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMapView.delegate = self
        
        //檢查user是否有啟動定位服務
        
        //guard如果成立就過關不成立就出去
        guard CLLocationManager.locationServicesEnabled() else{
            //沒有的話給些提示
            
            return
        }
        
        
        //取得user授權
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        //期待的精確度 越精確躍耗電
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.startUpdatingLocation()
        
        //取得背景多工持續取的位置
        locationManager.allowsBackgroundLocationUpdates = true
     
    }
    
    //ram不夠會通知這個方法釋放記憶體
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //比viewdidload畫面出現後去做的
    //移動地圖兼放大
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveAndZoomMap()
    }
    
    func moveAndZoomMap(){
        //拿到位置
        guard let location = locationManager.location else{
            print("Location is not ready")
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        //span決定縮放大小
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mainMapView.setRegion(region, animated: true)
        
        //add annotation
        
        var storeCoordinate = location.coordinate
        storeCoordinate.latitude += 0.005
        
        storeCoordinate.longitude += 0.005
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = storeCoordinate
        annotation.title = "肯德基"
        annotation.subtitle = "真好吃"
        mainMapView.addAnnotation(annotation)
        
    }


}
extension SearchDrinkViewController: CLLocationManagerDelegate{
    
    //mark:cllocationmanagerdelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let coordinate = locations.last?.coordinate else {
            assertionFailure("Invalid location or coordinate")
            return
        }
        print("Current location:\(coordinate.latitude),\(coordinate.longitude)")
    }
    
}


extension SearchDrinkViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.region.center
        print("Map center moved to : \(coordinate.latitude),\(coordinate.longitude)")
    }
    
    
    //回復舊版大頭針
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //維持藍點點
        if annotation is MKUserLocation{
            return nil
        }
        let storeID = "store"
        //        var result = mapView.dequeueReusableAnnotationView(withIdentifier: storeID)as? MKPinAnnotationView克制自己的圖案
        var result = mapView.dequeueReusableAnnotationView(withIdentifier: storeID)
        if result == nil {
            //            result = MKPinAnnotationView(annotation: annotation, reuseIdentifier: storeID)
            result = MKAnnotationView(annotation: annotation, reuseIdentifier: storeID)
        }else{
            result?.annotation = annotation
        }
        
        //解除canShowCallout
        result?.canShowCallout = true
        //        result?.animatesDrop = true
        //        result?.pinTintColor = .purple
        
        //show image
        
        let image = UIImage(named: "pointRed.png")
        result?.image = image
        
        
        let imageview = UIImageView(image: image)
        result?.leftCalloutAccessoryView = imageview
        
        //right-callout accessory view
        let calloutBtn = UIButton(type: .detailDisclosure)
        calloutBtn.addTarget(self, action: #selector(calloutbtnPressed(sender:)), for: .touchUpInside)
        result?.rightCalloutAccessoryView = calloutBtn
        return result
    }
    //點泡泡
    @objc
    func calloutbtnPressed(sender:Any){
        //        print("calloutbtnpressed executed.")
        
        let alert = UIAlertController(title: nil, message: "導航前往這個地點?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default){(action) in
            self.navigateHome()
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert,animated: true)
        
        
    }
    
    //經緯度轉住址
    func navigateHome(){
        let target = "新竹縣新豐鄉山崎村信義街18巷24號"
        let geocoder1 = CLGeocoder()
        
        //address - >lat/lon住址查經緯
        
        geocoder1.geocodeAddressString(target){(placemarks ,error) in
            if let error = error {
                print("geocodeaddressString:fail\(error)")
                return
                
            }
            guard let placemark = placemarks?.first,
                let coordinate = placemark.location?.coordinate else{
                    assertionFailure("placemark id empty or nil")
                    return
                    
            }
            print("My Home\(coordinate.latitude),\(coordinate.longitude)")
            
            //prepare source map item
            let sourcecoordinate = CLLocationCoordinate2DMake(24.79898676474714, 120.98698700000018)
            let sourdePlacemark = MKPlacemark(coordinate: sourcecoordinate)
            let sourceMapItem = MKMapItem(placemark: sourdePlacemark)
            
            //prepare taarget map item導航
            let targetPlacemark = MKPlacemark(placemark: placemark)
            let targetMapItem = MKMapItem(placemark: targetPlacemark)
            //設為步行driving
            let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            //            targetMapItem.openInMaps(launchOptions: options)
            
            //兩點的路徑距離
            MKMapItem.openMaps(with: [sourceMapItem,targetMapItem], launchOptions: options)
        }
        
        //address - >lon/lat住址茶經緯
        let geocoder2 = CLGeocoder()
        let location = CLLocation(latitude: 24.874782, longitude: 120.998108)
        geocoder2.reverseGeocodeLocation(location){(placemarks,error) in
            if let error = error {
                print("geocodeaddressString:fail\(error)")
                return
                
            }
            guard let placemark = placemarks?.first,
                let postalcode = placemark.postalCode,
                let thoroughfare = placemark.thoroughfare
                else{
                    assertionFailure("placemark id empty or nil")
                    return
                    
            }
            print("placemark:\(placemark.description),postalcode:\(postalcode),thoroughfare:\(thoroughfare)")
        }
    }
    
}
