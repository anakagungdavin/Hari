//
//  CustomUI.swift
//  Heal
//
//  Created by Anak Agung Gede Agung Davin on 21/10/22.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// example of implementation .custCornerRadius(10, corners: .allCorners) .custCornerRadius(30, corners: .bottomLeft)
extension View {
    func custCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
