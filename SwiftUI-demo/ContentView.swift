//
//  ContentView.swift
//  SwiftUI-demo
//
//  Created by 李君 on 2020/6/3.
//  Copyright © 2020 李君. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingPlaceDetail = false
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingEditPlace = false

    var body: some View {
        ZStack {
              
            MapView(centerCoordibate: $centerCoordinate,
                    annotations: locations,
                    showingPlaceDetail: $showingPlaceDetail,
                    selectedPlace: $selectedPlace)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30)
                .opacity(0.3)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let annotation = CodableMKPointAnnotation()
                        annotation.coordinate = self.centerCoordinate
                        
                        self.locations.append(annotation)
                        
                        self.selectedPlace = annotation
                        self.showingEditPlace = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetail) {
            Alert(title: Text(selectedPlace?.title ?? "无标题"), message: Text(selectedPlace?.subtitle ?? "无描述"), primaryButton: .default(Text("好的")), secondaryButton: .default(Text("编辑")) {
                    self.showingEditPlace = true
                })
        }
        .sheet(isPresented: $showingEditPlace, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(selectPlace: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        let fileNames = getDocumentDirectory().appendingPathComponent("placemark")
        do {
            let data = try Data(contentsOf: fileNames)
            self.locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("读取失败")
        }
    }
    
    func saveData() {
        let fileNames = getDocumentDirectory().appendingPathComponent("placemark")
        do {
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileNames)
        } catch {
            print("保存失败")
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
