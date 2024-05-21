//
//  FileManager.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//

import Foundation

class CreationPhotoFileManager: CreationPhotoFileProtocol {

    static let shared: CreationPhotoFileProtocol = CreationPhotoFileManager()

    func savePhoto(imageData: Data, completion: @escaping (String?) -> Void) {
        let uniqueImageName = UUID().uuidString + ".jpg"
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageFileURL = documentsDirectory.appendingPathComponent(uniqueImageName)
        do {
            try imageData.write(to: imageFileURL)
            completion(uniqueImageName)
            return
        } catch {
            print("ERROR[\(#function)]: file of photo [\(uniqueImageName)] has not been saved")
            completion(nil)
            return
        }
    }
    func removePhoto(ref: String, completion: @escaping (Bool) -> Void) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(false)
            return
        }
        let imageURL = documentsDirectory.appendingPathComponent(ref)
        do {
            try FileManager.default.removeItem(at: imageURL)
            print("DEBAG[\(#function)]: file of photo [\(ref)] has been removed")
            completion(true)
            return
        } catch {
            print("ERROR[\(#function)]: file of photo[\(ref)] has not been removed")
            completion(false)
            return
        }
    }
    func getPhoto(ref: String, completion: @escaping (Data?) -> Void) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(nil)
            return
        }
        let imageURL = documentsDirectory.appendingPathComponent(ref)
        do {
            let imageData = try Data(contentsOf: imageURL)
            completion(imageData)
        } catch {
            completion(nil)
        }
    }
    func showAllFiles(completion: @escaping () -> Void) {
        print(#function)
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion()
            return
        }
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            print("Files:")
            for fileURL in fileURLs {
                print(fileURL.lastPathComponent)
            }
            completion()
        } catch {
            print("ERROR[\(#function)]: while enumerating files \(documentsDirectory.path): \(error.localizedDescription)")
            completion()
        }
    }
}
