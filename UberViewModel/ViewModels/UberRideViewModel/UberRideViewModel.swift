//
//  UberRideViewModel.swift
//  OsirisBio
//
//  Created by Puneet Mahajan on 16/10/18.
//  Copyright © 2018 Biz4Solutions. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UberRides
import CoreLocation

private protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}

class UberRideViewModel: ViewModelType {

    var input: Input
    var output: Output
    let disposeBag = DisposeBag()
    
    struct Input {
        let uberButtonTap: Observable<Void>?
        
        // Variables for uber rides
        var pickupLocation: CLLocationCoordinate2D?
        var dropoffLocation: CLLocationCoordinate2D?
        var dropoffNickname: String? = ""
        var dropoffAddress: String? = ""
    }
    
    struct Output {
        var errordata : Observable<String>
    }
    
    private let errorResultSubject = PublishSubject<String>()
    private let uberButtonTapSubject = PublishSubject<Void>()
    
    init() {
        self.input = Input.init(uberButtonTap: uberButtonTapSubject.asObserver(), pickupLocation: nil, dropoffLocation: nil, dropoffNickname: nil, dropoffAddress: nil)
        self.output = Output(errordata: errorResultSubject.asObservable())
    }
}

extension UberRideViewModel {
    
    func bookUber(input: Input) -> Output {
        
        self.input = input
        self.output = Output(errordata: errorResultSubject.asObservable())
        self.goToUberApp()
        
        return output
    }
    
    func startObservingUberButton(input: Input) {
        input.uberButtonTap?.do(onNext: { [weak self] in
            print("tap onNext")
            self?.goToUberApp()
        }).subscribe({ (event) in
            print("tap subscribed")
        }).disposed(by: disposeBag)
    }
    
    func goToUberApp() {
        let builder = RideParametersBuilder()
        // ...
        builder.pickupLocation = CLLocation(latitude: self.input.pickupLocation?.latitude ?? 0.0, longitude: self.input.pickupLocation?.longitude ?? 0.0)
        builder.dropoffLocation = CLLocation(latitude: self.input.dropoffLocation?.latitude ?? 0.0, longitude: self.input.dropoffLocation?.longitude ?? 0.0)
        builder.pickupNickname = "Your Location"
        builder.dropoffNickname = self.input.dropoffNickname
        builder.dropoffAddress = self.input.dropoffAddress
        let rideParameters = builder.build()
        
        let deeplink = RequestDeeplink(rideParameters: rideParameters, fallbackType: .mobileWeb)
        deeplink.execute()
    }
}
