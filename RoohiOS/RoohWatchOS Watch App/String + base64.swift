//
//  String + base64.swift
//  RoohWatchOS Watch App
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation
import SwiftUI

extension String {
    
    func base64Convert() -> Image {
        if (self.isEmpty) {
            return Image(systemName: Constant.genericDefaultImage)
        } else {
            let temp = self.components(separatedBy: ",")
            guard let dataDecoded = Data(base64Encoded: temp[1], options: .ignoreUnknownCharacters),
                  let uiImage = UIImage(data: dataDecoded),
                  let cgImage = uiImage.cgImage else {
                return Image(systemName: Constant.genericDefaultImage)
            }
            return Image(uiImage: UIImage(cgImage: cgImage))
        }
    }
    
    
    private enum Constant {
        static let genericDefaultImage = "text.below.photo"
    }
}
