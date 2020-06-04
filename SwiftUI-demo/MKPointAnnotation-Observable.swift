//
//  MKPointAnnotation-Observable.swift
//  SwiftUI-demo
//
//  Created by 李君 on 2020/6/3.
//  Copyright © 2020 李君. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    
    public var wrapperedTitle: String {
        get {
            title ?? ""
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrapperedSubTitle: String {
        get {
            subtitle ?? ""
        }
        
        set {
            subtitle = newValue
        }
    }
}
