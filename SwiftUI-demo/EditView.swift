//
//  EditView.swift
//  SwiftUI-demo
//
//  Created by 李君 on 2020/6/3.
//  Copyright © 2020 李君. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    
    @ObservedObject var selectPlace: MKPointAnnotation
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("输入标题", text: $selectPlace.wrapperedTitle)
                    TextField("输入描述", text: $selectPlace.wrapperedSubTitle)
                }
            }
            .navigationBarTitle("编辑")
            .navigationBarItems(trailing: Button("完成") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

