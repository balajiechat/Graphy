//
//  GAVideoDataManager.swift
//  GraphyAssignment
//
//  Created by Balaji S on 07/05/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit
import Photos

class GAVideoDataManager {

    static func downloadAndSaveVideo(url: URL, completion: @escaping (_ fileLocation: URL) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
            let filePath="\(documentsPath)/\(url.lastPathComponent)"
            if !FileManager.default.fileExists(atPath: filePath) {
                if let urlData = NSData(contentsOf: url) {
                    DispatchQueue.main.async {
                        urlData.write(toFile: filePath, atomically: true)
                        PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                            if authorizationStatus == .authorized {
                                PHPhotoLibrary.shared().performChanges({
                                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(fileURLWithPath: filePath))
                                }) { completed, error in
                                    if completed {
                                        completion(URL(fileURLWithPath: filePath))
                                    }
                                }
                            }
                        })
                    }
                }
            } else {
                completion(URL(fileURLWithPath: filePath))
            }
        }
    }

}
