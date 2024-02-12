//
//  String + base64.swift
//  RoohiOS
//
//  Created by Cezar_ on 09.02.24.
//

import Foundation
import UIKit

extension String {
    
    func base64Convert() -> UIImage? {
       if (self.isEmpty) {
           return UIImage(systemName: Constant.genericDefaultImage)
       } else {
           let temp = self.components(separatedBy: ",")
           guard let dataDecoded: Data = Data(base64Encoded: temp[1], options: .ignoreUnknownCharacters) else {
               return UIImage(systemName: Constant.genericDefaultImage)
           }
           let decodedimage = UIImage(data: dataDecoded)
           return decodedimage!
       }
     }
    
    private enum Constant {
        static let genericDefaultImage = "text.below.photo"
    }
}
