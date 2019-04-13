//
//  ViewController.swift
//  mapkitnoite
//
//  Created by student on 12/04/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locacionManager = CLLocationManager()
    var userLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.showsUserLocation = true
        
        addGesture()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Primeira funcao - Funcoes que adiciona precisao, e pede autorizacao para usar o map
    
    func setupLocationManager(){
        //pegar a melhor precisao
        
        locacionManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Pede autorizacao de uso para a sua localizacao
        
        locacionManager.requestWhenInUseAuthorization()
        
        //Para sempre atualizar a sua localizacao
        locacionManager.startUpdatingLocation()
        
    }
    
    func addGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnotation(gesture:)))
        
        longPress.minimumPressDuration = 1.0
        
        mapView.addGestureRecognizer(longPress)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Checando se o array esta vazio
        if locations.count > 0 {
            //desempacotando
            if let location = locations.last {
                userLocation = location
                print("A localizacao do usuario eh: \(userLocation.coordinate)")
            }
        }
    }
    //Reconhece qualquer gesto realizado na tela do dispositivo
    func addAnotation(gesture: UIGestureRecognizer){
        //Constante que recebe o toque realizado na tela do dispositivo
        let touchPoint = gesture.location(in: mapView)
        
        let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Hackatruck"
        newAnnotation.subtitle = String(describing: "Latiture \(newCoordinate.latitude) / Longitude \(newCoordinate.longitude)")
        
        mapView.addAnnotation(newAnnotation)
        
        
        
    
    }

}
