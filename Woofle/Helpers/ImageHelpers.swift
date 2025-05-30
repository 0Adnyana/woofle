//
//  ImageHelpers.swift
//  Woofle
//
//  Created by IP Marry Kusuma on 29/05/25.
//

import UIKit
import ImageIO
import MobileCoreServices

func extractFramesFromGIF(named gifName: String) -> [UIImage]? {
    guard let path = Bundle.main.path(forResource: gifName, ofType: "gif"),
          let data = NSData(contentsOfFile: path),
          let source = CGImageSourceCreateWithData(data, nil) else {
        return nil
    }

    var images: [UIImage] = []

    let frameCount = CGImageSourceGetCount(source)

    for index in 0..<frameCount {
        if let cgImage = CGImageSourceCreateImageAtIndex(source, index, nil) {
            let frame = UIImage(cgImage: cgImage)
            images.append(frame)
        }
    }

    return images
}
