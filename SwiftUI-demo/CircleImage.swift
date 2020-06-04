//
//  CircleImage.swift
//  SwiftUI-demo
//
//  Created by 李君 on 2020/6/3.
//  Copyright © 2020 李君. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("icon_shape")
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
