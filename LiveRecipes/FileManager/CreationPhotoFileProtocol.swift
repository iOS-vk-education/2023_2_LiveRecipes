//
//  FileManagerProtocol.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//

import Foundation

protocol CreationPhotoFileProtocol: AnyObject {
    func savePhoto(imageData: Data, completion: @escaping (String?) -> Void)
    func removePhoto(ref: String, completion: @escaping (Bool) -> Void)
    func getPhoto(ref: String, completion: @escaping (Data?) -> Void)
    func showAllFiles(completion: @escaping () -> Void)
}
